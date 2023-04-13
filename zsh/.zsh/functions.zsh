#FUNCTIONS ==========>

#VENV Python COMMANDS
function venv-on(){
  source ./venv/bin/activate
}

function venv-create(){
  python3 -m venv venv
  source ./venv/bin/activate
  pip install pynvim
}
