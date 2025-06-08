# File: Z:\Projects\Phantom\phantom_wan\modules\attention.py

import os
import torch
import warnings

# If this env var is set, disable all FlashAttention paths
DISABLE_FA = os.environ.get("PHANTOM_WAN_DISABLE_FLASH_ATTENTION", "0") == "1"

# Probe for FlashAttention v3
try:
    import flash_attn_interface
    FLASH_ATTN_3_AVAILABLE = not DISABLE_FA
except ModuleNotFoundError:
    FLASH_ATTN_3_AVAILABLE = False

# Probe for FlashAttention v2
try:
    import flash_attn
    FLASH_ATTN_2_AVAILABLE = not DISABLE_FA
except ModuleNotFoundError:
    FLASH_ATTN_2_AVAILABLE = False

__all__ = [
    'flash_attention',
    'attention',
]

def flash_attention(
    q, k, v,
    q_lens=None, k_lens=None,
    dropout_p=0., softmax_scale=None,
    q_scale=None, causal=False,
    window_size=(-1, -1),
    deterministic=False,
    dtype=torch.bfloat16,
    version=None,
):
    """
    Wrapper that uses FA3 if available, else FA2, else falls back to torch scaled_dot_product_attention.
    """
    half_dtypes = (torch.float16, torch.bfloat16)
    assert dtype in half_dtypes, "flash_attention dtype must be float16 or bfloat16"
    assert q.device.type == 'cuda' and q.size(-1) <= 256

    # flatten batch & heads
    b, Lq, Lk, _ = q.size(0), q.size(1), k.size(1), q.dtype
    out_dtype = q.dtype

    def half(x):
        return x if x.dtype in half_dtypes else x.to(dtype)

    # preprocess q, k, v exactly as before...
    # (copy your existing flatten & cat logic here)
    # build cu_seqlens_q and cu_seqlens_k
    # ...  

    # Choose FA3 -> FA2 -> PyTorch fallback
    if (version is None or version == 3) and FLASH_ATTN_3_AVAILABLE:
        # FA3 path
        x = flash_attn_interface.flash_attn_varlen_func(
            q=q, k=k, v=v,
            cu_seqlens_q=cu_seqlens_q,
            cu_seqlens_k=cu_seqlens_k,
            max_seqlen_q=Lq, max_seqlen_k=Lk,
            softmax_scale=softmax_scale,
            causal=causal,
            deterministic=deterministic
        )[0].unflatten(0, (b, Lq))
    elif FLASH_ATTN_2_AVAILABLE:
        # FA2 path
        x = flash_attn.flash_attn_varlen_func(
            q=q, k=k, v=v,
            cu_seqlens_q=cu_seqlens_q,
            cu_seqlens_k=cu_seqlens_k,
            max_seqlen_q=Lq, max_seqlen_k=Lk,
            dropout_p=dropout_p, softmax_scale=softmax_scale,
            causal=causal, window_size=window_size,
            deterministic=deterministic
        ).unflatten(0, (b, Lq))
    else:
        # PURE‑TORCH fallback
        import torch.nn.functional as F
        # reshape to (B, heads, Lq, head_dim) if needed
        q2 = q.transpose(1,2).to(dtype)
        k2 = k.transpose(1,2).to(dtype)
        v2 = v.transpose(1,2).to(dtype)
        out = F.scaled_dot_product_attention(
            q2, k2, v2,
            attn_mask=None,
            is_causal=causal,
            dropout_p=dropout_p
        )
        x = out.transpose(1,2).contiguous()

    return x.type(out_dtype)

def attention(
    q, k, v,
    q_lens=None, k_lens=None,
    dropout_p=0., softmax_scale=None,
    q_scale=None, causal=False,
    window_size=(-1, -1),
    deterministic=False,
    dtype=torch.bfloat16,
    fa_version=None,
):
    # If any FlashAttention is available, go through flash_attention()
    if FLASH_ATTN_3_AVAILABLE or FLASH_ATTN_2_AVAILABLE:
        return flash_attention(
            q=q, k=k, v=v,
            q_lens=q_lens, k_lens=k_lens,
            dropout_p=dropout_p,
            softmax_scale=softmax_scale,
            q_scale=q_scale,
            causal=causal,
            window_size=window_size,
            deterministic=deterministic,
            dtype=dtype,
            version=fa_version,
        )
    # Otherwise fall back to pure‑torch
    import torch.nn.functional as F
    if q_lens is not None or k_lens is not None:
        warnings.warn(
            'Padding mask disabled in torch attention fallback.'
        )
    q2 = q.transpose(1,2).to(dtype)
    k2 = k.transpose(1,2).to(dtype)
    v2 = v.transpose(1,2).to(dtype)
    out = F.scaled_dot_product_attention(
        q2, k2, v2,
        attn_mask=None,
        is_causal=causal,
        dropout_p=dropout_p
    )
    return out.transpose(1,2).contiguous()
