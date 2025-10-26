fish prompt, nothing more, nothing less.

## Install

### [fisherman](https://github.com/fisherman/fisherman).

- Add `ndyakov/sip.fish` to your `~/.config/fish/fishfile`
- Run `fisher`

## Configuration

You can customize the colors and prompt style by setting the following variables in your `config.fish`:

### General Colors

```fish
set -g sip_color_yellow dbbc7f   # Default yellow color
set -g sip_color_cyan 83c092     # Default cyan color
set -g sip_color_blue 7fbbb3     # Default blue color
set -g sip_color_green a7c080    # Default green color
set -g sip_color_red e67e80      # Default red color
set -g sip_color_white f2efdf    # Default white color
```

### Vi Mode Colors

```fish
set -g sip_color_vi_insert_success 91a161  # Insert mode (success)
set -g sip_color_vi_insert_error e67e80    # Insert mode (error)
set -g sip_color_vi_normal 0fbbb3          # Normal mode
set -g sip_color_vi_visual e67e80          # Visual mode
```

### Prompt Style

```fish
set -g sip_prompt_style "default"  # Options: "default", "short", or custom string
```

- **`"default"`**: Insert mode shows ` → `, normal mode shows `n] `, visual mode shows `v] `
- **`"short"`**: Insert mode shows `→ `, normal mode shows `n]`, visual mode shows `v]`
- **Custom**: Any custom string you provide will be used for all modes (e.g., `set -g sip_prompt_style "$ "`)

### Demo

![Screenshot](screenshot.png?raw=true "Screenshot")

-----

[![asciicast](https://asciinema.org/a/32mrN5nW6cotdPI8MEGPzfFcs.png)](https://asciinema.org/a/32mrN5nW6cotdPI8MEGPzfFcs)
