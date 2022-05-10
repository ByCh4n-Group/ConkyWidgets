<h1 align="center">Conky Widgets</h1>
<p align="center">
  <img src="https://img.shields.io/badge/MAINTAINED-YES-green?style=for-the-badge">
  <img src="https://img.shields.io/badge/LICENSE-GPL-blue?style=for-the-badge">
  <img src="https://img.shields.io/github/issues/ByCh4n-Group/Conky-Widgets?style=for-the-badge">
</p>

<p align="center"><i>Made with :heart: by <a href="https://github.com/mhykoI">@mhykoI</a></i></p>

<p align="center">Conky Widgets your computer is set up to make the desktop look aesthetically pleasing and minimalistic.

<div align="center" style="display:inline">
<img alt="Screenshot of Thumbnail" src="https://user-images.githubusercontent.com/68022135/148652532-64eddb31-d459-4a05-92f6-7ec8ce57098a.png" width="800" />
</div>

### Table of contents

- [Requirements](#requirements)
  - [Packages](#packages)
- [Widgets](#widgets)
  - [Clock](#clock)
  - [Status](#status)
  - [System](#system)
  - [File](#file)
  - [Spotify](#spotify)
- [Installation](#installation)
- [Autostart](#autostart)
- [FAQ](#faq)

## Requirements

### Packages

- [conky](https://github.com/brndnmtthws/conky/)

> Ubuntu: `sudo apt install conky`

> Arch: `sudo pacman -S conky`

## Widgets

### Clock
> Displays the system time and date
<img alt="Screenshot of Clock" src="https://user-images.githubusercontent.com/68022135/148652549-06038205-f536-4ffc-b0dd-99c12f6de13e.png" width="500px" />

### Status
> Displays information about the system
<img alt="Screenshot of Status" src="https://user-images.githubusercontent.com/68022135/148652557-1ec335e8-d403-4e45-9a9f-e932f9287c1a.png" width="500px" />

### System
> Shows the storage that the system uses
<img alt="Screenshot of System" src="https://user-images.githubusercontent.com/68022135/148652564-ca3973a1-06d2-4116-9702-9fad0b74191d.png" width="500px" />

### File
> Shows the disk space used
<img alt="Screenshot of File" src="https://user-images.githubusercontent.com/68022135/148652570-028019ad-cc7f-4d16-91c7-687d483a2169.png" width="500px" />

### Spotify
> Spotify shows the music being played
<img alt="Screenshot of Spotify" src="https://user-images.githubusercontent.com/68022135/148652578-29d25ec3-8f97-44e4-a567-bf178d8e8f28.png" width="500px" />

## Installation

1. Install all required [packages](#packages):
```
# Ubuntu
sudo apt install conky
# Arch
sudo pacman -S conky
```
2. Clone the repo:
```
git clone https://github.com/ByCh4n-Group/Conky-Widgets
```
3. Run the `conky-widgets.sh` script to start the widget (forks to background):
```
cd Conky-Widgets
bash configure.sh && sudo make install
```

## Usage
```bash
Type 'cwmanager --help' for more information after the installation.
```

## FAQ

> Are you worried about the locations of your widgets?
- [conky-manager](https://teejeetech.com/conky-manager/)
