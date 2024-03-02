### ARC BROWSER
https://arc.net/

### BITWARDEN SECRETS MANAGER CLI
https://github.com/bitwarden/sdk/releases

### PARSEC REMOTE DESKTOP
https://parsec.app/downloads

### WIRESHARK
While installed with Brew it needs some manual intervention
- delete `/etc/pathds.d/Wireshark` to remove wireshark binary from system $PATH
- link wireshark binary to local binaries with `ln -s /Applications/Wireshark.app/Contents/MacOS/Wireshark /usr/local/bin/wireshark`
