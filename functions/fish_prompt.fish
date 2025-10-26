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
  set -g colyellow (set_color dbbc7f)
  set -g colbyellow (set_color -o dbbc7f)
  set -g colcyan   (set_color 83c092)
  set -g colbcyan  (set_color -o 83c092)
  set -g colblue  (set_color 7fbbb3)
  set -g colbblue (set_color -o 7fbbb3)
  set -g colgreen  (set_color a7c080)
  set -g colbgreen (set_color -o a7c080)
  set -g colnormal (set_color normal)
  set -g colred    (set_color e67e80)
  set -g colbred   (set_color -o e67e80)
  set -g colwhite  (set_color f2efdf)
  set -g colbwhite  (set_color -o f2efdf)
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

  # insert mode color
  if test $last_status = 0
    set colbi (set_color -o 91a161)  # green
  else
    set colbi (set_color -o e67e80)  # red
  end

  set -l ps_vi ""
  # normal mode color
  set -l colbn (set_color -o 0fbbb3) #blue
  # visual mode color
  set -l colbv (set_color -o e67e80) #red

  if test "$fish_key_bindings" = "fish_vi_key_bindings" -o "$fish_key_bindings" = "my_fish_key_bindings" 
    switch $fish_bind_mode
      case default
        set ps_vi $colbn"n] "$colnormal
      case insert
        set ps_vi $colbi" → "$colnormal
      case visual
        set ps_vi $colbv"v] "$colnormal
    end
  else
    set ps_vi $colbi" → "$colnormal
  end

  echo -n -s $ps_vi
end
