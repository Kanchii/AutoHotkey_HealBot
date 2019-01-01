﻿; Generated by AutoGUI 2.5.4
#NoEnv
#SingleInstance Force
#InstallKeybdHook
SetBatchLines -1
ListLines Off

CoordMode, Mouse ; Required: change coord mode to screen vs relative.
CoordMode, Pixel ; Required: change coord mode to screen vs relative.

SetWorkingDir %A_ScriptDir%

Menu menuArquivo, Add, &Open...`tCtrl+O, MenuAbrir
Menu menuArquivo, Disable, 1&
Menu menuArquivo, Add, &Configurações..., MenuConfiguracao
; Menu menuArquivo, Disable, 2&

Menu menuArquivo, Add, Update, MenuUpdate
Menu menuArquivo, Disable, 3&

Menu menuArquivo, Add, &Sair`tEsc, MenuSair
Menu MenuBar, Add, Arquivo, :menuArquivo
Menu menuAjuda, Add, &Comandos, MenuComandos
Menu menuAjuda, Add, &Sobre, MenuSobre
Menu MenuBar, Add, &Ajuda, :menuAjuda
Gui Principal: Menu, MenuBar

global percentLife1, percentLife2, percentLife3
global x1_lifeBar, x2_lifeBar, y1_lifeBar, y2_lifeBar
global status := 0
global tipoSelecao := 1

global autoPush_x, auto_Push_y, auto_Push_status := 0

global buff_x_1, buff_y_1, buff_x_2, buff_y_2

; Título aba Heal
Gui Principal: Add, Tab3, , Heal|Utilities
Gui Principal: Font, s15 Bold, Tahoma
Gui Principal: Add, Text, x190 y35 w147 h25 +0x200, Heal Control
Gui Principal: Font

; Componentes principais da aba Heal
Gui Principal: Add, Text, x50 y73 w33 h23 +Disabled +0x200 vtxtKey1, Key 1:
Gui Principal: Add, Text, x50 y110 w33 h23 +Disabled +0x200 vtxtKey2, Key 2:
Gui Principal: Add, Text, x50 y147 w33 h23 +Disabled +0x200 vtxtKey3, Key 3:
Gui Principal: Add, ComboBox, x94 y73 w55 +Disabled +Uppercase vcbxKey1, F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12
Gui Principal: Add, ComboBox, x94 y110 w55 +Disabled +Uppercase vcbxKey2, F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12
Gui Principal: Add, ComboBox, x94 y147 w55 +Disabled +Uppercase vcbxKey3, F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12
Gui Principal: Add, ComboBox, x195 y73 w136 +Disabled vcbxSpell1, Exura|Exura Gran|Exura Ico|Exura Gran Ico
Gui Principal: Add, Text, x162 y73 w30 h23 +Disabled +0x200 vtxtSpell1, Spell:
Gui Principal: Add, Text, x162 y110 w30 h23 +Disabled +0x200 vtxtSpell2, Spell:
Gui Principal: Add, ComboBox, x195 y110 w136 +Disabled vcbxSpell2, Exura|Exura Gran|Exura Ico|Exura Gran Ico
Gui Principal: Add, Text, x162 y147 w30 h23 +Disabled +0x200 vtxtSpell3, Spell:
Gui Principal: Add, ComboBox, x195 y147 w136 +Disabled vcbxSpell3, Exura|Exura Gran|Exura Ico|Exura Gran Ico
Gui Principal: Add, CheckBox, x28 y73 w15 h23 vCheck1 gCheckBox1
Gui Principal: Add, CheckBox, x28 y110 w15 h23 vCheck2 gCheckBox2
Gui Principal: Add, CheckBox, x28 y147 w15 h23 vCheck3 gCheckBox3
Gui Principal: Add, Slider, x346 y73 w120 h32 +Disabled +Tooltip vsliderLife1 gSlider1Move, 50
Gui Principal: Add, Slider, x346 y110 w120 h32 +Disabled +Tooltip vsliderLife2 gSlider2Move, 50
Gui Principal: Add, Slider, x346 y147 w120 h32 +Disabled +Tooltip vsliderLife3 gSlider3Move, 50
Gui Principal: Add, Edit, x468 y73 w27 h22 +Disabled vedtLife1 gEdit1Modify
Gui Principal: Add, Edit, x468 y110 w27 h22 +Disabled vedtLife2 gEdit2Modify
Gui Principal: Add, Edit, x468 y147 w27 h22 +Disabled vedtLife3 gEdit3Modify

