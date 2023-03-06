# Hello!

我是哈工大21级CS的**耗材生**一个，这里是我的一些自用代码。

**如有需要，尽可自取；发现bug，欢迎联系。**

# mypath

`/mypath`里的内容是自写的一些代码程序，可以用做命令行命令。

> 本文中，命令行指Win的`cmd`、Linux的`Terminal`或者`Git Bash`。
> 
> 我比较喜欢后两者，美观。
>
> 有一些内容是只能用后两个运行的，如`ip.sh`及其配套程序。见谅。

**注意：**在获取代码之后（最好是放在同一文件夹下，方便对自己添加的命令进行管理和修改），先要把所属文件夹加入系统路径/用户路径，然后编译代码，才能在任意位置使用。改的时候，改完代码，编译，即可。

## header

程序[header.cpp](/mypath/header.cpp)用来给python的爬虫程序写请求头headers。用法如下：

- 在某个文件（以1.txt为例）中，把要爬取的信息的请求头复制下来，贴进去并保存。
- 在命令行中执行<kbd>header 1.txt</kbd>，可以看到当前文件夹下多了个`myheaders.py`。
- 在爬虫程序中，写入<kbd>from myheaders import *</kbd>，即把请求头导入，变量名为`headers`。直接使用即可。

## ip

已知，局域网可以用来部署临时服务器（对，服务器就是自己的电脑），方法如下：

### Live Server

