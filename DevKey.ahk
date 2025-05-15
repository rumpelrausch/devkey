InstallKeybdHook()
#SingleInstance force

class Debounce {
	__New(key, releasetime := 33.3, holdtime := 33.3) {
		this.key := key
		this.keydown_action := "{" key " down}"
		this.keyup_action := "{" key " up}"
		this.releasetime := releasetime  ; minimum key released time
		this.holdtime := holdtime  ; minimum key hold time
		this.timeup := -1  ; time of last key up was sent
		this.timedown := -1  ; time of last key down was sent
		
		; requires Bind(), otherwise this = Hotkeyname in the function
		Hotkey(this.key      , this.down.Bind(this))
		Hotkey(this.key " Up", this.up.Bind(this))
	}
	
	down(*) {
		if((time() - this.timeup) > this.releasetime || this.timeup = -1) {
			; cooldown has elapsed
			if(!GetKeyState(this.key))  ; key released, reset timer
				this.timedown := time()
			SendInput this.keydown_action
		}
	}
	
	up(*) {
		if((time() - this.timedown) > this.holdtime || this.timedown = -1) {
			; cooldown has elapsed
			if(GetKeyState(this.key))  ; key held, reset timer
				this.timeup := time()
			SendInput this.keyup_action
		}
	}
}

; calculate time interval using Windows high resolution timestamps
DllCall("QueryPerformanceFrequency", "Int64*", &frequency := 0) ; get timer frequency. usually microsecond resolution
time() {
	; returns time in miliseconds
	; A_TickCount only gives 10ms resolution up to ~50 days, so we use QueryPerformanceCounter instead https://www.autohotkey.com/docs/v2/lib/DllCall.htm#ExQPC
	; QueryPerformanceCounter should not overflow for 100 years, so we don't need to worry about that
	; https://stackoverflow.com/a/70987823/823633
	;  https://learn.microsoft.com/en-us/windows/win32/sysinfo/acquiring-high-resolution-time-stamps#general-faq-about-qpc-and-tsc
	DllCall("QueryPerformanceCounter", "Int64*", &counter := 0)
	return counter / frequency * 1000
}

Debounce("MButton", 100, 30)

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

; MButton UP::
; {
;   If (A_ThisHotkey = A_PriorHotkey) && (A_TimeSincePriorHotkey < 10)
;   {
;     return
;   }
;   ; Click("Middle")
;   Click("Up Middle")
; }


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
        replacementKey := key
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
