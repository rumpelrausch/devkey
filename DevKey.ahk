#InstallKeybdHook
#SingleInstance ignore

SendMode Input
SetCapsLockState, alwaysoff

oKeys := {"time": 0.15, "q":"{", "w":"}", "a":"[", "s":"]", "y":"<", "z":"<", "x":">", "i":"|"}
time := oKeys.time

FileInstall,keyboard-on.ico,keyboard-on.ico,0
FileInstall,keyboard-off.ico,keyboard-off.ico,0
FileInstall,poweroff.ico,poweroff.ico,0
FileInstall,info-circle.ico,info-circle.ico,0

Menu, tray, NoStandard
Menu, Tray, Icon, keyboard-on.ico, 1, 1
; TrayTip, DevKey, DevKey wurde geladen.
Menu, tray, add, ON / OFF, toggle
Menu, tray, default, ON / OFF
Menu, tray, icon, ON / OFF, keyboard-off.ico
Menu, tray, click, toggle
Menu, tray, add, WTF?, help
Menu, tray, icon, WTF?, info-circle.ico
Menu, tray, add
Menu, tray, add, Exit, bailout
Menu, tray, icon, Exit, poweroff.ico

return

+Del::Send {Ins}
^Del::Send {Ins}

*Capslock::
return


$q::
$w::
$a::
$s::
$y::
$z::
$x::
$i::
  gosub handleKey
  Return

handleKey:
  StringReplace, key, A_ThisHotkey, $
  state := GetKeyState("RAlt")
  If ( (key = "q") AND (GetKeyState("RAlt") = 1) OR (GetKeyState("LAlt") = 1) OR (GetKeyState("RWin") = 1) OR (GetKeyState("LWin") = 1))
  {
   Send,@
  }
  else
  {
    repl := oKeys[key]
    send {%key%}
    if repl
    {
      KeyWait %key%, t%time%
      if errorlevel
      send {BS 1}{Raw}%repl%
      KeyWait, %key%, U
    }
  }
  return

toggle:
  Suspend
  if A_IsSuspended = 1
  {
    Menu, Tray, Icon, keyboard-off.ico, 1, 1
    Menu, Tray, Tip, DevKey - OFF
  }
  else
  {
    Menu, Tray, Icon, keyboard-on.ico, 1, 1
    Menu, Tray, Tip, DevKey - ON
  }
  return

bailout:
  exitApp
  return

help:
  msgbox,64,DevKey - You would miss it.,
  (
  Hold those keys to trigger special characters:

    q	{
    
    w	}
    
    a	[
    
    s	]
    
    i	|

    y	<
    z	<

    x	>
  )
  return
