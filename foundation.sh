#!/usr/bin/env bash
shopt -s extglob
shopt -s xpg_echo
set -o pipefail

### Init
INSTALL_ROOT="$(cd -- "$(dirname -- "$0")" && pwd)/infernal-noise-box"
VENDOR_ROOT="${INSTALL_ROOT}/src/vendor"

### Procedure Defs
apt_update() {
  apt update
}

apt_upgrade() {
  apt -y dist-upgrade
}

reboot_if_required() {
  if [ -f /var/run/reboot-required.pkgs ] || [ -f /var/run/reboot-required ]; then
    reboot
  fi
}

apt_install_base() {
  apt -y install apt-transport-https git ansible ufw debian-goodies curl whois
}

ufw_configure() {
  ufw default deny incoming
  ufw default allow outgoing
  ufw allow ssh
  ufw allow http
  ufw allow https
  ufw allow ftp
  ufw allow 8080
  ufw allow 8443
}

ufw_enable() {
  ufw enable
}

lynis_install() {
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C80E383C3DE9F082E01391A0366C67DE91CA5D5F
  sudo wget -O - https://packages.cisofy.com/keys/cisofy-software-public.key | sudo apt-key add -
  # If you are using languages other than English, comment the following line:
  echo 'Acquire::Languages "none";' | sudo tee /etc/apt/apt.conf.d/99disable-translations
  echo "deb https://packages.cisofy.com/community/lynis/deb/ stable main" | sudo tee /etc/apt/sources.list.d/cisofy-lynis.list
  sudo apt update
  cat <<EOF | sudo tee /etc/apt/preferences.d/lynis
Package: lynis
Pin: origin packages.cisofy.com
Pin-Priority: 600
EOF
  sudo apt -y install lynis
}

lynis_audit() {
  lynis audit system
}

git_fetch_base() {
  git clone https://github.com/lamadotcare/infernal-noise-box.git infernal-noise-box
  cd ${INSTALL_ROOT}
}

install_ruby() {
  gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  curl -sSL https://get.rvm.io | bash -s stable --rails
  /usr/local/rvm/bin/rvm --default use ruby-2.7
}

### Main
main() {
  apt_update
  apt_upgrade
  apt_install_base
  git_fetch_base

}

# exec only after all code has been received - keeps things from breaking if transfer fails part way.
main
