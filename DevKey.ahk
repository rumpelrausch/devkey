InstallKeybdHook()
#SingleInstance force

SendMode("Input")
SetCapsLockState("alwaysoff")

keyMap := Map.Call(
  "q", "{",
  "w", "}",
  "a", "[",
  "s", "]",
  "y", "<",
  "z", "<",
  "x", ">",
  "i", "|"
)
holdTime := 0.25
holdKey := ""
ignoreKey := ""

FileInstall("keyboard-on.ico", "keyboard-on.ico", 1)
FileInstall("keyboard-off.ico", "keyboard-off.ico", 1)
FileInstall("poweroff.ico", "poweroff.ico", 1)
FileInstall("info-circle.ico", "info-circle.ico", 1)

tray := A_TrayMenu
tray.Delete()
TraySetIcon("keyboard-on.ico", "1", "1")
; TrayTip, DevKey, DevKey wurde geladen.
tray.add("ON / OFF", toggle)
tray.Default := "ON / OFF"
tray.SetIcon("ON / OFF", "keyboard-off.ico")
tray.add("WTF?", help)
tray.SetIcon("WTF?", "info-circle.ico")
tray.add()
tray.add("Exit", bailout)
tray.SetIcon("Exit", "poweroff.ico")
tray.Default := "ON / OFF"
tray.clickCount := 1

return

^Del:: Send("{Ins}")
PrintScreen:: Send("^{Home}")
!PrintScreen:: Send("{PrintScreen}")

*Capslock::
{
  global
  return
}


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
{
  global
  handleKey()
  Return
}

handleKey()
{
  global
  global holdKey
  Thread "Priority", 1000
  key := StrReplace(A_ThisHotkey, "$", , , , 1)
  state := GetKeyState("RAlt")
  If ((key = "q") AND (GetKeyState("RAlt") = 1) OR (GetKeyState("LAlt") = 1) OR (GetKeyState("RWin") = 1) OR (GetKeyState("LWin") = 1))
  {
    send("@")
  }
  else
  {
    if (holdKey != "")
    {
      send("{" holdKey "}")
      if(holdKey != key)
      {
        holdKey := ""
      }
     return
    }
    if keyMap.Has(key)
    {
      replacementKey := keyMap[key]
      holdKey := key
      ErrorLevel := !KeyWait(key, "t" holdTime)
      holdKey := ""
      if ErrorLevel
      {
        send("{Raw}" replacementKey)
        ErrorLevel := !KeyWait(key, "U")
      }
      else
      {
        send("{" key "}")
      }
      return
    }
    send("{" key "}")
  }
  return
}

toggle(A_ThisMenuItem := "", A_ThisMenuItemPos := "", MyMenu := "", *)
{
  global
  Suspend()
  if (A_IsSuspended = 1)
  {
    TraySetIcon("keyboard-off.ico", "1", "1")
    A_IconTip := "DevKey - OFF"
  }
  else
  {
    TraySetIcon("keyboard-on.ico", "1", "1")
    A_IconTip := "DevKey - ON"
  }
  return
}

bailout(A_ThisMenuItem := "", A_ThisMenuItemPos := "", MyMenu := "", *)
{
  global
  ExitApp()
  return
}

help(A_ThisMenuItem := "", A_ThisMenuItemPos := "", MyMenu := "", *)
{
  global
  MsgBox("
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
  )", "DevKey - You would miss it.", 64)
  return
}
