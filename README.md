# Insurgency Sandstorm Scripts

### Intro
This is a repository of scripts for insurgency sandstorm dedicated server, these scripts contain lots of Chinese characters(and we dont have enough time to rewrite these scripts to english, sorry), so the most part of README.md is written by Chinese.

Use the `Git Bash` if you want to execute these scripts on windows platform.

Note: These scripts written by personal temporarily and have bad implements, if you have any advice welcome to PULL REQUESTS.

### 简介
在这个git库中存放了一些我使用Insurgency Sandstorm Linux服务器中临时编写的一些bash脚本，用于实现各类服务器管理功能，现整理将其开源，希望能被有心人发现，并对社区产生一点小小的帮助

Windows中要使用这些脚本可以使用`Git Bash`执行这些脚本


注：这些脚本由于是个人使用的，所以各项脚本与提示的实现十分糟糕，如果有任何好的建议，非常欢迎您的PR


为了方便使用，下附脚本的使用介绍

### rcon && rcon.exe

[rcon-cli](https://github.com/gorcon/rcon-cli)中的rcon可执行文件，ELF文件用于Linux x64发行版，`.exe`文件用于windows x64平台

部分脚本依赖于rcon文件，请用户自行修改rcon的地址（最好将该文件加入环境变量，部分脚本依赖于直接调用rcon文件）

### StartServer.sh
使用`bash StartServer.sh`来启动服务器，在启动前，请确保你已经修改了脚本中端口号、玩家数、Token等信息

该脚本会自动读取相对路径`Insurgency/Insurgency/Config/Server/MapCycle.txt`中的地图信息，并从中选出一个地图来启动服务器

要注意的是，由于NWI部分场景存在别名，且必须使用别名才能正常启动服务，所以必须对场景别名进行替换（如Crossing对应别名Canyon，脚本中已经实现了该功能，请勿删除）

### addAdmin.sh
该脚本用于向服务器中添加管理员，请先将脚本中的路径改为一个或多个服务器的Admins.txt所在路径（一行一个路径）

`Usage: bash addAdmin.sh <SteamID>`

如：`bash addAdmin.sh 76561198787872653` 

### multiple_ban.sh
该脚本用于封禁服务器中的玩家，需要先填充multiple_ban.sh中的服务器信息，脚本参数为

`<服务器列表，如1,3,5> <玩家ID/名称> [封禁原因]`

`Usage: bash multiple_ban.sh 1,2,3 76561198787872653 侮辱性语言`

OR

`Usage: bash multiple_ban.sh 1-3 76561198787872653 侮辱性语言`

### select_player.sh

该脚本用于封禁服务器中的玩家，需要先填充select_player.sh中的服务器信息

`Usage: bash select_player.sh <server_index>`

OR

`Usage: bash select_player.sh 1`

### update_server.sh
该脚本用于更新服务端（虽然这游戏不怎么更新），该脚本会调用`steam/update.sh`，请确保`steam/`目录下存放了steamcmd.sh，并在`update.txt`中填写正确的更新游戏路径（否则就会在指定的游戏路径下下载游戏）

`Usage: bash update_server.sh`

### Config/Server && Saved/Config/LinuxServer
这两个目录下存放了服务器常用的配置文件

需要注意的是，Saved/Config/LinuxServer中存放的文件必须在服务器关闭时修改（服务器执行关闭动作时，会将服务器正在执行的规则写回文件，因此当服务器运行时修改这些配置文件将会被服务端关闭时覆盖）
