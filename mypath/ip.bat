@echo off

# 读取ipconfig输出到ip.txt
ipconfig > ip.txt

# 根据ipv4提取信息到get_ip.txt
findstr /i "IPv4" ip.txt >get_ip.txt

# 获取文件的最后一行
set filePath=get_ip.txt
for /f "delims=" %%i in (%filePath%) do (
	set lastLine=%%~i
)

# 截取最后一行第37位到最后（从0计数）
set str=%lastline:~37,100%

# 输出到剪贴板
set/p="%str%"<nul | clip

# 删除辅助文件
del ip.txt get_ip.txt

# pause