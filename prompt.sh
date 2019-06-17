find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch=" ($branch)"
  else
    git_branch=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty='*'
  else
    git_dirty=''
  fi
}

PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

# TODO add clock
if [ -f /.dockerenv  ]; then
  export PS1="\n\[$bakred\] docker \[$txtrst\] \[$txtblk\][\u@\h]\[$txtrst\] \w\[$txtylw\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\] # "
else
  export PS1="\n\[$bakwht\]\[$txtblk\]\u\[$txtrst\] \[$bldred\]\w\[$txtrst\]\[$txtylw\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\] > "
fi
