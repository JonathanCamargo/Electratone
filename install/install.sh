# Install Raspotify
#sudo apt-get -y install curl && curl -sL https://dtcooper.github.io/raspotify/install.sh | sh
# It may not work on PI?

# Better option is SpotifyD

# Run the install.sh script from where it lives
curDir=`pwd`

mkdir $HOME/apps
cd $HOME/apps

spotifyVersion="spotifyd-linux-armv6-slim.tar.gz"

wget https://github.com/Spotifyd/spotifyd/releases/download/v0.3.3/$spotifyVersion
tar -xvf $spotifyVersion
rm $spotifyVersion

wget https://raw.githubusercontent.com/Spotifyd/spotifyd/master/contrib/spotifyd.service -O spotifyd.service
sed -i 's?/usr/bin/spotifyd?'`pwd`'\/spotifyd?' spotifyd.service 

# Set up service
sudo mv spotifyd.service /etc/systemd/user/spotifyd.service
# Run as user
mkdir -p ~/.config/systemd/user/
touch ~/.config/systemd/user/spotifyd.service
systemctl --user daemon-reload

# Create a config file
mkdir -p ~/.config/spotifyd/
cp  $curDir/spotifyd.conf ~/.config/spotifyd/spotifyd.conf
echo "Please set the user and pass in $curDir/spotifyd.conf"
sleep 5
nano ~/.config/spotifyd/spotifyd.conf
# Start the service at boot
sudo loginctl enable-linger pi
systemctl --user enable spotifyd.service
