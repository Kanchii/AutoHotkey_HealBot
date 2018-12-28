﻿; Generated by AutoGUI 2.5.4
#NoEnv
#SingleInstance Force
#InstallKeybdHook

CoordMode, Mouse, Screen ; Required: change coord mode to screen vs relative.
CoordMode, Pixel, Screen ; Required: change coord mode to screen vs relative.

SetWorkingDir %A_ScriptDir%

Menu menuArquivo, Add, &Open...`tCtrl+O, MenuAbrir
Menu menuArquivo, Disable, 1&
Menu menuArquivo, Add, &Configurações..., MenuConfiguracao
Menu menuArquivo, Disable, 2&

Menu menuArquivo, Add, &Sair`tEsc, MenuSair
Menu MenuBar, Add, Arquivo, :menuArquivo
Menu menuAjuda, Add, &Sobre, MenuSobre
Menu MenuBar, Add, &Ajuda, :menuAjuda
Gui Principal: Menu, MenuBar

global percentLife1, percentLife2, percentLife3
global x1_lifeBar, x2_lifeBar, y1_lifeBar, y2_lifeBar
global status := 0

global paralyze_x_1, paralyze_y_1, paralyze_x_2, paralyze_y_2

Gui Principal: Font, s15 Bold, Tahoma
Gui Principal: Add, Text, x190 y5 w147 h25 +0x200, Rila Desgraça
Gui Principal: Font
Gui Principal: Add, Text, x50 y43 w33 h23 +Disabled +0x200 vtxtKey1, Key 1:
Gui Principal: Add, Text, x50 y80 w33 h23 +Disabled +0x200 vtxtKey2, Key 2:
Gui Principal: Add, Text, x50 y117 w33 h23 +Disabled +0x200 vtxtKey3, Key 3:
Gui Principal: Add, ComboBox, x94 y43 w55 +Disabled +Uppercase vcbxKey1, F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12
Gui Principal: Add, ComboBox, x94 y80 w55 +Disabled +Uppercase vcbxKey2, F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12
Gui Principal: Add, ComboBox, x94 y117 w55 +Disabled +Uppercase vcbxKey3, F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12
Gui Principal: Add, ComboBox, x195 y43 w136 +Disabled vcbxSpell1, Exura|Exura Gran|Exura Ico|Exura Gran Ico
Gui Principal: Add, Text, x162 y43 w30 h23 +Disabled +0x200 vtxtSpell1, Spell:
Gui Principal: Add, Text, x162 y80 w30 h23 +Disabled +0x200 vtxtSpell2, Spell:
Gui Principal: Add, ComboBox, x195 y80 w136 +Disabled vcbxSpell2, Exura|Exura Gran|Exura Ico|Exura Gran Ico
Gui Principal: Add, Text, x162 y117 w30 h23 +Disabled +0x200 vtxtSpell3, Spell:
Gui Principal: Add, ComboBox, x195 y117 w136 +Disabled vcbxSpell3, Exura|Exura Gran|Exura Ico|Exura Gran Ico
Gui Principal: Add, CheckBox, x28 y43 w15 h23 vCheck1 gCheckBox1
Gui Principal: Add, CheckBox, x28 y80 w15 h23 vCheck2 gCheckBox2
Gui Principal: Add, CheckBox, x28 y117 w15 h23 vCheck3 gCheckBox3
Gui Principal: Add, Text, x14 y197 w55 h23 +0x200, Timer (ms):
Gui Principal: Add, Edit, x69 y201 w70 h21 vtimer
Gui Principal: Add, Button, x320 y201 w80 h23 +Disabled vstartPause gbtn_Start, &Start
Gui Principal: Add, Button, x408 y201 w80 h23 +Disabled, &Save
Gui Principal: Add, Button, x145 y201 w70 h21 vbtn_Timer gsetTimer, Set Timer
Gui Principal: Add, Slider, x346 y43 w120 h32 +Disabled +Tooltip vsliderLife1 gSlider1Move, 50
Gui Principal: Add, Slider, x346 y80 w120 h32 +Disabled +Tooltip vsliderLife2 gSlider2Move, 50
Gui Principal: Add, Slider, x346 y117 w120 h32 +Disabled +Tooltip vsliderLife3 gSlider3Move, 50
Gui Principal: Add, Edit, x468 y43 w27 h22 +Disabled vedtLife1 gEdit1Modify
Gui Principal: Add, Edit, x468 y80 w27 h22 +Disabled vedtLife2 gEdit2Modify
Gui Principal: Add, Edit, x468 y117 w27 h22 +Disabled vedtLife3 gEdit3Modify
Gui Principal: Add, CheckBox, x28 y154 w15 h23 vcheckParalyze gCheckParalyze
Gui Principal: Add, Text, x50 y154 w65 h23 +Disabled +0x200 vtxtParalyze, Anti-Paralyze
Gui Principal: Add, ComboBox, x120 y154 w55 +Disabled +Uppercase vcbxKeyParalyze, F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12
Gui Principal: Add, Text, x185 y154 w80 h23 +0x200 vtxtStatusParalyze +Disabled, Não configurado
Gui Principal: Add, StatusBar, vstatusBar, Faltar definir a posição inicial e final da vida.