; Tab dos Buffs e Debuffs
Gui, Principal: Tab, 2
Gui Principal: Font, s15 Bold, Tahoma
Gui Principal: Add, Text, x205 y35 w147 h25 +0x200, Utilities
Gui Principal: Font
Gui Principal: Add, CheckBox, x28 y73 w15 h23 vcheckParalyze gCheckParalyze
Gui Principal: Add, Text, x50 y73 w65 h23 +Disabled +0x200 vtxtParalyze, Anti-Paralyze:
Gui Principal: Add, ComboBox, x120 y73 w55 +Disabled +Uppercase vcbxKeyParalyze, F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12
Gui Principal: Add, CheckBox, x28 y110 w15 h23 vcheckAutoHaste gCheckAutoHaste
Gui Principal: Add, Text, x50 y110 w65 h23 +Disabled +0x200 vtxtAutoHaste, Auto Haste:
Gui Principal: Add, ComboBox, x120 y110 w55 +Disabled +Uppercase vcbxKeyAutoHaste, F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12
; Gui Principal: Add, Text, x185 y73 w80 h23 +0x200 vtxtStatusParalyze +Disabled, Não configurado
Gui Principal: Add, Text, x50 y147 w55 h23, Auto push:
Gui Principal: Add, Button, x120 y145 w55 h20 vbtn_AutoPush gclickAutoPush, Off
Gui Principal: Add, text, x180 y140 w50 h50 vautoPush_Pos_Status +Disabled, X = ?`nY = ?

Gui, Principal: Tab
; Botões
Gui Principal: Add, Text, x14 y201 w55 h23 +0x200, Timer (ms):
Gui Principal: Add, Edit, x69 y201 w70 h21 vtimer
Gui Principal: Add, Button, x320 y201 w80 h23 +Disabled vstartPause gbtn_Start, &Start
Gui Principal: Add, Button, x408 y201 w80 h23 +Disabled, &Save
Gui Principal: Add, Button, x145 y201 w70 h21 vbtn_Timer gsetTimer, Set Timer

; StatusBar
Gui Principal: Add, StatusBar, vstatusBar, Faltar definir a posição inicial e final da vida.

; Tela de Configuração

; Título
Gui Configuracao: Font, s16 Bold, Tahoma
Gui Configuracao: Add, Text, x28 y12 w154 h31 +0x200, Configurações
Gui Configuracao: Font

; Componentes principais da configuração
Gui Configuracao: Add, Text, x18 y67 w65 h23 +0x200, Setar a vida:
Gui Configuracao: Add, Radio, x100 y54 w120 h23 vpointClick gPointClickFunc, Point-and-Click
Gui Configuracao: Add, Radio, x100 y84 w133 h23 vrectangle gRectangleFunc, Seleção com retângulo
GuiControl, Configuracao:, rectangle, 1
Gui Configuracao: Add, Text, x55 y128 w28 h23 +0x200, Som:
Gui Configuracao: Add, Slider, x95 y130 w203 h32, 50

; Botões
Gui Configuracao: Add, Button, x229 y189 w80 h23 gBotaoVoltarConfFunc, &Voltar

Gui Principal: +LabelGUIPrincipal
Gui Configuracao: +LabelGUIConfiguracao

Gui Principal: Show, w526 h255, Rila Desgraça
goto verifyVersion
Return

varExist(ByRef v) { ; Requires 1.0.46+
   return &v = &n ? 0 : v = "" ? 2 : 1 
}

PointClickFunc:
    tipoSelecao := 0
Return

RectangleFunc:
    tipoSelecao := 1
Return

BotaoVoltarConfFunc:
    Gui Configuracao: cancel
Return

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
    SetTimer, verifyVersionOnRun, 300000
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

verifyVersionOnRun:
    UrlDownloadToFile, https://raw.githubusercontent.com/Kanchii/AutoHotkey_HealBot/master/version.txt, version_temp.txt
    FileRead, v_tmp, version_temp.txt
    FileRead, vers, version.txt
    if(v_tmp != vers){
        TrayTip, , Uma nova versão foi identificada. Atualize o macro e receba uma loli., , 0x1
        SetTimer, verifyVersionOnRun, off
        Menu menuArquivo, Enable, Update
    }
    FileDelete, version_temp.txt    
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

MenuUpdate:
    goto UpdateProgram
Return

MenuComandos:
    MsgBox, Ctrl+1 -> Seta a posição inicial da barra de vida`nCtrl+2 -> Seta a posição final da barra de vida (Modo Point-and-Click)`nCtrl+Shift+1 -> Seta a posição inicial da barra de status`nCtrl+Shift+2 -> Seta a posição final (Modo Point-and-Click)`nAlt+X -> Pausa/Ativa o BOT`nCtrl+K -> Seta a posição do Drag&Drop`nCtrl+LButton* -> Ativa a função do Drag&Drop`nAlt+A -> Pausa/Ativa o Drag&Drop`n`n`n*LButton = Botão esquerdo do mouse
Return

MenuSobre:
    MsgBox, Eae bando de sem vida <3`n`n`n                                     Programa criado por Felipe Weiss
