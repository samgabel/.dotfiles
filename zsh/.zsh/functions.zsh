#FUNCTIONS ==========>


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
  else
    echo "Virtual environment creation aborted."
  fi
}


#CF-Terraforming COMMANDS
function cf-infra-generate(){
  cf-terraforming generate --resource-type "cloudflare_record" --zone $CLOUDFLARE_ZONE_ID > imported.tf
}

function cf-infra-import(){
  cf-terraforming import --resource-type "cloudflare_record" --zone $CLOUDFLARE_ZONE_ID | while read -r line; do eval $line; done
}
