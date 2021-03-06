local IT="${terminfo[sitm]}${terminfo[bold]}"
local ST="${terminfo[sgr0]}${terminfo[ritm]}"

local FMT_BRANCH="%F{9}(%s:%F{7}%{$IT%}%r%{$ST%}%F{9}) %F{11}%B%b %K{235}%{$IT%}%u%c%{$ST%}%k"
local FMT_ACTION="(%F{3}%a%f)"
local FMT_PATH="%F{1}%R%F{2}/%S%f"

function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

setprompt() {
  local USER="%(#.%F{1}.%F{3})%n%f"
  local HOST="%F{3}%M%f"
  local PWD="%F{2}$(collapse_pwd)%f"
  local TTY="%F{4}%y%f"
  local EXIT="%(?..%F{202}%?%f)"
  local PRMPT="%F{202}λ%f $HOST ${PWD}"

  if [[ "${vcs_info_msg_0_}" == "" ]]; then
    PROMPT="$PRMPT %F{202}→%f "
  else
    PROMPT="$PRMPT ${vcs_info_msg_0_} %F{202}→%f "
  fi
}
