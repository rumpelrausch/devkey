# DevKey - typing brackets the easy way

## Tired of twisting your arm in order to type `{`, `}`, `[`, `]` and `|`?
On many non-US keyboard layouts typing those keys means pushing your right elbow forward and use some ALT or ALTGR key combination. That's lame. Not that anybody cares, but it's unhealthy too. After a day of creating functions, arrays etc. your shoulders ache (which also is a great excuse to demand a massage, so this tool might not be optimal for everyone).

This is an attempt to align with the usual (right-handed) hands positions:<br>
Left hand is on keyboard, right hand holds the mouse.

It's opinionated; Especially the sharp brackets (`< >`) are only implemented because my
personal keyboard lacks them. But this is Autohotkey; Just create your own mappings if you like.

## Installation
There's no installer. Where we're going we aint gonna need no *installers*.<br>
It does not write to the registry, but it unpacks its icons into the folder where
`DevKey.exe` is stored.

1. Download `DevKey.exe` from the latest release (https://github.com/rumpelrausch/devkey/releases).
2. Run it (it appears as taskbar icon)
3. [optional] Create a shortcut to the executable within the "magic" folder `shell:startup`.

## Usage
Holding any of these keys for a short period triggers the replacement key.<br>
Releasing the key earlier emits the original key.

| key | emits |
|:--:|:--:|
| `q` | `{` |
| `w` | `}` |
| `a` | `[` |
| `s` | `]` |
| `y` | `<` |
| `z` | `<` |
| `x` | `>` |
| `i` | `\|` |


As a side effect, the auto repeat function is disabled on those keys.

### Immediate keys
These replacements are applied always without any delay:

| key | emits | reason |
|--|--|--|
| `PrintScreen` | `CTRL-HOME` | On a small keyboard it's so conveniently positioned. |
| `Shift-PrintScreen` | `PrintScreen` | Every so often you just need PrintScreen. |

### Runtime options
DevKey sits in your taskbar. You might want to modify the taskbar settings to always show the DevKey icon.

The taskbar icon resembles a keyboard, coloured either green (enabled) or red (disabled).
Right-clicking the icon shows a mini menu to disable/enable or quit DevKey.

There's also a help option. Using it is considered uncool.

## Implementation
DevKey is written as an [Autohotkey](https://www.autohotkey.com/) script.
Autohotkey is only available for the Windows OS, so DevKey will only work on that ecosystem.

If you use a local installation of Autohotkey you will also be able to run DevKey from its source script, `DevKey.ahk`. Feel free to tweak it; Autohotkey is a wonderful playground.

## Compilation
Autohotkey comes with its own compiler which can be invoked as such:
```cmd
COMPILER_PATH\Ahk2Exe.exe /in DevKey.ahk /out DevKey.exe /icon keyboard-on.ico
```

## Consequences and side effects
You might get addicted to DevKey in the same manner as to the mousewheel:  
It may feel awkward to use a computer without it.

When working at a collegues' keyboard your reputation might decrease for a while as you emit a number of `q`s instead of a starting block. The only chance to regain reputation will be to accept your own nerdiness publicly. Best practise: Infect others with DevKey.

You have been warned.