Gui Configuracao: Font, s16 Bold, Tahoma
Gui Configuracao: Add, Text, x28 y12 w154 h31 +0x200, Configurações
Gui Configuracao: Font
Gui Configuracao: Add, Text, x18 y67 w65 h23 +0x200, Setar a vida:
Gui Configuracao: Add, Radio, x100 y54 w120 h23, Point-and-Click
Gui Configuracao: Add, Radio, x100 y84 w133 h23, Seleção com retângulo
Gui Configuracao: Add, Text, x55 y128 w28 h23 +0x200, Som:
Gui Configuracao: Add, Slider, x95 y130 w203 h32, 50
Gui Configuracao: Add, Button, x135 y189 w80 h23, &Salvar
Gui Configuracao: Add, Button, x229 y189 w80 h23, &Sair

Gui Principal: Show, w526 h255, Rila Desgraça
goto verifyVersion
Return

varExist(ByRef v) { ; Requires 1.0.46+
   return &v = &n ? 0 : v = "" ? 2 : 1 
}

; Função externa que permite ao usuario selecionar uma área na tela
LetUserSelectRect(ByRef X1, ByRef Y1, ByRef X2, ByRef Y2) {
    static r := 1
    ; Create the "selection rectangle" GUIs (one for each edge).
    
    Gui, leftBorder: -Caption +ToolWindow +AlwaysOnTop
    Gui, leftBorder: Color, Red
    Gui, rightBorder: -Caption +ToolWindow +AlwaysOnTop
    Gui, rightBorder: Color, Red
    Gui, bottomBorder: -Caption +ToolWindow +AlwaysOnTop
    Gui, bottomBorder: Color, Red
    Gui, topBorder: -Caption +ToolWindow +AlwaysOnTop
    Gui, topBorder: Color, Red
    
    ; Disable LButton.
    Hotkey, *LButton, lusr_return, On
    ; Wait for user to press LButton.
    KeyWait, LButton, D
    ; Get initial coordinates.
    MouseGetPos, xorigin, yorigin
    ; Set timer for updating the selection rectangle.
    SetTimer, lusr_update, 10
    ; Wait for user to release LButton.
    KeyWait, LButton
    ; Re-enable LButton.
    Hotkey, *LButton, Off
    ; Disable timer.
    SetTimer, lusr_update, Off
    ; Destroy "selection rectangle" GUIs.

    Gui, leftBorder: Destroy
    Gui, rightBorder: Destroy
    Gui, bottomBorder: Destroy
    Gui, topBorder: Destroy
    
    Return

 
    lusr_update:
        MouseGetPos, x, y
        if (x = xlast && y = ylast)
            ; Mouse hasn't moved so there's nothing to do.
            Return
        if (x < xorigin)
             x1 := x, x2 := xorigin
        else x2 := x, x1 := xorigin
        if (y < yorigin)
             y1 := y, y2 := yorigin
        else y2 := y, y1 := yorigin
        ; Update the "selection rectangle".
        Gui, leftBorder:Show, % "NA X" x1 " Y" y1 " W" x2-x1 " H" r
        Gui, rightBorder:Show, % "NA X" x1 " Y" y2-r " W" x2-x1 " H" r
        Gui, bottomBorder:Show, % "NA X" x1 " Y" y1 " W" r " H" y2-y1
        Gui, topBorder:Show, % "NA X" x2-r " Y" y1 " W" r " H" y2-y1
    lusr_return:
    Return
}

