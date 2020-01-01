# Désactiver le touchpad quand on tape au clavier

[source](https://www.ostechnix.com/how-to-automatically-disable-touchpad-when-typing-in-ubuntu/)

* En CLI : `gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true` mais ça ne semble pas fonctionner parfaitement...
* En GUI : 
    1. `sudo add-apt-repository ppa:atareao/atareao`
    2. `sudo apt update`
    3. `sudo apt install touchpad-indicator`