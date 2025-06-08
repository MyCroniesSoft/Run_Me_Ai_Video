# Run Me AI Video forget and go to work and have some videos in different genres

<div align="center">

[![Release](https://img.shields.io/github/v/release/MyCroniesSoft/Run_Me_Ai_Video.svg)](https://github.com/MyCroniesSoft/Run_Me_Ai_Video/releases)&nbsp;
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)&nbsp;
[![GitHub stars](https://img.shields.io/github/stars/MyCroniesSoft/Run_Me_Ai_Video.svg?style=social)](https://github.com/MyCroniesSoft/Run_Me_Ai_Video/stargazers)

</div>

> **Run Me AI Video: Fast and Versatile AI-Driven Video Generation**  
> Drop in and run — pretty straightforward.

---

## 🛠️ Setup Guide for (Windows)

> ⚠️ **Note:** If you have Pinokio installed, delete/purge it before proceeding.

---

### 1. Choose a Drive
- Pick a drive (e.g., `C:` or `D:`).
- Create or use a folder like `D:\Projects\un_Me_Ai_Video`.

---

### 2. Install Git
- Download: https://git-scm.com/downloads  
- Or direct Windows installer:  
  https://github.com/git-for-windows/git/releases/download/v2.49.0.windows.1/Git-2.49.0-64-bit.exe

---

### 3. Install Python 3.10
- **Option 1:** Microsoft Store (recommended for beginners).
- **Option 2:** Manual install from https://www.python.org/downloads/  
  - Install to `C:\Python310`
  - Check “Add Python to PATH”

---

### 4. Update Environment Variables (PATH)
1. Press **Windows Key**, type `Environment Variables`, and open **Edit the system environment variables**.  
2. Click **Environment Variables…**.  
3. Under **System variables**, select **Path**, then click **Edit…**.  
4. Click **New** and add these entries (adjust if Python was installed elsewhere):  
   ```
   C:\Python310
   C:\Python310\Scripts
   ```  

---

### 5. Install CUDA Toolkit 12.4
- Download from NVIDIA:  
  https://developer.nvidia.com/cuda-12-4-0-download-archive?target_os=Windows&target_arch=x86_64&target_version=10&target_type=exe_local  
- Ensure path exists:  
  ```
  C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.4\bin
  ```

---

### 6. Clone or copy the Repository
```bash
1. Press **Alt + D**, type `cmd`, and press **Enter** to open Command Prompt there.  
2. In Command Prompt, run:      MUST BE IN COMMAND LINE
3. git clone https://github.com/MyCroniesSoft/Run_Me_Ai_Video.git  Copy in cmd
4. cd Run_Me_Ai_Video                                              Copy in cmd

```


---

### 7. (Optional) Setup Conda Environment
```bash
conda create -n cd Run_Me_Ai_Video python=3.10.9
conda activate cd Run_Me_Ai_Video
pip install torch==2.6.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/test/cu124
pip install -r requirements.txt
```

---

### 8. Setup `venv` (Easy Way)
```bash
python -m venv venv      Copy in cmd
venv\Scripts\activate
python pip install torch==2.6.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/test/cu124    Copy in cmd
python pip install -r "D:\Projects\cd Run_Me_Ai_Video\requirements.txt"    Copy in cmd
 SANME THING SHITF+ RIGHT CLICK, AND COPY AS PATH, THEN REMOVE IN YOUR CASE:
python pip install -r___ _____ ____ ____.txt

Must be in venv >> scritps >> activate >>
Then  Press **Alt + D**, type `cmd`, and press **Enter** to open Command Prompt there and copy above, its pretty much straight forward.

```
> Replace `D:\Projects\cd Run_Me_Ai_Video` with your actual path and drive letter if needed.
>
> 3. Press **Alt + D**, type `cmd`, and press **Enter**.  
4. Create a virtual environment:   
   ```bash
   python -m venv venv                 MUST BE IN COMMAND LINE
   ```
   - The first `venv` is the module; the second is the folder name.  
   - You can name the folder anything (e.g., `venv_donkey`, `venv_ass`), but `venv` is common.

5. Activate the `venv`:
   ```bash
   venv\Scripts\activate                   MUST BE IN COMMAND LINE
   ```
6. Install dependencies:
   ```bash
   python -m pip install -r requirements.txt            MUST BE IN COMMAND LINE

---

### 9. `run.bat` File

---
---

## 📖 Overview
Run Me AI Video is a place to test video paramaters, for example you want that seed but have no idea, and you just want a video pumped out regardless of hardware, simply add the paramaters in the run bat, duration and the video will generate a reasonable quality video, with seed, and paramaters provided in the video, so far optimisations are being added to maximise speed, the point of this project is to for story boarding, and paramater testing where you go off to work or study for the day and massive amounts of videos based on your prompt and genre are generated, now this is where paramater testing comes in, lets say for example you have 5 amazing images, well its anyones guess those images will be the same, but we can crop them out and merge them into folders or just drop for example a house with two men, now its best before using people to mask them out so they merge in into the environment, while thats a nice feature it was not the intention of the project, rather finding that sweet spot as each model has its shift 0.5 for example or inference steps to get the best quality its best to use between 30 and 170, and thats where the paramater testing comes in you can drop some numbers ranging up drom 80 to 170, and shift from 1.5 to 12, while i dont recommend 12, you can see in the output with over 20 videos pumped out with all different paramaters, man moving fast, man slow, man calm, you can grab the seed then feed it back in, the only issue is your images are they consistant man walks down hallway, greets people, then walks off for example(you can implement that in automatic 1111, through story board seeding where 50 images of the same seed in genre.

As for the project it does it take a while and optimisations are coming you don't have to sit there hoping instead you can pray, joke. the videos will output to the output folder, some reallyt cool or absolutley hellish, at least you have control.

---

## ⚡ Quickstart
```bash
git clone https://github.com/MyCroniesSoft/Run_Me_Ai_Video.git
cd Run_Me_Ai_Video
```

Models provided, are from phantom, alibaba, and tencent, you can check their repository out.
