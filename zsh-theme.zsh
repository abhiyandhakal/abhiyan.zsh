# colors
local color1=#1da1f2
local color2=#0ff
local color3=#2d8
local color4=#f80
local color5=#efb974
local color6=#fff
local color7=#efb974

autoload -Uz vcs_info
setopt PROMPT_SUBST
export VIRTUAL_ENV_DISABLE_PROMPT=1
local venv_prompt=""


function create_separator() {
	local sep=""

	local terminal_width=$(tput cols)
	local prompt_skel="╭── %n%m  %2~ "
	local prompt_len=${#${(%):-$prompt_skel}}
	local git_prompt_skel=""
	local git_bare_skel=""
	local venv_prompt_skel=""

	if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]]; then
		local unstaged_count=$(git diff --numstat | wc -l)
		local staged_count=$(git diff --cached --numstat | wc -l)
		local untracked_count=$(git ls-files --others --exclude-standard | wc -l)

		local current_branch=$(git branch --show-current)

		git_prompt_skel+=" ${current_branch} "

		if ((staged_count!=0)); then
			git_prompt_skel+="${staged_count}+ "
		fi

		if ((unstaged_count!=0)); then
			git_prompt_skel+="${unstaged_count}* "
		fi

		if ((untracked_count!=0)); then
			git_prompt_skel+="${untracked_count}! "
		fi
	fi

	if [[ "$(git rev-parse --is-bare-repository 2>/dev/null)" == "true" ]]; then
		local current_branch=$(git branch --show-current)
		local worktree_count=$(($(git worktree list | wc -l) - 1))

		if [[ "${worktree_count}" == "0" ]]; then
			git_bare_skel+="  ${current_branch} "
		else
			git_bare_skel+="  (${worktree_count}) ${current_branch} "
		fi
	fi
	
	if [ "$VIRTUAL_ENV" != "" ]; then
		venv_prompt_skel+="$(basename $VIRTUAL_ENV) "
	fi

	local git_prompt_len=${#git_prompt_skel}
	local venv_prompt_len=${#venv_prompt_skel}
	local git_bare_len=${#git_bare_skel}
	local bare_adjust=0

	if ((git_bare_len > 0)); then
		bare_adjust=1
	fi

	separator_len=$((terminal_width - prompt_len - git_prompt_len - venv_prompt_len - git_bare_len + bare_adjust))

	for ((i=0; i < separator_len; i++)); do
		sep+="󰍴"
	done

	echo "$sep"
}

precmd() {
	vcs_info
	git_bare_prompt=""

	if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]]; then
		prompt_char="○ ⚡"

		local unstaged_count=$(git diff --numstat | wc -l)
		local staged_count=$(git diff --cached --numstat | wc -l)
		local untracked_count=$(git ls-files --others --exclude-standard | wc -l)

		local current_branch=$(git branch --show-current)

		git_prompt="%B%F{$color5}%K{$color5}%F{black}%F{black} ${current_branch} "

		if ((staged_count!=0)); then
			git_prompt+="%F{#080}${staged_count} "
		fi

		if ((unstaged_count!=0)); then
			git_prompt+="%F{black}${unstaged_count} "
		fi

		if ((untracked_count!=0)); then
			git_prompt+="%F{black}${untracked_count}! "
		fi

	else
		prompt_char="○"
		git_prompt=""
	fi

	if [[ "$(git rev-parse --is-bare-repository 2>/dev/null)" == "true" ]]; then
		prompt_char="○ ⚡"
		local current_branch=$(git branch --show-current)
		local worktree_count=$(($(git worktree list | wc -l) - 1))

		git_bare_prompt="%B%F{$color7}%K{$color7}%F{black}%F{black} "

		if [[ "${worktree_count}" == "0" ]]; then
			git_bare_prompt+="${current_branch} "
		else
			git_bare_prompt+="(${worktree_count}) ${current_branch} "
		fi
	else
		git_bare_prompt=""
	fi

	local venv_name=""
	venv_prompt=""
	if [[ -n "$VIRTUAL_ENV" ]]; then
		venv_name=$(basename $VIRTUAL_ENV)
		if [[ -n "$git_prompt" || -n "$git_bare_prompt" ]]; then
			venv_prompt+="%F{$color5}%K{$color6}%K{$color6}%F{black}%B$venv_name "
		else
			venv_prompt+="%K{black}%F{$color6}%K{$color6}%F{black}%B$venv_name "
		fi
	fi

	prompt_top="╭──%B%F{black}%K{${color1}} %n%K{${color2}}%F{${color1}}%F{black}%m%f%k%F{${color2}} %B%F{yellow}%F{${color3}} %b%2~ %f"
	prompt_below="%f╰──${prompt_char}%f"
}

PROMPT='${prompt_top}%F{#644}$(create_separator)$git_prompt$git_bare_prompt$venv_prompt%f%k%b
${prompt_below} '

RPROMPT='%F{#f00}$(if [ $? -ne 0 ]; then echo "󰌑%? "; fi)%f $(date "+%H:%M:%S")'
