# JPL Terraform 

> Deploy a complete infrastructure in a single command

C'est un projet Terraform, fait par des étudiants de l'ESGI. Il permets de déployer une infrastructure complète en une seule commande. 

![Structure API](https://zupimages.net/up/20/03/lb2k.png)

## install

#### linux installation

The script will clone the project and install automatically terraform executable for linux 
```
curl -s https://raw.githubusercontent.com/Shengael/terraform-implementation/master/install.sh?token=AJJM7LU4GW7OTQO6YJZYKXC6HL3WM | sh
cd terraform-implementation
```
#### manual installation
```
git clone https://github.com/Shengael/terraform-implementation.git
```
and add terraform executable at the project's root

## Run

**Complete the environment variable on the top of the script run.sh before run the command**

```
./run.sh
```