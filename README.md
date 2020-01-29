# JPL Terraform 

> Deploy a complete infrastructure in a single command

It is a Terraform project, made by ESGI students. It allows you to deploy a complete infrastructure in a single command.
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

## Usage

It is necessary to make a GET or POST request on the serverless function, this request must have the following scheme:

```json
{
  "current_percentage": int (0 - 100)
}
```

The serverless function will calculate the time remaining for the full charge of a device. 

API and front communicate over Websocket you don't need reload the page after trigger the serveless function.