首先，我们需要一个[VSCode](https://code.visualstudio.com/)（笑）。

在扩展中，搜索`Live Server`，安装本插件。安装完成后，可以看到右下角出现了一个信号塔一样的图标`Go Live`。

### 获取ip

在命令行中运行<kbd>ipconfig</kbd>，找到“无线局域网适配器WLAN”下写的“IPv4地址”，把后边的ip复制下来。

在VSCode中打开设置，搜索"Live Server:Settings:Host"，在找到的ip地址栏里把复制的内容贴上去。关闭设置。

在当前目录下写一个index.html。过程略。

此时，点击右下角`Go Live`，成功后就会在默认浏览器中打开当前目录的index.html。在本局域网（比如窝工全校范围）内，使用此网址均可访问（别的机子手机也可以哦）。而且VSCode右下角显示为`Port`。点击之，就会关闭Live Server，服务器停止，无法继续访问。

方法很好，有几个缺点：
- 每当关闭Live Server，或者关闭VSCode、断网、电脑关机，就相当于连不上服务器，无法访问。这是系统性缺陷。
- 每次系统断网或关机（关机不也是断网吗），ip就会改变，再次打开需要重新手动操作好久。这个可以解决。

### WTF does the ip.sh do?

所以[ip.sh](/mypath/ip.sh)是干什么的？就是用来代替手动操作的。ip.cpp和compare.cpp是其辅助。

对于VSCode而言，绝大多数系统设置都写在安装目录下的`settings.json`中。找不到安装目录的话，在开始菜单找到VSCode，右键，打开文件所在位置，此时打开的是开始菜单所属的文件夹。然后再次找到它的快捷方式，右键，打开文件所在位置，就来到了安装目录。找一找，就看到了。

打开，会发现里边有一行正是在记录ip（如果没有，证明没有手动处理过，按照上边说的，手动处理一次）。

让我们回到`ip.sh`。使用之前，先要把第一行打开的路径修改为自己的默认settings.json所在地址（所有`\`改双斜杠`\\`）。在`ip.sh`所在文件夹双击执行之。（或者当前目录下右键git bash执行<kbd>bash ip.sh</kbd>。没有就下一个git。都是老程序猿了，git还是要用的。）

工作原理如下：
- ip.sh在进入settings.json文件夹后，执行了`ipconfig > ip.txt`命令，把ipconfg的输出写在了`ip.txt`中。
- ip.exe从`ip.txt`读出所需ip地址，把旧有的`settings.json`内容全部读取写入`new.txt`，并在此过程中识别出原有的ip地址（所以必须手动操作过一遍，保证里边有这个内容），更新为新的ip。
- conpare_ip_vsc.exe将原有`settings.json`与新建的`new.txt`进行比对。
  - 结果相同（除了ip之外），输出信息来说明比对正确，则删除settings.json和ip.txt，而后把new.txt重命名为settings.json，反正VSCode也看不出来被掉包了，是吧~
  - 结果不同，证明出了某些bug，输出报错，删除ip.txt和new.txt，保留旧的settings.json，保证安全。
- 在不同步骤之间加了2s停顿，方便人眼看到每一步的结果。

## 关于json.bat

[json.bat](/mypath/json.bat)是用来替代上述更改VSCode的方案的，因为`exe`实在是太大了。

在首次运行`json.bat`之前，首先需要运行`cmd默认编码改utf8.reg`这个注册表文件，其作用为将Windows10的CMD默认编码从`ANSI`即本地编码改为`utf-8`编码，因为VSCode默认文件编码utf-8，如不更改将会导致中文注释乱码。注册表文件运行一次即可，后续不再需要。

更改ip，需要将`json.bat`中第三行的路径改为自己`settings.json`所在路径，并也要求之前手动配置过一次以保证文件中有对应信息。改好后，每次需要更改，双击运行该批处理文件即可。

## settings.json

本文件为本人目前的配置，主要是知乎找到的[Tex Live]()+VSCode的配置，以及关于默认终端（设置为Git Bash）、IP等的设置信息。放在这里，权为备份，万一哪天我上边的IP配置程序就出Bug了呢。

# 成绩？Python？

## 简介

顾名思义，这是一个利用Python爬虫获取窝工教务系统上自己成绩的东西。
- `scores.py`用来获取分学期的学生成绩和GPA计算（所有课都囊括在内，包括考查和选修）
- `gpa.py`获取“学分绩查询”中的内容，包括网站上输出的学校计算的学分绩、当前排名等信息，以及所有课的列表信息，并据此计算截至目前的总GPA（也是所有课在内）
- `fileop.py`提供文件处理操作，`myheaders`提供请求头，`mytime.py`提供当前时间（看总gpa总是需要时效，不是么）

爬虫代码就不说了，说说用法。

## 用法

前期准备：

- 我们需要一个[Pandoc](https://pandoc.org/)。下载完成后，把`pandoc.exe`所在文件夹加入系统路径。

- 我们又需要一个[Tex Live](https://www.tug.org/texlive/)。

这都是大学生必备工具，一个拿来转换文件格式还极度美观，一个拿来写论文尤其是毕业论文，不会还有人没有吧？不会吧不会吧？

爬取期末成绩时：
- 打开窝工教务处的期末成绩查询，按下<kbd>F12</kbd>，在出现的右侧栏的上边一栏中点击“网络”。在网页中随便查一下哪个学期成绩，在右侧找到html文件，单击，在出现的栏目中，把请求头内容全部复制下来。
- 打开`scores.py`所在文件夹，新建一个文件（如2.txt），请求头贴进去，保存退出。
- 打开命令行，执行<kbd>header 2.txt</kbd>（现在知道为啥要把mypath加系统路径了吧）。Python所需请求头就写好了，在`myheaders.py`中。不用管。
- 继续，执行`python scores.py`，按照提示输入即可。
  - 输入“学年学期”时，学年写完整，秋季学期1春季学期2。比如21秋就写<kbd>2021-20221</kbd>，23春（似乎还没有哈）就写<kbd>2022-20232</kbd>，以此类推。
  - 输入文件名，不需要后缀名。如：想输出为`22春.pdf`，写`22春`即可。
  - 耐心等待，直到成功。

爬取学分绩也是一样，只不过找请求头的位置变成了“学分绩查询”，执行的变成了`python gpa.py`。如是而已。

另外，如果出现F12的“网络”里什么都没有或者没出现html的话，直接在左边网页的右上角刷新一下网页。

所有的输出内容都在`res`文件夹中，而且**此文件夹即使为空也必须存在**，不可删除，否则运行时会报错。如果误删，新建一个叫`res`的文件夹便是。

# 珍藏脚本

有时候总是需要一些奇奇怪怪的东西，比如：
- VSCode已经安装却忘了勾选“添加右键菜单”
- 需要在文件夹任意位置右键在当前位置打开CMD而不是去地址栏鼠标+键盘打开
- 将CMD命令的输出导入到文件却总是出现中文乱码……

就是**智障的我的这些智障需求**，促生了这个文件夹。里边有的是从网上好半天找到的注册表文件，有的是自己根据需求尝试去写（测试了，十分的**氨荃苛铐**，请放心使用），存在这里。

无论是身边人还是隔着网线的你们，总会有人需要的。

# VIM

vim感觉用着还不错，墙裂推荐。

- Linux自带vim，配置文件为`~/.vimrc`
- Win下可以用Git Bash自带的vim，配置文件`~/_vimrc`
- Win的cmd没有命令行编辑器，我使用的是neovim，配置文件目录`~/AppData/Local/nvim`，配置文件名`init.vim`
- VSCode有官方vim插件，配置文件与其他配置文件语法不同，是VSCode自己的settings,json及其语法，目录为`~/AppData/Roaming/Code/Use`，不能用此配置文件，需要什么得自己现场查。

以上四种，前三种配置文件可以通用，语法完全相同，第四种需要现场查，就不说了。

我的[配置文件备份](.vimrc)在此，省的回头丢了。

对了，本文件直接放入Linux会报错，是由于Win与Linux对于换行符的规定不同。放入对应目录并改好名字后需要先打开，会报错，回车继续，看到文件后，在normal模式下执行`:set fileformat=unix`，保存退出即可。

# 其他

本人为需求催动，一戳一蹦跶。故**此仓库不定时更新，欢迎Star**。

本人QQ：3205135446

如果各位有什么好点子或建议，可不能独吞，来和我battle呀，一起学习。