Return

clickAutoPush:
    if(auto_Push_status = 0){
        GuiControl, Principal:, btn_AutoPush, On
        GuiControl, Principal:Enabled, autoPush_Pos_Status
        auto_Push_status := 1
    }
    else {
        GuiControl, Principal:, btn_AutoPush, Off
        GuiControl, Principal:Disable, autoPush_Pos_Status
        auto_Push_status := 0        
    }
Return

^1::
    WinGetTitle, windowName, A
	IfNotInString, windowName, Tibia
	{
		MsgBox, Faça isso somente na tela do Tibia.
        Return
	}
    if(tipoSelecao = 0){
        status |= (1 << 0)
        if(status = 1){
            GuiControl, Principal:, statusBar, Falta definir a posição final da vida.
        } else if(status = 3){
            GuiControl, Principal:, statusBar, O bot se encontra pausado.
            TrayTip, , Life setado com sucesso!, , 0x1
        }
        MouseGetPos, x1_lifeBar, y1_lifeBar
    } else {
        LetUserSelectRect(x1_lifeBar, y1_lifeBar, x2_lifeBar, y2_lifeBar)
        y_med := (y1_lifeBar + y2_lifeBar) / 2
        
        GuiControl, Principal:, statusBar, O bot se encontra pausado.
        TrayTip, , Life setado com sucesso!, , 0x1
    }
Return

^2::
    if(tipoSelecao != 0){
        Return
    }
    WinGetTitle, windowName, A
	IfNotInString, windowName, Tibia
	{
		MsgBox, Faça isso somente na tela do Tibia.
        Return
	}
    status |= (1 << 1)
    if(status = 2){
        GuiControl, Principal:, statusBar, Falta definir a posição inicial da vida.
    } else if(status = 3){
        GuiControl, Principal:, statusBar, O bot se encontra pausado.
        TrayTip, , Life setado com sucesso!, , 0x1
    }
    MouseGetPos, x2_lifeBar, y2_lifeBar
Return

