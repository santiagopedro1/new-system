# list of packages to install
pacman_pkgs = (
    gtk4,
    hyprland,
    xdg-desktop-portal-hyprland,
    waybar,
    firefox,
    brightnessctl,
    network-manager-applet,
    kitty,
    zsh,
    thunar,
    wofi,
    lxappearance
)

yay_pkgs = (
    wlogout,
    visual-studio-code-bin,
    dracula-gtk-theme
)

# install packages
sudo pacman -Sy ${pkgs[@]}

# install yay
sudo pacman -S --needed git base-devel
sudo mkdir /opt/yay
sudo git clone https://aur.archlinux.org/yay.git /opt/yay
chown -R $USER:$USER /opt/yay
makepkg -si /opt/yay

# install yay packages
yay -Sy ${yay_pkgs[@]}

# disable wifi power saving
# add "[connection]\nwifi.powersave = 2" to /etc/NetworkManager/conf.d/wifi-powersave.conf
sudo touch /etc/NetworkManager/conf.d/wifi-powersave.conf
sudo echo "[connection]\nwifi.powersave = 2" >> /etc/NetworkManager/conf.d/wifi-powersave.conf

sudo systemctl restart NetworkManager

# copy config files
cp -r .config/* ~/.config/