#!/bin/bash



echo ""
echo "------------------------------------"
echo " (1/8) UPDATING YOUR APT CACHE..."
echo "------------------------------------"
echo ""
read -n 1 -s -r -p $'Press enter to continue...\n' key; while [ "$key" != '' ]; do read -n 1 -s -r -p $'Wrong key! Press enter to continue...\n' key; done

sudo apt update



echo ""
echo "------------------------------------"
echo " (2/8) INSTALLING THE PACKAGES..."
echo "------------------------------------"
echo ""

read -n 1 -s -r -p $'Press enter to continue...\n' key; while [ "$key" != '' ]; do read -n 1 -s -r -p $'Wrong key! Press enter to continue...\n' key; done

cat packages.txt | grep -v "#" | xargs sudo apt install -y
sudo apt update
sudo update-command-not-found

echo ""
echo " All packages now installed."



echo ""
echo "------------------------------------"
echo " (3/8) CLONING DOTFILES..."
echo "------------------------------------"
echo ""

read -n 1 -s -r -p $'Press enter to continue...\n' key; while [ "$key" != '' ]; do read -n 1 -s -r -p $'Wrong key! Press enter to continue...\n' key; done

# TODO: fix cloning bugs (they do not merge)
# Perhaps the bugs have to do with .bashrc
yadm clone "https://github.com/ghjardim/dotfiles"
cd



echo ""
echo "------------------------------------"
echo " (4/8) GETTING FONTS..."
echo "------------------------------------"
echo " [i] These fonts does not have Debian packages associated."
echo ""

read -n 1 -s -r -p $'Press enter to continue...\n' key; while [ "$key" != '' ]; do read -n 1 -s -r -p $'Wrong key! Press enter to continue...\n' key; done

# TODO
# [ ] mkdir creates only if the folder does not exist

[ ! -d $HOME/.fonts/ ] && mkdir $HOME/.fonts/
[ ! -d /tmp/fonts/ ] && mkdir /tmp/fonts/
cd /tmp/fonts/
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip"
unzip UbuntuMono.zip
mv "Ubuntu Mono Nerd Font Complete Mono.ttf" $HOME/.fonts/
cd



echo ""
echo "------------------------------------"
echo " (5/8) DOWNLOADING AND COMPILING"
echo "       ALACRITTY..."
echo "------------------------------------"
echo ""

read -n 1 -s -r -p $'Press enter to continue...\n' key; while [ "$key" != '' ]; do read -n 1 -s -r -p $'Wrong key! Press enter to continue...\n' key; done

mkdir $HOME/Applications/
cd $HOME/Applications/
echo " >>> Cloning alacritty..."
git clone https://github.com/alacritty/alacritty.git
cd alacritty
echo " >>> Installing Rust compiler..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo " >>> Running source $HOME/.cargo/env ..."
source $HOME/.cargo/env
echo " >>> Installing other dependencies to compile..."
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
echo " >>> Building Alacritty..."
cargo build --release
	# Error: cargo not found
mv ./target/release/alacritty ~/.local/bin/
cd



echo ""
echo "------------------------------------"
echo " (6/8) BUILDING I3-GAPS..."
echo "------------------------------------"
echo " [!] In this step, stay prepared to hit [RETURN] when asked"
echo ""

read -n 1 -s -r -p $'Press enter to continue...\n' key; while [ "$key" != '' ]; do read -n 1 -s -r -p $'Wrong key! Press enter to continue...\n' key; done

cd $HOME/Applications/
echo " >>> Cloning into $HOME/Applications/i3-gaps-deb..."
git clone "https://github.com/maestrogerardo/i3-gaps-deb"
cd i3-gaps-deb
./i3-gaps-deb
cd




echo ""
echo "------------------------------------"
echo " (7/8) BUILDING QUTEBROWSER..."
echo "------------------------------------"
echo " [i] This is for you to get latest, more secure version of Qutebrowser"
echo "     Only the latest version is compatible with my dotfiles."
echo ""

read -n 1 -s -r -p $'Press enter to continue...\n' key; while [ "$key" != '' ]; do read -n 1 -s -r -p $'Wrong key! Press enter to continue...\n' key; done

sudo apt install -y --no-install-recommends git ca-certificates python3 python3-venv asciidoc libglib2.0-0 libgl1 libfontconfig1 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-shape0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libdbus-1-3 libyaml-dev gcc python3-dev libnss3
cd $HOME/Applications/
git clone "https://github.com/qutebrowser/qutebrowser.git"
cd qutebrowser
python3 scripts/mkvenv.py
# Failed building??
cd



echo ""
echo "------------------------------------"
echo " (8/8) INSTALLING OH-MY-ZSH..."
echo " ...And its components..."
echo "------------------------------------"
#echo " [i] IMPORTANT: EXIT ZSH when its installed!!!!"
echo ""

read -n 1 -s -r -p $'Press enter to continue...\n' key; while [ "$key" != '' ]; do read -n 1 -s -r -p $'Wrong key! Press enter to continue...\n' key; done

#echo " >>> REMEMBER TO EXIT ZSH!"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
cd
echo "\n >>> Getting pfetch..."
cd $HOME/.local/bin
wget "https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch"
chmod +x pfetch
cd
echo ""
echo "\n >>> Getting fast-highlight-syntax plugin..."
git clone https://github.com/zdharma/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
echo ""
echo "\n >>> Getting zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "\n >>> When ZSH launched, it said that pfetch wasn't found. It is a bug, and pfetch will run on next reboot."

echo ""
echo "------------------------------------"
echo " DONE! REBOOT YOUR SYSTEM NOW..."
echo "------------------------------------"
