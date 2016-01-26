function init --on-event init_fasd
  if not available fasd
    echo "Please install 'fasd' first!"
    return
  end

  function __fasd_run -e fish_preexec
    command fasd --proc (command fasd --sanitize "$argv") > "/dev/null" 2>&1 &
  end

  function fasd_cd -d 'Function to execute built-in cd'
    if test (count $argv) -le 1
      command fasd "$argv"
    else
      set -l ret (command fasd -e 'printf %s' $argv)
      test -z "$ret";
        and return
      test -d "$ret";
        and cd "$ret";
        or printf "%s\n" $ret
    end
  end

  function a; command fasd -a $argv; end
  function d; command fasd -d $argv; end
  function f; command fasd -f $argv; end
  function s; command fasd -si $argv; end
  function sd; command fasd -sid $argv; end
  function sf; command fasd -sif $argv; end
  function z; fasd_cd -d $argv; end
  function zz; fasd_cd -di $argv; end

  alias j "z"
end