#!/bin/sh

echo ""
echo "------------------------------------"
echo " (1/9) UPDATING YOUR APT CACHE..."
echo "------------------------------------"
sudo apt update

echo ""
echo "------------------------------------"
echo " (2/9) INSTALLING THE PACKAGES..."
echo "------------------------------------"
cat packages.txt | grep -v "#" | xargs sudo apt install -y
sudo apt update
sudo update-command-not-found

echo ""
echo " All packages now installed."

echo ""
echo "------------------------------------"
echo " (3/9) CLONING DOTFILES..."
echo "------------------------------------"
yadm clone "https://github.com/ghjardim/dotfiles"
cd

echo ""
echo "------------------------------------"
echo " (4/9) GETTING FONTS..."
echo "------------------------------------"
echo " [i] These fonts does not have Debian packages associated."
echo ""
mkdir $HOME/.fonts/
mkdir /tmp/fonts/
cd /tmp/fonts/
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip"
unzip UbuntuMono.zip
mv "Ubuntu Mono Nerd Font Complete Mono.ttf" $HOME/.fonts/
cd

echo ""
echo "------------------------------------"
echo " (5/9) INSTALLING OH-MY-ZSH..."
echo "------------------------------------"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd

echo ""
echo "------------------------------------"
echo " (6/9) DOWNLOADING ALACRITTY..."
echo "------------------------------------"
mkdir $HOME/Applications/
cd $HOME/Applications/
git clone https://github.com/alacritty/alacritty.git
cd alacritty
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
cargo build --release
	# Error: cargo not found
mv ./target/release/alacritty ~/.local/bin/
cd

echo ""
echo "------------------------------------"
echo " (7/9) BUILDING I3-GAPS..."
echo "------------------------------------"
cd $HOME/Applications/
git clone "https://github.com/maestrogerardo/i3-gaps-deb"
cd i3-gaps-deb
./i3-gaps-deb
cd

echo ""
echo "------------------------------------"
echo " (8/9) BUILDING QUTEBROWSER..."
echo "------------------------------------"
echo " [i] This is for you to get latest, more secure version of Qutebrowser"
echo "     Only the latest version is compatible with my dotfiles."
sudo apt install -y --no-install-recommends git ca-certificates python3 python3-venv asciidoc libglib2.0-0 libgl1 libfontconfig1 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-shape0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libdbus-1-3 libyaml-dev gcc python3-dev libnss3
cd $HOME/Applications/
git clone "https://github.com/qutebrowser/qutebrowser.git"
cd qutebrowser
python3 scripts/mkvenv.py
# Failed building
cd

echo ""
echo "------------------------------------"
echo " (9/9) GETTING PFETCH..."
echo "------------------------------------"
cd $HOME/.local/bin
wget "https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch"
chmod +x pfetch
cd
