# dal

## Install

Start with [Fedora 40 KDE](https://spins.fedoraproject.org/en/kde)

```bash
# Disable mitigations
sudo grubby --update-kernel=ALL --args="mitigations=off"

# Disable swap
sudo dnf erase -y zram-generator-defaults

# Other
sudo dnf swap -y nano-default-editor vim-default-editor
sudo dnf install -y --setopt=install_weak_deps=False btop neovim

# NVIDIA
sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf update -y
sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda

# Flatpak
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user -y flathub \
    com.google.Chrome \
    org.blender.Blender \
    org.kde.krita

sed \
    -e "s/chrome com.google.Chrome/chrome com.google.Chrome --password-store=basic --ozone-platform=wayland --enable-features=UseOzonePlatform --enable-wayland-ime/g" \
    -e "s/forwarding com.google.Chrome/forwarding com.google.Chrome --password-store=basic --ozone-platform=wayland --enable-features=UseOzonePlatform --enable-wayland-ime/g" \
    -i ~/.local/share/flatpak/exports/share/applications/com.google.Chrome.desktop
```

## fcitx

```bash
sudo dnf install -y fcitx5-hangul kcm-fcitx5
im-chooser
# Select "Use fcitx5" and logout

# For KDE
# "System Settings" > "Input Method":
# * "Add Input Method" > Hangul
# * "Configure global options" > "Ctrl+Space" changes layout
# "System Settings" > "Virtual keyboard" > Select "Fcitx 5"

# For Cinnamon
# sudo dnf install -y fcitx5-configtool
```

## Scanner

```bash
# Go to http://download.ebz.epson.net/dsc/search/01/search/searchModule
# Seach for `v39`
# Package Download Page
tar xf epson*
cd epson*
./install.sh

# Test
sudo scanimage -L

sudo dnf install skanlite

# Convert multiple png to pdf
convert *.png new.pdf
```
