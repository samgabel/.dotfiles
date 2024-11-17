# Hi, there! 👋

These are my personal dotfiles used for MacOS


![MacOS Setup](https://github.com/samgabel/.dotfiles/blob/main/MacOS-Config-IMG.png?raw=true)


## Installation Instructions

1) **Clone** this git repository to your home directory and then run
either script in `~/.dotfiles/install`

2) Make sure **iTerm2** was successfully installed and open it;
open preferences and under General -> Preferences and change the path to `~/.dotfiles/configs/iterm2`




## MacOS System Settings


#### Permissions
- **Privacy & Security > App Management**
    - iTerm {x}


#### Display Settings
- **Displays > More Space**


#### Desktop & Dock
- **Minimize windows using**: Scale Effect
- **Automatically hide and show the Dock**: {x}
- **Mission Control**:
  - Automatically rearrange Spaces based on most recent use: { }


#### Accessibility
- **Display**:
  - **Color Filters**:
    - Filter type: "Color Tint"
    - Color: "Orange"
- **Captions**:
  - **Outline Text**: { }


#### Keyboard Settings
- **Key Repeat Rate**: Max
- **Delay Until Repeat**: Max - 1
- **Text Input**: Edit...
  - **Correct Spelling**: { }
  - **Capitalize Words**: { }
  - **Use Smart Quotes and Dashes**: { }
  - **Change single and double quotes to standard**: "" and ''
- **Keyboard Shortcuts**:
  - **Modifier Keys**: (Caps Lock -> ESC)
  - **Mission Control**:
    - Move left
    - Move right
    - Switch to 1
    - Switch to 2
    - Switch to 3




## Self Notes

- [Brewfile](https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f):
    ```sh
    # Installing Brewfile
    brew bundle --file=~/.dotfiles/install/extras/Brewfile

    # Creating/Updating Brewfile
    brew bundle dump --file=~/.dotfiles/install/extras/Brewfile

    # Cleaning up system to match Brewfile
    brew bundle cleanup --file=~/.dotfiles/install/extras/Brewfile
    ```
