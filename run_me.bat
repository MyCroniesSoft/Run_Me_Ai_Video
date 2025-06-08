@echo off
cd /d "%~dp0"
set PYTHONPATH=%CD%

:: 1) Activate Python virtual environment
call "venv\Scripts\activate"

:: 2) Disable flash-attention if desired
set PHANTOM_WAN_DISABLE_FLASH_ATTENTION=1

:: 3) Ensure CUDA in PATH
set CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.4
set PATH=%CUDA_HOME%\bin;%PATH%

:: 4) Prepare output folder
mkdir output 2>nul

:: 5) Enable delayed expansion
setlocal EnableDelayedExpansion

:: 6) Parameter grids
set "STEPS=150 170"
set "SHIFTS=1.50 1.70"
set "TXT_SCALES=8.5 7.0"
set "IMG_SCALES=3.0 3.5"

:: 7) Use fixed seed? (1 = fixed / 0 = random)
set "USE_FIXED_SEED=0"
set "FIXED_SEED=42"

:: 8) Your three scene-structured prompts
set "PROMPT1= a man commuting on a new york city metro train is sitting down, wearing a red tie, and blue suit, and blue trousers, he is waiting to get off."
set "PROMPT2= a man stands waiting near the elevator"
set "PROMPT3= a man is commuting alone in a new york city taxi with no cars around."

:: 9) Process each folder (1–3)
for %%P in (1 2 3) do (
  call :ProcessFolder %%P
)
goto :EOF

:ProcessFolder
  set "IDX=%1"
  set "SRC_DIR=Z:\Projects\Phantom\drop_images_in\folder_%IDX%"
  call set "PROMPT=!PROMPT%IDX%!"

  echo.
  echo ==== Folder %IDX%: "!SRC_DIR!" → Prompt %IDX% ====

  :: 10) Gather up to 4 reference images
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
    echo -- No images in folder %IDX%; skipping.
    goto :EOF
  )

  echo -- Found !COUNT! image(s): !REFS!

  :: 11) Make per-folder output dir
  mkdir "output\folder%IDX%" 2>nul

  :: 12) Run your grid with 127 frames
  for %%s in (%STEPS%) do (
    for %%h in (%SHIFTS%) do (
      for %%t in (%TXT_SCALES%) do (
        for %%i in (%IMG_SCALES%) do (

          if "!USE_FIXED_SEED!"=="1" (
            set "SEED=%FIXED_SEED%"
          ) else (
            set /A SEED=!random!
          )

          set "NAME=robbery_scene_p%IDX%_s%%s_sh%%h_txt%%t_img%%i_seed!SEED!.mp4"
          set "OUTFILE=output\folder%IDX%\!NAME!"

          echo --------------------------------------------------
          echo Running Phantom:
          echo    Prompt Variant: %IDX%
          echo    steps=%%s   shift=%%h   txt_scale=%%t   img_scale=%%i
          echo    seed=!SEED!
          echo    Output: !OUTFILE!
          echo --------------------------------------------------

          python generate.py ^
            --task s2v-1.3B ^
            --size 832*480 ^
            --frame_num 97 ^
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

:EOF
endlocal
echo.
echo All scene variations complete. Check the "output" folder.
pause
