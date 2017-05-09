# This theme for gitprompt.sh is optimized for the "Solarized Dark" and 
# "Solarized Light" color schemes tweaked for Ubuntu terminal fonts

override_git_prompt_colors() {
  GIT_PROMPT_THEME=Custom

  GIT_PROMPT_LEADING_SPACE=0
  GIT_PROMPT_PREFIX=""
  GIT_PROMPT_SUFFIX=""

  GIT_PROMPT_THEME_NAME="Solarized"
  GIT_PROMPT_STAGED="${Yellow}●"
  GIT_PROMPT_CHANGED="${BoldBlue}∆" # delta means change!
  GIT_PROMPT_STASHED="${BoldMagenta}⚑ " # flag character
  GIT_PROMPT_CLEAN="${Green}✔"
  GIT_PROMPT_BRANCH="${Yellow}"

  GIT_PROMPT_END_COMMON="_LAST_COMMAND_INDICATOR_ ${BoldBlue}${Time12a}${ResetColor}"
  GIT_PROMPT_END_USER="\n${GIT_PROMPT_END_COMMON} $ "
  GIT_PROMPT_END_ROOT="\n${GIT_PROMPT_END_COMMON} # "

  GIT_PROMPT_START="\[\e]0;\u@\h: \w\007\]"
  PROMPT_START="\[\e]0;\u@\h: \w\007\]"
  PROMPT_END="${GIT_PROMPT_END_COMMON} \\$ "
}

reload_git_prompt_colors "Solarized"
