@echo off
cd /d "%~dp0"
set PYTHONPATH=%CD%

:: 1) Activate Python virtual environment
call "venv\Scripts\activate"

:: 2) Optional: disable flash-attention
set PHANTOM_WAN_DISABLE_FLASH_ATTENTION=1

:: 3) CUDA settings
set CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8
set PATH=%CUDA_HOME%\bin;%PATH%

:: 4) Output folder
mkdir output 2>nul

:: 5) Enable delayed expansion
setlocal EnableDelayedExpansion

:: 6) Parameter grids
set "STEPS=150"
set "SHIFTS=1.25 1.5"
set "TXT_SCALES=7.5 9.0"
set "IMG_SCALES=3.0 3.5"

:: 7) Use fixed seed? (1 = fixed / 0 = random)
set "USE_FIXED_SEED=0"
set "FIXED_SEED=42"

:: 8) Prompts (simple, readable style)
set "PROMPT1=Scene 1: A is walking through the empty subway looking for the exit."
set "PROMPT2=Scene 2: a man with a gun walks through a quiet New York street looking for someone."
set "PROMPT3=Scene 3: Another man pulls out a gun and aims it at him."
set "PROMPT4=Scene 4: The two men stand close. The gun is between them. Tension builds."

:: 9) Process each folder (1–4)
for %%P in (1 2 3 4) do (
  call :ProcessFolder %%P
)
goto :EOF

:ProcessFolder
:: %1 is folder index
set "IDX=%1"
set "SRC_DIR=Z:\Projects\Phantom\drop_images_in\folder_%IDX%"
call set "PROMPT=!PROMPT%IDX%!"

echo.
echo ==== Folder %IDX%: "!SRC_DIR!" → Prompt %IDX% ====

:: 10) Build comma-separated list of reference images (up to 4)
set /A COUNT=0
set "REFS="
for %%I in ("%SRC_DIR%\*.png" "%SRC_DIR%\*.jpg") do (
  if !COUNT! LSS 4 (
    set /A COUNT+=1
    if defined REFS (
      set "REFS=!REFS!,""%%~fI"""
    ) else (
      set "REFS=""%%~fI"""
    )
  )
)

if !COUNT! EQU 0 (
  echo -- No images found in folder %IDX%; skipping.
  goto :EOF
)

echo -- Found !COUNT! image(s): !REFS!

:: 11) Create output subfolder
mkdir "output\folder%IDX%" 2>nul

:: 12) Run generation grid
for %%s in (%STEPS%) do (
  for %%h in (%SHIFTS%) do (
    for %%t in (%TXT_SCALES%) do (
      for %%i in (%IMG_SCALES%) do (

        if "!USE_FIXED_SEED!"=="1" (
          set "SEED=%FIXED_SEED%"
        ) else (
          set /A SEED=!random!
        )

        set "OUTFILE=output\folder%IDX%\folder%IDX%_s%%s_sh%%h_txt%%t_img%%i_seed!SEED!.mp4"

        echo    Generating → !OUTFILE!

        python generate.py ^
          --task s2v-1.3B ^
          --size 832*480 ^
          --frame_num 81 ^
          --ckpt_dir ".\Phantom-Wan-1.3B\Wan2.1-T2V-1.3B" ^
          --phantom_ckpt ".\Phantom-Wan-1.3B\Phantom-Wan-1.3B.pth" ^
          --ref_image !REFS! ^
          --prompt "!PROMPT!" ^
          --base_seed !SEED! ^
          --sample_steps %%s ^
          --sample_shift %%h ^
          --sample_guide_scale_text %%t ^
          --sample_guide_scale_img %%i ^
          --save_file "!OUTFILE!"
      )
    )
  )
)

goto :EOF
