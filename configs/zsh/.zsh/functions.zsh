# GLOBAL FUNCTIONS =======================================================================================================================>

## Test Directory ------------------------------------------
function mktest() {
  if [ -d "$HOME/TEST" ]; then
    echo "Test directory already exists"
    cd "$HOME/TEST"
  else
    mkdir "$HOME/TEST"
    cd "$HOME/TEST"
    echo "Test directory created"
  fi
}

function rmtest() {
  if [ -d "$HOME/TEST" ]; then
    echo -n "Delete TEST directory? [Y/n] "
    read answer
    if [[ $answer =~ ^[Yy]$ || $answer == "" ]]; then
      rm -rf "$HOME/TEST"
    else
      echo "Deletion cancelled"
    fi
  else
    echo "No TEST directory use `mktest` to create one"
  fi
}

## VENV Python COMMANDS ------------------------------------
function venv-on() {
  if [ -d "./venv" ]; then
    source ./venv/bin/activate
    ### argcomplete(Ansible)
    if [ -f "./ansible.cfg" ]; then
      echo "󱂚 ansible"
      autoload -Uz compinit
      compinit
      eval "$(register-python-argcomplete ansible)"
    fi
  else
    echo "Virtual environment not found."
  fi
}

function venv-create() {
  local dir=$(basename "$(pwd)")
  echo -n "Create and activate virtual environment at $dir? [Y/n] "
  read -r answer
  if [[ $answer =~ ^[Yy]$ || $answer == "" ]]; then
    echo -n "Which version of Python would you like to use? [e.g., 3.11, 3.12]: "
    read -r python_version
    if [[ "$python_version" =~ ^[0-9]+\.[0-9]+$ ]]; then
      python_exec="python$python_version"
      echo "Using Python version $python_version."
    else
      echo "Invalid Python version format. Aborting."
      return 1
    fi
    "$python_exec" -m venv venv
    source ./venv/bin/activate
    python -m pip install --upgrade pip
    python -m pip install pynvim pytest
    touch ./pyproject.toml
    echo "import sys\nfrom pathlib import Path\n\nbase_dir = Path(__file__).parent\nsrc_path = f'{base_dir}/src'\n\nif src_path not in sys.path:\n    sys.path.append(src_path)" >> conftest.py
    if [ -f "./ansible.cfg" ]; then
      python -m pip install ansible argcomplete
      deactivate
      venv-on
    fi
  else
    echo "Virtual environment creation aborted."
  fi
}

function comp() {
    g++ -std=c++11 "$@" && ./a.out
    rm a.out
}

function lldbcomp() {
    g++ -g -std=c++11 "$@" && lldb a.out
    rm a.out && rm -rf a.out.dSYM
}

function gotestboot() {
    go test "$@"/main.go "$@"/main_test.go -test.v
}

function httpp() {
    http --pretty=all --style=lightbulb --verbose "$@" | less -R
}

function httpsp() {
    https --pretty=all --style=lightbulb --verbose "$@" | less -R
}

function gostruct() {
    if [[ $1 == "" ]]; then
        echo "Need to supply 'http(s) and url'\n e.g.: gostruct http localhost:8080/api\n e.g.: gostruct https pokeapi.co/api/v2/pokemon"
        return
    fi
    json2struct -s $("$1" "$2") | pbcopy
}

function jsonview() {
    if [[ $1 == "" ]]; then
        echo "Need to supply 'http(s) and url'\n e.g.: jsonview http localhost:8080/api\n e.g.: jsonview https pokeapi.co/api/v2/pokemon"
        return
    fi
    "$1" "$2" | jq | nvim -c 'set filetype=json'
}

## Better ENV ----------------------------------------------
function envd() {
    local show_values=false
    local direnv_mode=false
    # Parse flags
    while [[ "$1" != "" ]]; do
        case "$1" in
            -s) show_values=true ;;
            -d) direnv_mode=true ;;
            -ds) direnv_mode=true show_values=true ;;
            -sd) direnv_mode=true show_values=true ;;
            *)
                echo "env illegal option -- $1" >&2
                echo "usage: [-l local] [-s strip]"
                return 1
                ;;
        esac
        shift
    done
    # if both -s and -d are specified
    if [[ "$show_values" == true && "$direnv_mode" == true ]]; then
        mise set | fzf -m | awk '{print $2}'
        return
    fi
    # if only -s is specified
    if [[ "$show_values" == true ]]; then
        env | fzf -m | sed 's/^[^=]*=//'
        return
    fi
    # if only -d is specified
    if [[ "$direnv_mode" == true ]]; then
        mise set | fzf -m | awk '{print $1"="$2}'
        return
    fi
    # default behavior (no options)
    env | fzf -m
}

