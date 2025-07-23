# Insurgency Sandstorm Scripts

### Intro
This is a very personal repository, the scripts contains lots of Chinese characters(and I dont have enough time to rewrite these scripts to english, sorry), so the most part of README.md is written by Chinese.

Use the `Git Bash` if you want to execute these scripts on windows platform.

Note: These scripts written by personal temporarily and have bad implements, if you have any advice welcome to PULL REQUESTS.

### 简介
在这个git库中存放了一些我使用Insurgency Sandstorm Linux服务器中临时编写的一些bash脚本，用于实现各类服务器管理功能，现整理将其开源，希望能被有心人发现，并对社区产生一点小小的帮助

Windows中要使用这些脚本可以使用`Git Bash`执行这些脚本


注：这些脚本由于是个人使用的，所以各项脚本与提示的实现十分糟糕，如果有任何好的建议，非常欢迎您的PR


为了方便使用，下附脚本的使用介绍

### rcon && rcon.exe

![rcon-cli](https://github.com/gorcon/rcon-cli)中的rcon可执行文件，ELF文件用于Linux x64发行版，`.exe`文件用于windows x64平台

部分脚本依赖于rcon文件，请用户自行修改rcon的地址（最好将该文件加入环境变量，部分脚本依赖于直接调用rcon文件）

### StartServer.sh
使用`bash StartServer.sh`来启动服务器，在启动前，请确保你已经修改了脚本中端口号、玩家数、Token等信息

该脚本会自动读取相对路径`Insurgency/Insurgency/Config/Server/MapCycle.txt`中的地图信息，并从中选出一个地图来启动服务器

要注意的是，由于NWI部分场景存在别名，且必须使用别名才能正常启动服务，所以必须对场景别名进行替换（如Crossing对应别名Canyon，脚本中已经实现了该功能，请勿删除）

### addAdmin.sh
该脚本用于向服务器中添加管理员，请先将脚本中的路径改为一个或多个服务器的Admins.txt所在路径（一行一个路径）
`Usage: bash addAdmin.sh <SteamID>`
如：`bash addAdmin.sh 76561198787872653` 

### 
