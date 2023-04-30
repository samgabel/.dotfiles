#FUNCTIONS ==========>


#VENV Python COMMANDS
function venv-on(){
  source ./venv/bin/activate
}

function venv-create(){
  python3 -m venv venv
  source ./venv/bin/activate
  pip install --upgrade pip
  pip install pynvim
}


#CF-Terraforming COMMANDS
function cf-infra-generate(){
  cf-terraforming generate --resource-type "cloudflare_record" --zone $CLOUDFLARE_ZONE_ID > imported.tf
}

function cf-infra-import(){
  cf-terraforming import --resource-type "cloudflare_record" --zone $CLOUDFLARE_ZONE_ID | while read -r line; do eval $line; done
}
