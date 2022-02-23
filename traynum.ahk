; This is a pretty neat AHK example of displaying text in the systray icon by
; dynamically generating the required ICO. After some updates, this works on
; Windows 11. I'm using it as part of the vxdesktops.ahk Windows 1x virtual
; desktop switching utility.

;; I followed the advice of lexikos in this comment https://www.autohotkey.com/boards/viewtopic.php?p=293750#p293750
;; who linked to an example by geek and an improved version by tic. I took tic's version and then:
;; - removed NoTrayIcon: with that active, the icon painting does not work at all
;; - cleaned up the code
;; - converted labels to funcs so that code can be #include'd

#SingleInstance, Force

#Include ./AHKv2-Gdip/Gdip_All.ahk

#Persistent

If !pToken := Gdip_Startup()
{
    MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
    ExitApp
}

ExitFunc() {
    Gdip_Shutdown(pToken)
}

OnExit("ExitFunc")

ni := new Notify()
i := 0, d := false

;; uncomment following line if you just want to demo
;SetTimer, Update, 200

Update() {
    if (i = 0 || i = 9)
        d := !d
    i := d ? i+1 : i-1
    ;Tooltip, % i
    ni.SetText(i)
}

Class Notify
{
    __New(IconFont="Arial", IconSize=12)
    {
        this.IconFont := IconFont, this.IconSize := IconSize
        ; third param is iconsize
        this.pBitmapIcon := Gdip_CreateBitmapFromFile(A_AhkPath, 1, IconSize)
        this.pBitmap := Gdip_CreateBitmap(IconSize, IconSize)
        this.G := Gdip_GraphicsFromImage(this.pBitmap)
        this.pBrushBlack := Gdip_BrushCreateSolid(0xff000000)
        this.pPenWhite := Gdip_CreatePen(0xffffffff, 1)
    }

    SetText(String)
    {
        Gdip_GraphicsClear(this.G)
        Gdip_DrawImage(this.G, this.pBitmapIcon)

        ;; Gdip_FillRoundedRectangle(pGraphics, pBrush, x, y, w, h, r)
        Gdip_FillRoundedRectangle(this.G, this.pBrushBlack, 0, 0, 12, 12, 1)
        ;Gdip_DrawRoundedRectangle(this.G, this.pPenWhite, 0, 0, 13, 13, 1)
        Gdip_TextToGraphics(this.G, String, "x0 y1 s10 cffffffff Center vCenter NoWrap Bold", this.IconFont, this.IconSize, this.IconSize)

        hIcon := Gdip_CreateHICONFromBitmap(this.pBitmap)
        this.SetIcon(hIcon)
        DestroyIcon(hIcon)
    }

    SetIcon(hIcon)
    {
        ;; as per lexikos, you don't need te build NOTIFYICONDATA and do Shell_NotifyIcon anymore
        Menu Tray, Icon, HICON:%hIcon%
    }

    __Delete()
    {
        Gdip_DeleteBrush(this.pBrushBlack)
        Gdip_DeletePen(this.pPenWhite)
        Gdip_DeleteGraphics(this.G)
        Gdip_DisposeImage(this.pBitmap)
        Gdip_DisposeImage(this.pBitmapIcon)
    }
}

