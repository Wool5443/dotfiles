#!/usr/bin/env sh

sudo cp etcfiles/pacman.conf /etc
sudo cp etcfiles/makepkg.conf /etc

sudo pacman -S ccache

sudo pacman -S --needed git base-devel && git clone \
https://aur.archlinux.org/yay.git && cd yay && makepkg -si

yay -S alhp-mirrorlist alhp-keyring
yay

yay -S yes

yes '' | yay -S \
base-devel \
hyprland \
ags-hyprpanel-git \
android-file-transfer \
android-tools \
albert \
blueman-git \
dconf-editor \
fastfetch \
mpv \
flatpak \
gdb \
gedit \
geoclue \
git \
zsh \
git-zsh-completion \
zsh-completions \
github-cli \
gnu-free-fonts \
google-chrome \
gparted \
7zip \
gzip \
htop \
btop \
hyprcursor \
hyprlock \
hyprshot \
hyprsunset \
hyprpaper \
hyprpicker \
hyprcursor \
hyprgraphics \
hyprland \
hyprland-qt-support \
hyprland-qtutils \
hyprlang \
hyprlock \
hyprpaper \
hyprpicker \
hyprpolkitagent \
hyprshot \
hyprsunset \
hyprswitch \
hyprsysteminfo \
hyprutils \
hyprwayland-scanner \
kitty \
man-db \
man-pages \
matugen-bin \
thunar \
thunar-archive-plugin \
neovim \
noto-fonts \
noto-fonts-cjk \
noto-fonts-emoji \
noto-fonts-extra \
ntfs-3g \
nwg-look \
obsidian \
opentabletdriver \
pdfarranger \
polkit \
polkit-gnome \
polkit-qt6 \
posy-improved-cursors \
python \
qalculate-gtk \
qbittorrent \
ranger \
sddm \
sddm-astronaut-theme \
spicetify-cli \
spicetify-marketplace-bin \
spotify \
steam-native-runtime \
stow \
telegram-desktop-bin \
tesseract \
tesseract-data-afr \
tesseract-data-eng \
tesseract-data-osd \
tesseract-data-rus \
touchegg \
tree-sitter \
udiskie \
udisks2 \
unzip \
vesktop \
vim \
visual-studio-code-bin \
vscode-codicons-git \
wget \
xdg-desktop-portal \
xdg-desktop-portal-gtk \
xdg-desktop-portal-hyprland \
xdg-desktop-portal-wlr \
xdg-desktop-portal-xapp \
xournalpp \
zoxide \
zathura \
zathura-djvu \
zathura-pdf-mupdf \
zen-browser-bin \
ttf-anonymous-pro \
ttf-caladea \
ttf-courier-prime \
ttf-croscore \
ttf-dejavu \
ttf-fira-code \
ttf-fira-mono \
ttf-fira-sans \
ttf-gelasio \
ttf-gelasio-ib \
ttf-google-fonts-git \
ttf-impallari-cantora \
ttf-inconsolata \
ttf-jetbrains-mono \
ttf-jetbrains-mono-nerd \
ttf-lato \
ttf-liberation \
ttf-merriweather \
ttf-merriweather-sans \
ttf-nerd-fonts-symbols \
ttf-nerd-fonts-symbols-common \
ttf-noto-emoji-monochrome \
ttf-opensans \
ttf-oswald \
ttf-quintessential \
ttf-roboto \
ttf-roboto-mono \
ttf-signika \
ttf-ubuntu-font-family \
texlive-full \

sudo rmmod wacom hid_uclogic

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

cd ..
stow .

spicetify backup apply