# MBP FUNCTIONS ==========================================================================================================================>

## Directory-Hopping COMMAND -------------------------------
function d() {
  [ "$@" = ".dotfiles" ] && cd ~/.dotfiles && ll
  [ "$@" = ".config" ] && cd ~/.config && ll
  [ "$@" = ".zsh" ] && cd ~/.zsh && ll
  [ "$@" = "nvim" ] && cd ~/.config/nvim && ll
  [ "$@" = "docs" ] && cd ~/Documents/docs && ll
  [ "$@" = "devel" ] && cd ~/Projects/Devel && ll
  [ "$@" = "ansible" ] && cd ~/Projects/Ansible && ll
  [ "$@" = "terraform" ] && cd ~/Projects/Terraform && ll
  [ "$@" = "important" ] && cd ~/Documents/important && ll
  [ "$@" = "secrets" ] && cd ~/Secrets && ll
}

## CD and LS in same command -------------------------------
function cdl() {
  cd "$1" && ll -a
}

## Find and Replace COMMAND --------------------------------
function rename_files() {
  if [ "$#" -ne 2 ]; then
      echo "Usage: replace old_text new_text"
      return 1
  fi
  old_text="$1"
  new_text="$2"
  find ./ -type "f" -name "*$old_text*" -exec bash -c 'mv "$1" "${1/'"$old_text/$new_text"'}"' _ {} \;
}

## GPG-Sign+Encrypt COMMANDS -------------------------------
function secret() {
  output=$PWD/"${1}".$(date +%Y-%m-%d).enc
  echo "Who do you want to send it to?"
  gpg --list-keys --with-colons | awk -F: '/^uid/{print $10}'
  echo -n "-> "
  read recipient
  gpg --sign --encrypt --armor --output ${output} -r ${recipient} "${1}" && echo "${1} -> ${output}"
  [ -f ${output} ] && rm -f "${1}"
}

function reveal() {
	output=$(echo "${1}" | rev | cut -c16- | rev)
	gpg --decrypt --output ${output} "${1}" && echo "${1} -> ${output}"
  [ -f ${output} ] && rm -f "${1}"
}

## CF-Terraforming COMMANDS ---------------------------------
function cf-infra-generate() {
  cloudflare_zone_id=$(bws get secret b77cd89f-d97a-4368-b1aa-b006000c314b | jq '.value' | tr -d \'\"\')
  cloudflare_api_token=$(bws get secret 4f217f17-3f75-40ff-9e9f-b006000c85dd | jq '.value' | tr -d \'\"\')
  cf-terraforming generate --resource-type "cloudflare_record" --zone $cloudflare_zone_id --token $cloudflare_api_token > imported.tf
}

function cf-infra-import() {
  cloudflare_zone_id=$(bws get secret b77cd89f-d97a-4368-b1aa-b006000c314b | jq '.value' | tr -d \'\"\')
  cloudflare_api_token=$(bws get secret 4f217f17-3f75-40ff-9e9f-b006000c85dd | jq '.value' | tr -d \'\"\')
  cf-terraforming import --resource-type "cloudflare_record" --zone $cloudflare_zone_id --token $cloudflare_api_token | while read -r line; do eval $line; done
}


# APOLLO FUNCTIONS =======================================================================================================================>

## Crowdsec Metrics
function crowdsec-metrics() {
  docker exec crowdsec cscli metrics
}
## Crowdsec View Decisions List
function crowdsec-list() {
  docker exec crowdsec cscli decisions list
}
## Crowdsec Add Decision
function crowdsec-add() {
  docker exec crowdsec cscli decisions add --ip "$@"
}
## Crowdsec Delete Decision
function crowdsec-delete() {
  docker exec crowdsec cscli decisions delete --ip "$@"
}
