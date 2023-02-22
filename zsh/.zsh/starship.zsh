# find out which distribution we are running on
LFILE="/etc/os-release"
MFILE="/System/Library/CoreServices/SystemVersion.plist"


# LINUX ------------
if [[ -f $LFILE ]]; then
  _distro=$(awk '/^NAME=/' /etc/os-release | awk -F'=' '{ print tolower($2) }')

   #sorting out debian if it is true debian or raspbian debian
  if [[ $_distro == *debian* ]]; then
    VERSION_CODENAME=$(awk -F'=' '/VERSION_CODENAME/ {print $2}' /etc/os-release)
    if [[ $VERSION_CODENAME == bullseye ]]; then
      _distro="raspbian"
    else
      _distro="debian"
    fi
  fi

  # on linux use systemd to determine if we are in a virtual environment or not
  _device=$(systemd-detect-virt)
  case $_device in
    *none*)        DEVICE="";;
    *)             DEVICE="";;
  esac

#MacOS --------------
elif [[ -f $MFILE ]]; then
  _distro="macos"

  # on mac os use the systemprofiler to determine the current model
  _device=$(system_profiler SPHardwareDataType | awk '/Model Name/ {print $3,$4,$5,$6,$7}')

  case $_device in
    *MacBook*)     DEVICE="";;
    *)             DEVICE="󰧨";;
  esac
fi


# set an icon based on the distro
# make sure your font is compatible with https://github.com/lukas-w/font-logos
case $_distro in
    *kali*)                  ICON="ﴣ";;
    *arch*)                  ICON="";;
    *debian*)                ICON="";;
    *raspbian*)              ICON="";;
    *ubuntu*)                ICON="";;
    *elementary*)            ICON="";;
    *fedora*)                ICON="";;
    *coreos*)                ICON="";;
    *gentoo*)                ICON="";;
    *mageia*)                ICON="";;
    *centos*)                ICON="";;
    *opensuse*|*tumbleweed*) ICON="";;
    *sabayon*)               ICON="";;
    *slackware*)             ICON="";;
    *linuxmint*)             ICON="";;
    *alpine*)                ICON="";;
    *aosc*)                  ICON="";;
    *nixos*)                 ICON="";;
    *devuan*)                ICON="";;
    *manjaro*)               ICON="";;
    *rhel*)                  ICON="";;
    *macos*)                 ICON="";;
    *)                       ICON="";;
esac

export STARSHIP_DISTRO="$ICON"
export STARSHIP_DEVICE="$DEVICE"
