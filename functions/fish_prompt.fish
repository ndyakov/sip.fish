# name: sip.fish
function fish_mode_prompt; end
function fish_greeting; end

function _git_branch_name
  echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end

function fish_right_prompt
  set -l colyellow (set_color yellow)
  set -l colbyellow (set_color -o yellow)
  set -l colcyan   (set_color cyan)
  set -l colbcyan  (set_color -o cyan)
  set -l colblue  (set_color blue)
  set -l colbblue (set_color -o blue)
  set -l colgreen  (set_color green)
  set -l colbgreen (set_color -o green)
  set -l colnormal (set_color normal)
  set -l colred    (set_color red)
  set -l colbred   (set_color -o red)
  set -l colwhite  (set_color white)
  set -l colbwhite  (set_color -o white)
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

  echo -n -s "$git_info $directory_info"
end


function fish_prompt
  set -l last_status $status
  set -l colyellow (set_color yellow)
  set -l colcyan   (set_color cyan)
  set -l colbcyan  (set_color -o cyan)
  set -l colblue  (set_color blue)
  set -l colbblue (set_color -o blue)
  set -l colgreen  (set_color green)
  set -l colbgreen (set_color -o green)
  set -l colnormal (set_color normal)
  set -l colred    (set_color red)
  set -l colbred   (set_color -o red)
  set -l colwhite  (set_color white)
  set -l colbwhite  (set_color -o white)
  function fish_mode_prompt; end

  # insert mode color
  if test $last_status = 0
    set colbi (set_color -o 2d4)
  else
    set colbi (set_color -o e11)
  end

  set -l ps_vi ""
  # normal mode color
  set -l colbn (set_color -o 778)
  # visual mode color
  set -l colbv (set_color -o e18)

  if test "$fish_key_bindings" = "fish_vi_key_bindings" -o "$fish_key_bindings" = "my_fish_key_bindings" 
    switch $fish_bind_mode
      case default
        set ps_vi $colbn"[n] "$colnormal
      case insert
        set ps_vi $colbi"→ "$colnormal
      case visual
        set ps_vi $colbv"[v] "$colnormal
    end
  else
    set ps_vi $colbi"→ "$colnormal
  end

  if [ (which rbenv) ]
    if [ (rbenv version-name) ]
      set ruby_version (rbenv version-name)
      set ruby_info "$colred($ruby_version)$colnormal"
    end
  end

  echo -n -s $ps_vi
end
