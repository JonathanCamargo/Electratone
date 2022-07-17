# Install Raspotify
#sudo apt-get -y install curl && curl -sL https://dtcooper.github.io/raspotify/install.sh | sh
# It may not work on PI?

# Better option is SpotifyD

# Run the install.sh script from where it lives
curDir=`pwd`

cd $HOME/apps

wget https://github.com/Spotifyd/spotifyd/releases/download/v0.3.3/spotifyd-linux-armhf-full.tar.gz
tar -xvf spotifyd-linux-armhf-full.tar.gz
rm spotifyd-linux-armhf-full.tar.gz

wget https://raw.githubusercontent.com/Spotifyd/spotifyd/master/contrib/spotifyd.service -O spotifyd.service
sed -i 's?/usr/bin/spotifyd?'`pwd`'\/spotifyd?' spotifyd.service 


# Set up service
sudo mv spotifyd.service /etc/systemd/user/spotifyd.service
# Run as user
mkdir -p ~/.config/systemd/user/
nano ~/.config/systemd/user/spotifyd.service
systemctl --user daemon-reload

# Create a config file
mkdir ~/.config/spotifyd/
cp  $(curDir)/.spotifyd.conf ~/.config/spotifyd/spotifyd.conf
echo "Please set the user and pass in $curDir/.spotifyd.conf"

# Start the service at boot
sudo loginctl enable-linger ossip
systemctl --user enable spotifyd.service
