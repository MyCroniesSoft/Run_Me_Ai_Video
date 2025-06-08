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
- Create or use a folder like `D:\Projects\Wan2GP`.

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
1. Search "Environment Variables" → open system settings.
2. Under **System variables** → edit **Path**.
3. Add:
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

### 6. Clone Wan2GP Repo
```bash
git clone https://github.com/deepbeepmeep/Wan2GP.git
cd Wan2GP
```

---

### 7. (Optional) Setup Conda Environment
```bash
conda create -n wan2gp python=3.10.9
conda activate wan2gp
pip install torch==2.6.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/test/cu124
pip install -r requirements.txt
```

---

### 8. Setup `venv` (Easy Way)
```bash
python -m venv venv
venv\Scripts\activate
pip install torch==2.6.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/test/cu124
python -m pip install -r "D:\Projects\Wan2GP\requirements.txt"
```
> Replace `D:\Projects\Wan2GP` with your actual path and drive letter if needed.

---

### 9. Create a `run.bat` File *(optional but recommended)*

---

## ✨ Features
> A unified framework for sketching, text-guided, and subject-consistent video generation with state-of-the-art methods.  
> *Empowering creators to generate high-quality videos effortlessly.*

<p align="center">
  <img src="assets/teaser" alt="Run Me AI Video Teaser" width="95%">
</p>

---

## 🔥 Latest News
- **May 1, 2025:** Full version released — faster and higher quality.
- **May 3, 2025:** Multi-GPU support via FSDP.
- **May 10, 2025:** Experimental editor interface launched.

---

## 📑 Todo List
- [x] Release initial inference code and checkpoints
- [ ] Add advanced training scripts
- [ ] Expand documentation

---

## 📖 Overview
Run Me AI Video is a place to test video paramaters, for example you want that seed but have no idea, and you just want a video pumped out regardless of hardware, simply add the paramaters in the run bat, duration and the video will generate a reasonable quality video, with seed, and paramaters provided in the video, so far optimisations are being added to maximise speed, the point of this project is to for story boarding, and paramater testing where you go off to work or study for the day and massive amounts of videos based on your prompt and genre are generated, now this is where paramater testing comes in, lets say for example you have 5 amazing images, well its anyones guess those images will be the same, but we can crop them out and merge them into folders or just drop for example a house with two men, now its best before using people to mask them out so they merge in into the environment, while thats a nice feature it was not the intention of the project, rather finding that sweet spot as each model has its shift 0.5 for example or inference steps to get the best quality its best to use between 30 and 170, and thats where the paramater testing comes in you can drop some numbers ranging up drom 80 to 170, and shift from 1.5 to 12, while i dont recommend it you can see in the output with over 20 videos pumped out, while it takes a while and optimisations are coming you don't have to sit there hoping instead you can pray, joke.

---

## ⚡ Quickstart
```bash
git clone https://github.com/MyCroniesSoft/Run_Me_Ai_Video.git
cd Run_Me_Ai_Video
```

Models provided, are from phantom, alibaba, and tencent, you can check their repository out.
