alias ll="ls -al"
alias tr="trans -b en:tr"
alias tur="trans -b en:tr"
alias tf="terraform"
alias kc="kubectl"
alias fc="faas-cli"
alias cps="clear && docker ps"
alias cdprojects="cd ~/workspace/projects"

export GOPATH="~/workspace/go"
export GO111MODULE=on
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"
export OPENFAAS_PREFIX="ugurozgen"
export OPENFAAS_URL=""
export PS1="\[\033[01;32m\]___\n\[\033[01;32m\]\w : \h : \t\n# \[\033[00m\]"

#for macos
pfp(){
	lsof -nP -i4TCP:$1 | grep LISTEN | awk '{ print $2 }'
}
