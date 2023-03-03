@echo off&setlocal enabledelayedexpansion

cd C:\\Users\\勤倦阁主\\AppData\\Roaming\\Code\\User

@REM 读取ipconfig输出到ip.txt
ipconfig > ip.txt

@REM 根据ipv4提取信息到get_ip.txt
findstr /i "IPv4" ip.txt >get_ip.txt

@REM 获取文件的最后一行
set filePath=get_ip.txt
for /f "delims=" %%i in (%filePath%) do (
	set lastline=%%~i
)

@REM 截取最后一行第39位到最后（从0计数）
set str=%lastline:~39,100%

@REM 输出到剪贴板
set/p="%str%"<nul | clip

@REM 更改vscode配置文件
set json_path=settings.json
@REM 读取settings.json文件中的liveServer.settings.host到tmp.txt
findstr /c:"liveServer.settings.host" %json_path% > tmp.txt
for /f "delims=" %%i in (tmp.txt) do (
	set lastline=%%~i
)
set last_ip=%lastline:~32,100%

@REM 替换内容
set new_ip="%str%",

@REM 更改文件
for /f "delims=" %%i in (%json_path%) do (
	rem 设置变量a为每行内容
	set a=%%~i
	rem 如果该行有123，则将其改为456
	set "a=!a:%last_ip%=%new_ip%!"
	rem 把修改后的全部行存入$
	echo !a!>>$
)

@REM 替换
move $ settings.json

@REM 删除辅助文件
del ip.txt get_ip.txt tmp.txt

@REM 暂停
timeout /t 3