# name: sip.fish
function fish_mode_prompt; end
function fish_greeting; end

function _git_branch_name
  echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end

function _set_colors
  # Set default colors if not already configured
  set -q sip_color_yellow; or set -g sip_color_yellow dbbc7f
  set -q sip_color_cyan; or set -g sip_color_cyan 83c092
  set -q sip_color_blue; or set -g sip_color_blue 7fbbb3
  set -q sip_color_green; or set -g sip_color_green a7c080
  set -q sip_color_red; or set -g sip_color_red e67e80
  set -q sip_color_white; or set -g sip_color_white f2efdf

  # Apply colors
  set -g colyellow (set_color $sip_color_yellow)
  set -g colbyellow (set_color -o $sip_color_yellow)
  set -g colcyan   (set_color $sip_color_cyan)
  set -g colbcyan  (set_color -o $sip_color_cyan)
  set -g colblue  (set_color $sip_color_blue)
  set -g colbblue (set_color -o $sip_color_blue)
  set -g colgreen  (set_color $sip_color_green)
  set -g colbgreen (set_color -o $sip_color_green)
  set -g colnormal (set_color normal)
  set -g colred    (set_color $sip_color_red)
  set -g colbred   (set_color -o $sip_color_red)
  set -g colwhite  (set_color $sip_color_white)
  set -g colbwhite  (set_color -o $sip_color_white)
end

function fish_right_prompt
  _set_colors
  set git_info ""
  if [ (_git_branch_name) ]
    set -l git_branch $colwhite(_git_branch_name)
    set git_info "$git_branch"

    if [ (_is_git_dirty) ]
      set git_info "$colbcyan $git_info $colbred!=$colnormal "
    else
      set git_info "$colbcyan $git_info $colbgreen==$colnormal "
    end

  end

  set -l path (prompt_pwd)
  set -l directory_info "$path"
    if test $CMD_DURATION
        # Show duration of the last command in seconds
        set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')
    end

  echo -n -s "$duration $git_info $directory_info"
end


function fish_prompt
  set -l last_status $status
  _set_colors
  function fish_mode_prompt; end

  # Set default vi mode colors if not already configured
  set -q sip_color_vi_insert_success; or set -g sip_color_vi_insert_success 91a161
  set -q sip_color_vi_insert_error; or set -g sip_color_vi_insert_error e67e80
  set -q sip_color_vi_normal; or set -g sip_color_vi_normal 0fbbb3
  set -q sip_color_vi_visual; or set -g sip_color_vi_visual e67e80

  # Set default prompt style if not already configured
  # Options: "default" (default), "short", or custom string
  set -q sip_prompt_style; or set -g sip_prompt_style "default"

  # Determine prompt symbols based on style
  if test "$sip_prompt_style" = "default"
    set -l prompt_insert " → "
    set -l prompt_normal "n] "
    set -l prompt_visual "v] "
  else if test "$sip_prompt_style" = "short"
    set -l prompt_insert "→ "
    set -l prompt_normal "n]"
    set -l prompt_visual "v]"
  else
    # Custom prompt - use the value as-is
    set -l prompt_insert "$sip_prompt_style"
    set -l prompt_normal "$sip_prompt_style"
    set -l prompt_visual "$sip_prompt_style"
  end

  # insert mode color
  if test $last_status = 0
    set colbi (set_color -o $sip_color_vi_insert_success)  # green
  else
    set colbi (set_color -o $sip_color_vi_insert_error)  # red
  end

  set -l ps_vi ""
  # normal mode color
  set -l colbn (set_color -o $sip_color_vi_normal) #blue
  # visual mode color
  set -l colbv (set_color -o $sip_color_vi_visual) #red

  if test "$fish_key_bindings" = "fish_vi_key_bindings" -o "$fish_key_bindings" = "my_fish_key_bindings"
    switch $fish_bind_mode
      case default
        set ps_vi $colbn$prompt_normal$colnormal
      case insert
        set ps_vi $colbi$prompt_insert$colnormal
      case visual
        set ps_vi $colbv$prompt_visual$colnormal
    end
  else
    set ps_vi $colbi$prompt_insert$colnormal
  end

  echo -n -s $ps_vi
end
