# vxdesktops.ahk

This a collection of AutoHotkey scripts with which you can switch directly to
Windows 10 / 11 virtual desktops with RightAlt-NUM. Your currently active
desktop number will be shown in the systray.

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

You can switch to desktop 1 to 7 with the hotkey `RightAlt + NUM`.
