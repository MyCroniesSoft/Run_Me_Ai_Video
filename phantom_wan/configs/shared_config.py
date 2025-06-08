# Copyright 2024-2025 The Alibaba Wan Team Authors. All rights reserved.
import torch
from easydict import EasyDict

# ------------------------ Wan shared config ------------------------ #
wan_shared_cfg = EasyDict()

# t5
wan_shared_cfg.t5_model = 'umt5_xxl'
wan_shared_cfg.t5_dtype = torch.bfloat16
wan_shared_cfg.text_len = 512

# transformer
wan_shared_cfg.param_dtype = torch.bfloat16

# inference
wan_shared_cfg.num_train_timesteps = 1000
wan_shared_cfg.sample_fps = 16

wan_shared_cfg.sample_neg_prompt = (
    'blurry, low resolution, low quality, jpeg artifacts, overexposed, underexposed, static, '
    'saturated colors, flat lighting, poor composition, cluttered background, crowded background, '
    'grayish tone, stylized, painted look, cartoonish, worst quality, ugly, deformed, frozen frame, '
    'facial distortion, malformed limbs, poorly drawn face, poorly drawn hands, extra fingers, fused fingers, '
    'mutated hands, missing limbs, unrealistic anatomy, walking backward, broken perspective, weird eyes, subtitles, text, watermark'
)
