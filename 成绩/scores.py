import requests
import re
from fileop import *
from myheaders import *

url = "http://jwts.hit.edu.cn/cjcx/queryQmcj"

# 载荷合成
time = input("学年学期（秋季1春季2）")
data = "pageXnxq="+time+"&pageBkcxbj=&pageSfjg=&pageKcmc="
data = data.encode("utf-8")

# 爬取
res = requests.post(url=url, headers=headers,
                    data=data).text

# 找到课程信息列表
result = re.findall('div class="list">([\s\S]+)</div>', res)
result = result[0]

# 找到表单标题栏
title = re.findall('>(.*?)</th>', result)
title = title[0:14]

# 找到课程信息（杂乱）
courses = re.findall('<tr>([\s\S]+)</tr>', result)

# 找到各部分对应内容
data = re.findall('<td>(.*?)</td>', courses[0])
info = []
i = 0
while i < len(data)/14:
    info.append(data[i*14:i*14+14])
    i += 1

i = 0
while i < len(info):
    info[i][4] = re.search('>(.*?)</a>', info[i][4]).group(1)
    i += 1

# 爬取成功
print("数据爬取成功！")

# 写入文件
file_name = input("文件名（不需要后缀）")
file_name = "res/"+file_name
with open(file_name+".md", "w", encoding="utf-8") as f:
    # 标题
    if (time[len(time)-1] == "1"):
        semister = time[0:4]+"秋季学期"
    else:
        semister = time[5:9]+"春季学期"
    f.write("# "+semister+"成绩单\n\n")
    # 表头部分
    i = 0
    while i < len(title):
        f.write("|"+title[i])
        i += 1
    f.write("|\n")

    # 表格分割线
    i = 0
    while i < len(title):
        f.write("|---")
        i += 1
    f.write("|\n")

    # 表格内容
    i = 0
    while i < len(info):
        j = 0
        while j < len(info[i]):
            f.write("|"+info[i][j])
            j += 1
        f.write("|\n")
        i += 1

    # 本学期学分绩计算
    # 加权学分绩
    i = score = 0
    while i < len(info):
        score += float(info[i][7])
        i += 1
    f.write("\n总学分：\r%.4f\n\n" % (score))
    i = class_score = 0
    while i < len(info):
        class_score += float(info[i][7])*float(info[i][11])
        i += 1
    f.write("总绩点：\r%.4f\n\n" % (class_score))

    # 平均学分绩
    i = Class = 0
    while i < len(info):
        Class += float(info[i][11])
        i += 1
    f.write("加权学分绩：%.4f\n\n" % (class_score/score))
    f.write("平均学分绩：%.4f\n" % (Class/len(info)))
print("文件写入成功！")

# 转换为pdf并删除源文件
FileChange(file_name)
