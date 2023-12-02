# GLOBAL FUNCTIONS =======================================================================================================================>

#VENV Python COMMANDS
function venv-on(){
  if [ -d "./venv" ]; then
    source ./venv/bin/activate
    #argcomplete(Ansible)
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

function venv-create(){
  local dir=$(basename $(pwd))
  echo -n "Create and activate virtual environment at $dir? [Y/n] "
  read answer

  if [[ $answer =~ ^[Yy]$ || $answer == "" ]]; then
    python3 -m venv venv
    source ./venv/bin/activate
    pip install --upgrade pip
    pip install pynvim
    if [ -f "./ansible.cfg" ]; then
      pip install ansible argcomplete
      deactivate
      venv-on
    fi
  else
    echo "Virtual environment creation aborted."
  fi
}


# MBP FUNCTIONS ==========================================================================================================================>

#Directory-Hopping COMMAND
function d () {
  [ "$1" = ".dotfiles" ] && cd ~/.dotfiles && ll
  [ "$1" = ".config" ] && cd ~/.config && ll
  [ "$1" = ".zsh" ] && cd ~/.zsh && ll
  [ "$1" = "ansible" ] && cd ~/Projects/Ansible && ll
  [ "$1" = "devel" ] && cd ~/Projects/Devel && ll
  [ "$1" = "terraform" ] && cd ~/Projects/Terraform && ll
  [ "$1" = "important" ] && cd ~/Desktop/important && ll
  [ "$1" = "secrets" ] && cd ~/Secrets && ll
}

#Find and Replace COMMAND
function rename_files () {
  if [ "$#" -ne 2 ]; then
      echo "Usage: replace old_text new_text"
      return 1
  fi
  old_text="$1"
  new_text="$2"
  find ./ -type "f" -name "*$old_text*" -exec bash -c 'mv "$1" "${1/'"$old_text/$new_text"'}"' _ {} \;
}

#GPG-Sign+Encrypt COMMANDS
function secret () {
  output=$PWD/"${1}".$(date +%Y-%m-%d).enc
  echo "Who do you want to send it to?"
  gpg --list-keys --with-colons | awk -F: '/^uid/{print $10}'
  echo -n "-> "
  read recipient
  gpg --sign --encrypt --armor --output ${output} -r ${recipient} "${1}" && echo "${1} -> ${output}"
  [ -f ${output} ] && rm -f "${1}"
}

function reveal () {
	output=$(echo "${1}" | rev | cut -c16- | rev)
	gpg --decrypt --output ${output} "${1}" && echo "${1} -> ${output}"
  [ -f ${output} ] && rm -f "${1}"
}

#CF-Terraforming COMMANDS
function cf-infra-generate(){
  cloudflare_zone_id=$(bws get secret b77cd89f-d97a-4368-b1aa-b006000c314b | jq '.value' | tr -d \'\"\')
  cloudflare_api_token=$(bws get secret 4f217f17-3f75-40ff-9e9f-b006000c85dd | jq '.value' | tr -d \'\"\')
  cf-terraforming generate --resource-type "cloudflare_record" --zone $cloudflare_zone_id --token $cloudflare_api_token > imported.tf
}

function cf-infra-import(){
  cloudflare_zone_id=$(bws get secret b77cd89f-d97a-4368-b1aa-b006000c314b | jq '.value' | tr -d \'\"\')
  cloudflare_api_token=$(bws get secret 4f217f17-3f75-40ff-9e9f-b006000c85dd | jq '.value' | tr -d \'\"\')
  cf-terraforming import --resource-type "cloudflare_record" --zone $cloudflare_zone_id --token $cloudflare_api_token | while read -r line; do eval $line; done
}


# APOLLO FUNCTIONS =======================================================================================================================>

#Crowdsec Metrics
function crowdsec-metrics(){
  docker exec crowdsec cscli metrics
}
#Crowdsec View Decisions List
function crowdsec-list(){
  docker exec crowdsec cscli decisions list
}
#Crowdsec Add Decision
function crowdsec-add(){
  docker exec crowdsec cscli decisions add --ip "$@"
}
#Crowdsec Delete Decision
function crowdsec-delete(){
  docker exec crowdsec cscli decisions delete --ip "$@"
}
