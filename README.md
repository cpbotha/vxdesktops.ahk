# vxdesktops.ahk

This a collection of AutoHotkey scripts with which you can switch directly to
Windows 10 / 11 virtual desktops with `LeftCtrl+Win+NUM` and move active window with `LeftAlt+Win+NUM`.
Your currently active desktop number will be shown in the systray.

![vxdesktops numbered systray icon](screenshots/vxdesktops-screenshot-2022-02-23.png)

## Quickstart

Ensure that you have [AutoHotkey](https://www.autohotkey.com/) installed.

Then download this git repo and the two required submodules:

```shell
git clone git@github.com:cpbotha/vxdesktops.ahk.git
cd vxdesktops.ahk
git submodule update --init --recursive
```

In the `vxdesktops.ahk` folder, double-click on the `vxdesktops.ahk` script.

In Windows settings under "Personalization - Taskbar - Taskbar corner overflow"
ensure that AutoHotkey is set to "On".

You should now see a numbered icon in the systray.

You can switch to desktop 1 to 9 with the hotkey `LeftCtrl+Win+NUM`.

You can move the current active window to desktop 1 to 9 with the hotkey `LeftAlt+Win+NUM`.

## FAQ
### Why is it so slow when I switch desktops?

Thanks to [the VD.ahk library](https://github.com/FuPeiJiang/VD.ahk), desktops
are switched using the Windows 10 / 11 API calls, and so this is usually almost
instantaneous.

However, if you have different wallpaper images on your virtual desktops (a new
Windows 11 feature IIUC), it can slow down switching significantly.

For best performance, please ensure you have the same wallpaper image on all
desktops.

For more background, see [this forum
post](https://techcommunity.microsoft.com/t5/microsoft-bing/bing-wallpaper-app-issue-on-win-11-with-multiple-desktops/m-p/2969683)
