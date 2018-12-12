apt-get clean
apt-get update

# commented out, we will do yhis later on multi step vm
# apt-get upgrade -y

# Update to the latest kernel
# commented out
# apt-get install -y linux-generic linux-image-generic linux-server

# Hide Ubuntu splash screen during OS Boot, so you can see if the boot hangs
apt-get remove -y plymouth-theme-ubuntu-text
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT=""/' /etc/default/grub
update-grub

# Add no-password sudo config for vagrant user
echo "%vagrant ALL=NOPASSWD:ALL" > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# Add vagrant to sudo group
usermod -a -G sudo vagrant

# Install vagrant key
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# Install NFS for Vagrant
apt-get install -y nfs-common
# Without libdbus virtualbox would not start automatically after compile
apt-get -y install --no-install-recommends libdbus-1-3

# Install Linux headers and compiler toolchain
apt-get -y install build-essential linux-headers-$(uname -r)

# The netboot installs the VirtualBox support (old) so we have to remove it
service virtualbox-ose-guest-utils stop
rmmod vboxguest
apt-get purge -y virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms virtualbox-ose-guest-utils
apt-get install -y dkms

# Install the VirtualBox guest additions
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
VBOX_ISO=/home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop $VBOX_ISO /mnt
yes|sh /mnt/VBoxLinuxAdditions.run
umount /mnt

#Cleanup VirtualBox
rm $VBOX_ISO

apt-get autoremove -y
apt-get clean

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*

# Zero out the free space to save space in the final image:
echo "Zeroing device to make space..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Install x11-apps
apt-get update
apt-get install -y x11-apps

#Install vim and curl
apt-get install -y vim curl

# Install ruby + some ruby libraries
apt-get install -y ruby-full libtcltk-ruby zlib1g-dev liblzma-dev
gem install rails
gem update --system

# Install and setup python3.6 as default + idle
apt-get install -y software-properties-common
add-apt-repository -y ppa:jonathonf/python-3.6
apt-get update
apt-get install -y python3.6
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
echo -ne '\n' | update-alternatives --config python3
apt-get install -y idle-python3.6

# Install all needed for Kitchen tool
apt-get install -y rbenv ruby-dev ruby-bundler
grep -i rbenv /home/vagrant/.bash_profile &>/dev/null || {
  touch /home/vagrant/.bash_profile
  chown vagrant.vagrant /home/vagrant/.bash_profile
  echo 'export eval "$(rbenv init -)"' | sudo tee -a /home/vagrant/.bash_profile
  echo 'true' | sudo tee -a /home/vagrant/.bash_profile
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' | sudo tee -a /home/vagrant/.bash_profile
}

