﻿; Generated by AutoGUI 2.5.4
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui Font, s16 Bold, Tahoma
Gui Add, Text, x28 y12 w154 h31 +0x200, Configurações
Gui Font
Gui Add, Text, x18 y67 w65 h23 +0x200, Setar a vida:
Gui Add, Radio, x100 y54 w120 h23, Point-and-Click
Gui Add, Radio, x100 y84 w133 h23, Seleção com retângulo
Gui Add, Text, x55 y128 w28 h23 +0x200, Som:
Gui Add, Slider, x95 y130 w203 h32, 50
Gui Add, Button, x135 y189 w80 h23, &Salvar
Gui Add, Button, x229 y189 w80 h23, &Sair

Gui Show, w319 h227, Window
Return

GuiEscape:
GuiClose:
    ExitApp
