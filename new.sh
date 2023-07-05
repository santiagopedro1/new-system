# list of packages to install
pacman_pkgs=(
    hyprland
    xdg-desktop-portal-hyprland
    waybar
    firefox
    network-manager-applet
    kitty
    zsh
    thunar
    wofi
    gvfs
    github-cli
    feh
    gnome-keyring
)

yay_pkgs=(
    wlogout
    visual-studio-code-bin
    dracula-gtk-theme
    juliaup
    google-chrome
)

sudo pacman -Sy

# install packages
sudo pacman -S ${pacman_pkgs[@]}

# yay
# check if yay is installed
if ! command -v yay &> /dev/null
then
    # install yay
    cd /opt
    sudo git clone https://aur.archlinux.org/yay.git
    sudo chown -R $USER:$USER ./yay
    cd yay
    makepkg -si
fi
yay -Sy
# install yay packages
yay -S ${yay_pkgs[@]}

# copy config files
mkdir ~/.config
cp -r .config/* ~/.config/

# set zsh as default shell
chsh -s $(which zsh)

# set up nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# gh auth
gh auth login

# dracula icon theme
curl -LO https://github.com/dracula/gtk/files/5214870/Dracula.zip
sudo mv Dracula.zip /usr/share/icons
sudo unzip /usr/share/icons/Dracula.zip
sudo rm /usr/share/icons/Dracula.zip

# set themes
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula" 
gsettings set org.gnome.desktop.interface icon-theme "Dracula"

# gnome keyring
echo "auth optional pam_gnome_keyring.so" >> /etc/pam.d/login
echo "session optional pam_gnome_keyring.so auto_start" >> /etc/pam.d/login
