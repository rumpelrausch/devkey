# DevKey - typing brackets the easy way
+ Windows only - *sorry*
+ Nerds only - *not sorry at all*

## Tired of twisting your arm in order to type `{`, `}`, `[`, `]` and `|`?
On most non-US keyboard layouts typing those keys means pushing your right elbow forward and use some ALT or ALTGR key combination. That's lame. Not that anybody cares, but it's unhealthy too. After a day of creating functions, arrays etc. your shoulders ache (which also is a great excuse to demand a massage, so this tool might not be optimal for everyone).

## Installation
There's no installer. You're a programmer; Where you're going you aint need no *installers*.
1. Download `DevKey.exe` from the latest release (https://github.com/rumpelrausch/devkey/releases).
2. Run it (it appears as taskbar icon)
3. [optional] Create a shortcut to the executable within the "magic" folder `shell:startup`.

## Usage
Once running and enabled, some easily reachable keys can be hold for a short time in order to emit one of the desired programming symbols.

| key | emits |
|:--:|:--:|
| `q` | `{` |
| `w` | `}` |
| `a` | `[` |
| `s` | `]` |
| `<` | `|` |

*(That's the gaming keys; Your left hand knows where they are.)*

Devkey will emit the original key, shortly followed by `BACKSPACE` and the replacement character. This might not work with every program, but most editors and IDEs accept it.

### Runtime options
DevKey sits in your taskbar. You might want to modify the taskbar settings to always show the DevKey icon.

The taskbar icon resembles a keyboard, coloured either green (enabled) or red (disabled).
Right-clicking the icon shows a mini menu to disable/enable or quit DevKey.

There's also a help option, but clicking it is considered uncool.

## Implementation
DevKey is written as an [Autohotkey](https://www.autohotkey.com/) script.
That's why it will only work on Windows: Autohotkey is tightly integrated into the Windows infrastructure.

If you use a local installation of Autohotkey you will also be able to run DevKey from its source script, `DevKey.ahk`. Feel free to tweak it; Autohotkey is a wonderful playground. Don't blame me for any wasted time, though.

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
