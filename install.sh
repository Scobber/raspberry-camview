#!/bin/sh
sudo rm /etc/init.d/camtopleft
sudo rm /etc/init.d/camtopright
sudo rm /etc/init.d/cambottomleft
sudo rm /etc/init.d/cambottomright
mkdir /usr/share/picam

sudo cp -R .* /usr/share/picam

sudo ln -s /usr/share/picam/init.d/camtopleft /etc/init.d/camtopleft
sudo ln -s /usr/share/picam/init.d/camtopright /etc/init.d/camtopright
sudo ln -s /usr/share/picam/init.d/cambottomleft /etc/init.d/cambottomleft
sudo ln -s /usr/share/picam/init.d/cambottomright /etc/init.d/cambottomright

chown pi:pi
chmod +x /usr/share/picam/*.sh

sudo update-rc.d camtopleft defaults
sudo update-rc.d camtopright defaults
sudo update-rc.d cambottomleft defaults
sudo update-rc.d cambottomright defaults
if [ -f "/etc/constellation/config.py" ]
then
	echo "Config File already Found."
else
	echo "Installing default config."
    cp /usr/share/picam/cams-default /etc/picam.settings
    nano /etc/picam.settings
fi
/usr/share/picam/upgrade.sh
