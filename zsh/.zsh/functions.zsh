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
  cloudflare_zone_id=$(bws get secret b77cd89f-d97a-4368-b1aa-b006000c314b | jq '.value' | tr -d \'\"\')
  cloudflare_api_token=$(bws get secret 4f217f17-3f75-40ff-9e9f-b006000c85dd | jq '.value' | tr -d \'\"\')
  cf-terraforming generate --resource-type "cloudflare_record" --zone $cloudflare_zone_id --token $cloudflare_api_token > imported.tf
}

function cf-infra-import(){
  cloudflare_zone_id=$(bws get secret b77cd89f-d97a-4368-b1aa-b006000c314b | jq '.value' | tr -d \'\"\')
  cloudflare_api_token=$(bws get secret 4f217f17-3f75-40ff-9e9f-b006000c85dd | jq '.value' | tr -d \'\"\')
  cf-terraforming import --resource-type "cloudflare_record" --zone $cloudflare_zone_id --token $cloudflare_api_token | while read -r line; do eval $line; done
}
