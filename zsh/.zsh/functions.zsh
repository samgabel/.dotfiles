#Turning PROXMOX On
function proxmox-on(){

  echo qwerty | sudo -S wakeonlan d4:be:d9:8e:4b:7b

  }


#Opening PROXMOX Dashboard
function proxmox-dashboard(){

  open https://10.6.1.2:8006/

  }
