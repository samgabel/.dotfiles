### WIRESHARK
While installed with Brew it needs some manual intervention
- delete `/etc/pathds.d/Wireshark` to remove wireshark binary from system $PATH
- link wireshark binary to local binaries with `ln -s /Applications/Wireshark.app/Contents/MacOS/Wireshark /usr/local/bin/wireshark`
