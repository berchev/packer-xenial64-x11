# packer-xenial64-x11

## Description:
Downloading the content of this repo, you will have all needed configuration files required to build a **packer-xenial64-x11** (Packer project which purpose is to build Vagrant box with graphical interface)


## Files:
- `http/preseed.cfg` - file containing base configuration during the installation process
- `scripts/provision.sh` - bash script which purpose is to configure the box environment
- `template.json` - file which **Packer** use in order to create our box

## Requiered software:
In order to build your box you need to have **Packer** tool installed.

Durring the building process you will need  **Virtualbox** tool installed.

In order to use the already created box you need **Vagrant** tool installed.

Please find Install section below in order to find out how to install **Virtualbox**, **Packer** and **Vagrant**.



## Install Section:
**Note that following instructions have been tested in Ubuntu**

### Instructions HOW to install `Virtualbox`
- Go to [Virtualbox downloads](https://www.virtualbox.org/wiki/Linux_Downloads) choose **Virtualbox** package

- Type in your terminal: `sudo apt-get install -y virtualbox `

### Instructions HOW to install `Packer`
- Download **Packer** from [here](https://www.packer.io/)
- Click on following link: [Install Packer](https://www.packer.io/intro/getting-started/install.html) 

### Instructions how to install `Vagrant`
- Download **Vagrant** from [here](https://www.vagrantup.com/downloads.html)
- Click on following link: [Installing vagrant](https://www.vagrantup.com/docs/installation/)

### Instructions HOW to build the **packer-xenial64-x11** box
- Make sure you have at least 2GB free space on your drive before start building of the box.
- Download the content of **berchev/packer-xenial64-x11** repository: `git clone https://github.com/berchev/packer-xenial64-x11.git`
- Change to downloaded **packer-xenial64-x11** directory: `cd packer-xenial64-x11`
- Run command: `packer build template.json` and wait the script to finish
- Once the script finish type: `ls` and you will see the newly generated file: **ubuntu-1604-vbox.box**

### Instructions HOW to use the already created **packer-xenial64-x11 box**

You have two options here:
- Option A - add and use the created box locally
- Option B - add created box to Vagrant cloud and then use it directly from the cloud.

Note that **Option B** have one serious advantage - you can access your box from everywhere! On everyone computer with access to Internet.

### Option A - Add and use nginx box locally
- On your terminal type: `vagrant box add --name <box_name> ubuntu-1604-vbox.box` , where `<box_name>` is the name which you pick for your box. For example: x11 (it is good approach to use lowercase letters in Linux)
- On your terminal type: `vagrant init x11`, where x11 is the name which we picked in step 1. 
It can be any other name!
`vagrant init x11` command will place to the current directory `Vagrantfile`.
- Type: `vagrant up` in order to power on your box
- Type: `vagrant ssh` and you will be connected to your box.
- Type: `exit ` in order to logout
- Type: `vagrant halt` in order to poweroff the box
- Type: `vagrant destroy` in order to destroy the created box

### Option B - Add and use nginx box from Vagrant cloud
- Create account in the [Vagrant cloud](https://app.vagrantup.com/)
- Click on **New Vagrant Box**
- Fill in **Name** field
- Fill in **Version** and **Description**
- Add **Provider** and click **continue to upload**
- Once completed **release version** and your box is ready for download
- Go to your personal computer terminal and type: `vagrant init -m <your_vagrant_cloud_user>/<name_of_your_box>`
- Type: `vagrant up` in order to power on your box
- Type: `vagrant ssh` and you will be connected to your box.
- Type: `exit ` in order to logout
- Type: `vagrant halt` in order to poweroff the box
- Type: `vagrant destroy` in order to destroy the created box

# TODO