verifyVersion:
    UrlDownloadToFile, https://raw.githubusercontent.com/Kanchii/AutoHotkey_HealBot/master/version.txt, version_temp.txt
    FileRead, v_tmp, version_temp.txt
    FileRead, vers, version.txt
    if(v_tmp != vers){
        MsgBox, 0x4, Atualização, Tem uma nova versão disponível. Gostaria de atualizar?, 
        IfMsgBox Yes
            goto UpdateProgram
        else
            FileDelete, version_temp.txt
    } else {
        FileDelete, version_temp.txt
    }
Return

UpdateProgram:
    FileRead, v_ants, version.txt
    UrlDownloadToFile, https://raw.githubusercontent.com/Kanchii/AutoHotkey_HealBot/master/version.txt, version.txt
    FileRead, v_depois, version.txt
    arquivo_Depois := "Rilador_" . v_depois . ".exe"
    UrlDownloadToFile, https://raw.githubusercontent.com/Kanchii/AutoHotkey_HealBot/master/Rilador.exe, % arquivo_Depois
    FileDelete, version_temp.txt
    ExitApp
Return

MenuSair:
    ExitApp
Return

MenuAbrir:
Return

MenuConfiguracao:
    Gui Configuracao: Show, w319 h227, Configurações
Return

MenuSobre:
    MsgBox, Eae bando de sem vida <3`n`n`n                                     Programa criado por Felipe Weiss
Return

^1::
    WinGetTitle, windowName, A
	IfNotInString, windowName, Tibia
	{
		MsgBox, Faça isso somente na tela do Tibia.
        Return
	}
    LetUserSelectRect(x1_lifeBar, y1_lifeBar, x2_lifeBar, y2_lifeBar)
    y_med := (y1_lifeBar + y2_lifeBar) / 2
    
    GuiControl, , statusBar, O bot se encontra pausado.
    TrayTip, , Life setado com sucesso!, , 0x1
Return

/*
^1::
    status |= (1 << 0)
    if(status = 1){
        GuiControl, , statusBar, Falta definir a posição final da vida.
    } else if(status = 3){

    }

    MouseGetPos, x1_LifeBar, y1_LifeBar
Return

^2::
    status |= (1 << 1)
    if(status = 2){
        GuiControl, , statusBar, Falta definir a posição inicial da vida.
    } else if(status = 3){
        GuiControl, , statusBar, O bot se encontra pausado.
    }
    MouseGetPos, x2_LifeBar, y2_LifeBar
Return
*/
^+1::
    WinGetTitle, windowName, A
	IfNotInString, windowName, Tibia
	{
		MsgBox, Faça isso somente na tela do Tibia.
        Return
	}
    LetUserSelectRect(paralyze_x_1, paralyze_y_1, paralyze_x_2, paralyze_y_2)
    GuiControl, , txtStatusParalyze, Configurado
    TrayTip, , Anti-Paralyze setado com sucesso!, , 0x1
Return

/*

+^1::
    MouseGetPos, paralyze_x_1, paralyze_y_1
    if(varExist(paralyze_x_2)){
        GuiControl, , txtStatusParalyze, Configurado
    }
Return

+^2::
    MouseGetPos, paralyze_x_2, paralyze_y_2
    if(varExist(paralyze_x_1)){
        GuiControl, , txtStatusParalyze, Configurado
    }
Return
*/
CheckBox1:
    GuiControlGet, Check1
    if(Check1 = 0){
        GuiControl, Disable, txtKey1
        GuiControl, Disable, cbxKey1
        ;GuiControl, Disable, txtSpell1
        ;GuiControl, Disable, cbxSpell1
        GuiControl, Disable, sliderLife1
        GuiControl, Disable, edtLife1
    } else {
        GuiControl, Enabled, txtKey1
        GuiControl, Enabled, cbxKey1
        ;GuiControl, Enabled, txtSpell1
        ;GuiControl, Enabled, cbxSpell1
        GuiControl, Enabled, sliderLife1
        GuiControl, Enabled, edtLife1
    }
Return


CheckBox2:
    GuiControlGet, Check2
    if(Check2 = 0){
        GuiControl, Disable, txtKey2
        GuiControl, Disable, cbxKey2
        ;GuiControl, Disable, txtSpell2
        ;GuiControl, Disable, cbxSpell2
        GuiControl, Disable, sliderLife2
        GuiControl, Disable, edtLife2
    } else {
        GuiControl, Enabled, txtKey2
        GuiControl, Enabled, cbxKey2
        ;GuiControl, Enabled, txtSpell2
        ;GuiControl, Enabled, cbxSpell2
        GuiControl, Enabled, sliderLife2
        GuiControl, Enabled, edtLife2
    }
Return


CheckBox3:
    GuiControlGet, Check3
    if(Check3 = 0){
        GuiControl, Disable, txtKey3
        GuiControl, Disable, cbxKey3
        ;GuiControl, Disable, txtSpell3
        ;GuiControl, Disable, cbxSpell3
        GuiControl, Disable, sliderLife3
        GuiControl, Disable, edtLife3
    } else {
        GuiControl, Enabled, txtKey3
        GuiControl, Enabled, cbxKey3
        ;GuiControl, Enabled, txtSpell3
        ;GuiControl, Enabled, cbxSpell3
        GuiControl, Enabled, sliderLife3
        GuiControl, Enabled, edtLife3
    }
Return

CheckParalyze:
    GuiControlGet, checkParalyze
    if(checkParalyze = 0){
        GuiControl, Disable, txtParalyze
        GuiControl, Disable, cbxKeyParalyze
        GuiControl, Disable, txtStatusParalyze
    } else {
        GuiControl, Enabled, txtParalyze
        GuiControl, Enabled, cbxKeyParalyze
        GuiControl, Enabled, txtStatusParalyze
    }
Return

Slider1Move:
    Gui, Submit, nohide
    GuiControl,, edtLife1, %sliderLife1%
Return

Slider2Move:
    Gui, Submit, nohide
    GuiControl,, edtLife2, %sliderLife2%
Return

Slider3Move:
    Gui, Submit, nohide
    GuiControl,, edtLife3, %sliderLife3%
Return

Edit1Modify:
    Gui, Submit, nohide
    GuiControl,, sliderLife1, %edtLife1%
Return

Edit2Modify:
    Gui, Submit, nohide
    GuiControl,, sliderLife2, %edtLife2%
Return

Edit3Modify:
    Gui, Submit, nohide
    GuiControl,, sliderLife3, %edtLife3%
Return

min(num*){
    min := num[1]
	Loop % num.MaxIndex()
		min := (num[A_Index] < min) ? num[A_Index] : min
	return min
}

max(num*){
    max := num[1]
	Loop % num.MaxIndex()
		max := (num[A_Index] > max) ? num[A_Index] : max
	return max
}


^x::
    goto run
Return

^z::
    MouseGetPos, x, y
    PixelGetColor, pixelColor, %x%, %y%
    MsgBox, %pixelColor%
Return

abs(a){
    if(a < 0){
        return (-a)
    }
    return a
}

RGB_Euclidian_Distance( c1, c2 ) {
   r1 := c1 >> 16
   g1 := c1 >> 8 & 255
   b1 := c1 & 255
   r2 := c2 >> 16
   g2 := c2 >> 8 & 255
   b2 := c2 & 255
   return Sqrt( (r1-r2)**2 + (g1-g2)**2 + (b1-b2)**2 )
}

isBlack(lifeColor){
    BLUE := 0x0000FF
    RED := 0xFF0000
    BLACK := 0x000000
    
    first := RGB_Euclidian_Distance(lifeColor, RED)
    second := RGB_Euclidian_Distance(lifeColor, BLACK)
    if(first < second){
        return 2
    }
    return 1
}

; Pause do bot sem ser pela tela
!x::
    goto btn_Start
Return

run:
    WinGetTitle, windowName, A
	IfNotInString, windowName, Tibia
	{
		Return
	}
    
    min_x := min(x1_lifeBar, x2_lifeBar)
    max_x := max(x1_lifeBar, x2_lifeBar)
    y_med := (y1_lifeBar + y2_lifeBar) / 2
    ;min_y := min(y1_lifeBar, y2_lifeBar)
    ;max_y := max(y1_lifeBar, y2_lifeBar)
    GuiControlGet, Check1
    if(Check1 = 1){
        GuiControlGet, edtLife1
        life1 := % edtLife1
        x_pos := min_x + ((max_x - min_x) * life1) / 100.0
        ;y_pos := min_y + ((max_y - min_y) * life1) / 100.0
        y_pos := y_med
        PixelGetColor, lifeColor, x_pos, y_pos, RGB
        MouseMove, x_pos, y_pos
        MsgBox, %lifeColor%
        if(isBlack(lifeColor) = 1){
            ; MsgBox, Tem que curar
            GuiControlGet, key1,, cbxKey1
            send {%key1%}
        }
    }
    GuiControlGet, Check2
    if(Check2 = 1){
        GuiControlGet, edtLife2
        life2 := % edtLife2
        x_pos := min_x + ((max_x - min_x) * life2) / 100.0
        ;y_pos := min_y + ((max_y - min_y) * life2) / 100.0
        y_pos := y_med
        ; MsgBox, %x_pos% %y_pos%
        PixelGetColor, lifeColor, %x_pos%, %y_pos%, RGB
        if(isBlack(lifeColor) = 1){
            GuiControlGet, key2,, cbxKey2
            send {%key2%}
        }
    }
    GuiControlGet, Check3
    if(Check3 = 1){
        GuiControlGet, edtLife3
        life3 := % edtLife3
        x_pos := min_x + ((max_x - min_x) * life3) / 100.0
        ;y_pos := min_y + ((max_y - min_y) * life3) / 100.0
        y_pos := y_med
        PixelGetColor, lifeColor, %x_pos%, %y_pos%, RGB
        if(isBlack(lifeColor) = 1){
            ; MsgBox, Tem que curar
            GuiControlGet, key3,, cbxKey3
            send {%key3%}
        }
    }
    GuiControlGet, checkParalyze
    if(checkParalyze = 1){
        PixelSearch, pos_x_image, pos_Y_image, %paralyze_x_1%, %paralyze_y_1%, %paralyze_x_2%, %paralyze_y_2%, 0x0000FF, 2, Fast ;images\paralyze.png
        if(ErrorLevel = 0){
            GuiControlGet, key_anti_paralyze, , cbxKeyParalyze
            send {%key_anti_paralyze%}
        }
    }
    
Return

btn_Start:
    if(!(varExist(x1_lifeBar) && varExist(x2_lifeBar))){
        MsgBox, Você precisa setar a posição inicial (Ctrl+1) e final (Ctrl+2) da vida antes.
        return
    }
    Pause, Toggle, 1
    /*if(status = 0){
        status := 1
        SetTimer, run, %timer%
    } else {
        status := 0
        SetTimer, run, off
    }
    */

    if A_IsPaused {
        GuiControl, , statusBar, O bot se encontra pausado.
        GuiControl, , startPause, Start
        TrayTip, , Bot pausado, , 0x1
    } else {
        GuiControl, , statusBar, O bot está em execução.
        GuiControl, , startPause, Pause
        TrayTip, , Bot iniciado, , 0x1
    }
		
	Return
Return

setTimer:
	GuiControlGet, timer
	if timer = 
	{
		Return
	} else {
        GuiControl, Enabled, startPause
        if !A_IsPaused {
            GuiControl, , startPause, Start
            Pause, Toggle, 1
        }
		SetTimer, run, %timer%
	}
Return

GuiEscape:
GuiClose:
    ExitApp
