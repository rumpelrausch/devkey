#InstallKeybdHook
#SingleInstance ignore

SendMode Input
SetCapsLockState, alwaysoff

oKeys := {"time": 0.35, "q":"{", "w":"}", "a":"[", "s":"]", "y":"<", "z":"<", "x":">", "i":"|"}
time := oKeys.time
holdKey := ""
ignoreKey := ""

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

^Del::Send {Ins}
PrintScreen::Send ^{Home}
!PrintScreen::Send {PrintScreen}

*Capslock::
return


$a::
$b::
$c::
$d::
$e::
$f::
$g::
$h::
$i::
$j::
$k::
$l::
$m::
$n::
$o::
$p::
$q::
$r::
$s::
$t::
$u::
$v::
$w::
$x::
$y::
$z::
$ä::
$ö::
$ß::
  gosub handleKey
  Return

handleKey:
  global holdKey, ignoreKey
  StringReplace, key, A_ThisHotkey, $
  state := GetKeyState("RAlt")
  If ( (key = "q") AND (GetKeyState("RAlt") = 1) OR (GetKeyState("LAlt") = 1) OR (GetKeyState("RWin") = 1) OR (GetKeyState("LWin") = 1))
  {
   Send,@
  }
  else
  {
    if (holdKey != "")
    {
      ignoreKey = key
      send {%holdKey%}
      return
    }
    repl := oKeys[key]
    ; send {%key%}
    if repl
    {
      holdKey := key
      KeyWait %key%, t%time%
      holdKey := ""
      if errorlevel
      {
        if (ignoreKey = key)
        {
          return
        }
        send {Raw}%repl%
        KeyWait, %key%, U
      }
      else
      {
        send {%key%}
      }
      return
    }
    send {%key%}
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
