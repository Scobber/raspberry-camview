#!/bin/sh
echo "Removing previous services"
sudo rm /etc/init.d/camtopleft
sudo rm /etc/init.d/camtopright
sudo rm /etc/init.d/cambottomleft
sudo rm /etc/init.d/cambottomright
mkdir /usr/share/picam
echo "Copying new files"
sudo cp -R .* /usr/share/picam
echo "symlinking services"
sudo ln -s /usr/share/picam/init.d/camtopleft /etc/init.d/camtopleft
sudo ln -s /usr/share/picam/init.d/camtopright /etc/init.d/camtopright
sudo ln -s /usr/share/picam/init.d/cambottomleft /etc/init.d/cambottomleft
sudo ln -s /usr/share/picam/init.d/cambottomright /etc/init.d/cambottomright
echo "Changing Ownership"
chown pi:pi
chmod +x /usr/share/picam/*.sh
echo "Registering Services"
sudo update-rc.d camtopleft defaults
sudo update-rc.d camtopright defaults
sudo update-rc.d cambottomleft defaults
sudo update-rc.d cambottomright defaults
echo "Looking for Config File"
if [ -f "/etc/picam.settings" ]
then
	echo "Config File already Found."
else
	echo "Installing default config."
    cp /usr/share/picam/cams-default /etc/picam.settings
    nano /etc/picam.settings
fi
echo "Launching Upgrade Module"
/usr/share/picam/upgrade.sh
