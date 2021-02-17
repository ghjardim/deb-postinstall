#!/bin/sh

echo ""
echo "------------------------------------"
echo " UPDATING YOUR APT CACHE..."
echo "------------------------------------"
sudo apt update

echo ""
echo "------------------------------------"
echo " INSTALLING THE PACKAGES..."
echo "------------------------------------"
cat packages.txt | grep -v "#" | xargs sudo apt install

echo ""
echo " All packages now installed."

echo ""
echo "------------------------------------"
echo " CLONING DOTFILES..."
echo "------------------------------------"
yadm clone "https://github.com/ghjardim/dotfiles"
cd

echo ""
echo "------------------------------------"
echo " GETTING FONTS..."
echo "------------------------------------"
echo " [i] These fonts does not have Debian packages associated."
echo ""
mkdir ~/.fonts/
mkdir /tmp/fonts/
cd /tmp/fonts/
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip"
unzip UbuntuMono.zip
mv "Ubuntu Mono Nerd Font Complete Mono.ttf" ~/.fonts/
cd

echo ""
echo "------------------------------------"
echo " INSTALLING OH-MY-ZSH..."
echo "------------------------------------"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd

echo ""
echo "------------------------------------"
echo " BUILDING ALACRITTY..."
echo "------------------------------------"
mkdir $HOME/Applications/
cd $HOME/Applications/
git clone https://github.com/alacritty/alacritty.git
cd alacritty
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
cargo build --release
mv ./target/release/alacritty ~/.local/bin/
cd

echo ""
echo "------------------------------------"
echo " BUILDING I3-GAPS..."
echo "------------------------------------"
cd $HOME/Applications/
git clone "https://github.com/maestrogerardo/i3-gaps-deb"
cd i3-gaps-deb
./i3-gaps-deb