^k::
    MouseGetPos, autoPush_x, autoPush_y
    GuiControl, Principal:, autoPush_Pos_Status, X = %autoPush_x%`nY = %autoPush_y%
Return

!a::
    goto clickAutoPush
Return

~^LButton::
    if(auto_Push_status = 0){
        Send ^LButton
        Return
    }
    MouseGetPos, x, y
    Send, {Ctrl down}
    MouseClickDrag, Left, x, y, autoPush_x, autoPush_y, 0
    Send, {Ctrl up}
    MouseMove, x, y, 0
Return

^+1::
    WinGetTitle, windowName, A
	IfNotInString, windowName, Tibia
	{
		MsgBox, Faça isso somente na tela do Tibia.
        Return
	}
    if(tipoSelecao = 0){
        MouseGetPos, buff_x_1, buff_y_1
        if(varExist(paralyze_x_2)){
            ; GuiControl, Principal:, txtStatusParalyze, Configurado
            TrayTip, , Barra Utility setado com sucesso!, , 0x1
        }
    } else {
        LetUserSelectRect(buff_x_1, buff_y_1, buff_x_2, buff_y_2)
        ; GuiControl, Principal:, txtStatusParalyze, Configurado
        TrayTip, , Barra Utility setado com sucesso!, , 0x1
    }
Return

^+2::
    if(tipoSelecao != 0){
        Return
    }
    MouseGetPos, buff_x_2, buff_y_2
    if(varExist(buff_x_1)){
        ; GuiControl, Principal:, txtStatusParalyze, Configurado
        TrayTip, , Barra Utility setado com sucesso!, , 0x1
    }
Return

CheckBox1:
    GuiControlGet, Check1, Principal:
    if(Check1 = 0){
        GuiControl, Principal:Disable, txtKey1
        GuiControl, Principal:Disable, cbxKey1
        ;GuiControl, Principal:Disable, txtSpell1
        ;GuiControl, Principal:Disable, cbxSpell1
        GuiControl, Principal:Disable, sliderLife1
        GuiControl, Principal:Disable, edtLife1
    } else {
        GuiControl, Principal:Enabled, txtKey1
        GuiControl, Principal:Enabled, cbxKey1
        ;GuiControl, Principal:Enabled, txtSpell1
        ;GuiControl, Principal:Enabled, cbxSpell1
        GuiControl, Principal:Enabled, sliderLife1
        GuiControl, Principal:Enabled, edtLife1
    }
Return


CheckBox2:
    GuiControlGet, Check2, Principal:
    if(Check2 = 0){
        GuiControl, Principal:Disable, txtKey2
        GuiControl, Principal:Disable, cbxKey2
        ;GuiControl, Principal:Disable, txtSpell2
        ;GuiControl, Principal:Disable, cbxSpell2
        GuiControl, Principal:Disable, sliderLife2
        GuiControl, Principal:Disable, edtLife2
    } else {
        GuiControl, Principal:Enabled, txtKey2
        GuiControl, Principal:Enabled, cbxKey2
        ;GuiControl, Principal:Enabled, txtSpell2
        ;GuiControl, Principal:Enabled, cbxSpell2
        GuiControl, Principal:Enabled, sliderLife2
        GuiControl, Principal:Enabled, edtLife2
    }
Return


CheckBox3:
    GuiControlGet, Check3, Principal:
    if(Check3 = 0){
        GuiControl, Principal:Disable, txtKey3
        GuiControl, Principal:Disable, cbxKey3
        ;GuiControl, Principal:Disable, txtSpell3
        ;GuiControl, Principal:Disable, cbxSpell3
        GuiControl, Principal:Disable, sliderLife3
        GuiControl, Principal:Disable, edtLife3
    } else {
        GuiControl, Principal:Enabled, txtKey3
        GuiControl, Principal:Enabled, cbxKey3
        ;GuiControl, Principal:Enabled, txtSpell3
        ;GuiControl, Principal:Enabled, cbxSpell3
        GuiControl, Principal:Enabled, sliderLife3
        GuiControl, Principal:Enabled, edtLife3
    }
Return

CheckParalyze:
    GuiControlGet, checkParalyze, Principal:
    if(checkParalyze = 0){
        GuiControl, Principal:Disable, txtParalyze
        GuiControl, Principal:Disable, cbxKeyParalyze
        ; GuiControl, Principal:Disable, txtStatusParalyze
    } else {
        GuiControl, Principal:Enabled, txtParalyze
        GuiControl, Principal:Enabled, cbxKeyParalyze
        ; GuiControl, Principal:Enabled, txtStatusParalyze
    }
Return

CheckAutoHaste:
    GuiControlGet, checkAutoHaste, Principal:
    if(checkAutoHaste = 0){
        GuiControl, Principal:Disable, txtAutoHaste
        GuiControl, Principal:Disable, cbxKeyAutoHaste
        ;GuiControl, Principal:Disable, txtStatusParalyze
    } else {
        GuiControl, Principal:Enabled, txtAutoHaste
        GuiControl, Principal:Enabled, cbxKeyAutoHaste
        ;GuiControl, Principal:Enabled, txtStatusParalyze
    }
Return

Slider1Move:
    Gui, Principal:Submit, nohide
    GuiControl, Principal:, edtLife1, %sliderLife1%
Return

Slider2Move:
    Gui, Principal:Submit, nohide
    GuiControl, Principal:, edtLife2, %sliderLife2%
Return

Slider3Move:
    Gui, Principal:Submit, nohide
    GuiControl, Principal:, edtLife3, %sliderLife3%
Return

Edit1Modify:
    Gui, Principal:Submit, nohide
    GuiControl, Principal:, sliderLife1, %edtLife1%
Return

Edit2Modify:
    Gui, Principal:Submit, nohide
    GuiControl, Principal:, sliderLife2, %edtLife2%
Return

Edit3Modify:
    Gui, Principal:Submit, nohide
    GuiControl, Principal:, sliderLife3, %edtLife3%
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

/*
^x::
    goto run
Return

^z::
    MouseGetPos, x, y
    PixelGetColor, pixelColor, %x%, %y%, RGB
    MsgBox, %pixelColor%
Return
*/

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
    GuiControlGet, Check1, Principal:
    if(Check1 = 1){
        GuiControlGet, edtLife1, Principal:
        life1 := % edtLife1
        x_pos := min_x + ((max_x - min_x) * life1) / 100.0
        ;y_pos := min_y + ((max_y - min_y) * life1) / 100.0
        y_pos := y_med
        PixelGetColor, lifeColor, x_pos, y_pos, RGB
        if(isBlack(lifeColor) = 1){
            GuiControlGet, key1, Principal:, cbxKey1
            send {%key1%}
        }
    }
    GuiControlGet, Check2, Principal:
    if(Check2 = 1){
        GuiControlGet, edtLife2, Principal:
        life2 := % edtLife2
        x_pos := min_x + ((max_x - min_x) * life2) / 100.0
        ;y_pos := min_y + ((max_y - min_y) * life2) / 100.0
        y_pos := y_med
        ; MsgBox, %x_pos% %y_pos%
        PixelGetColor, lifeColor, %x_pos%, %y_pos%, RGB
        if(isBlack(lifeColor) = 1){
            GuiControlGet, key2, Principal:, cbxKey2
            send {%key2%}
        }
    }
    GuiControlGet, Check3, Principal:
    if(Check3 = 1){
        GuiControlGet, edtLife3, Principal:
        life3 := % edtLife3
        x_pos := min_x + ((max_x - min_x) * life3) / 100.0
        ;y_pos := min_y + ((max_y - min_y) * life3) / 100.0
        y_pos := y_med
        PixelGetColor, lifeColor, %x_pos%, %y_pos%, RGB
        if(isBlack(lifeColor) = 1){
            ; MsgBox, Tem que curar
            GuiControlGet, key3, Principal:, cbxKey3
            send {%key3%}
        }
    }
    GuiControlGet, checkParalyze, Principal:
    if(checkParalyze = 1){
        PixelSearch, pos_x_image, pos_y_image, %buff_x_1%, %buff_y_1%, %buff_x_2%, %buff_y_2%, 0x0000FF, 2, Fast ;images\paralyze.png
        if(ErrorLevel = 0){
            GuiControlGet, key_anti_paralyze, Principal:, cbxKeyParalyze
            send {%key_anti_paralyze%}
        }
    }
    
    GuiControlGet, checkAutoHaste, Principal:
    if(checkAutoHaste = 1){
        ;ImageSearch, pos_x_image, pos_y_image, %buff_x_1%, %buff_y_1%, %buff_x_2%, %buff_y_2%, Imagens\\haste_2.png
        PixelSearch, pos_x_image, pos_y_image, %buff_x_1%, %buff_y_1%, %buff_x_2%, %buff_y_2%, 0x508BB0, 5, Fast
        
        if(ErrorLevel = 1){
            GuiControlGet, key_auto_haste, Principal:, cbxKeyAutoHaste
            send {%key_auto_haste%}
        }
    }
    
Return

btn_Start:
    ; Pause, Toggle, 1
    if(status = 0){
        status := 1
        SetTimer, run, %timer%
    } else {
        status := 0
        SetTimer, run, off
    }
    

    if(status = 0) {
        GuiControl, Principal:, statusBar, O bot se encontra pausado.
        GuiControl, Principal:, startPause, Start
        TrayTip, , Bot pausado, , 0x1
    } else {
        GuiControl, Principal:, statusBar, O bot está em execução.
        GuiControl, Principal:, startPause, Pause
        TrayTip, , Bot iniciado, , 0x1
    }
		
	Return
Return

setTimer:
	GuiControlGet, timer, Principal:
	if(timer = ){
		Return
	} else {
        GuiControl, Principal:Enabled, startPause
        /*
        if !A_IsPaused {
            GuiControl, Principal:, startPause, Start
            Pause, Toggle, 1
        }
		SetTimer, run, %timer%
        */
	}
Return

GUIConfiguracaoEscape:
GUIConfiguracaoClose:
    Gui, %A_GUI%: cancel
Return

GUIPrincipalEscape:
GUIPrincipalClose:
    ExitApp
