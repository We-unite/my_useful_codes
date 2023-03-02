import requests
import re
from fileop import *
from myheaders import *
from mytime import *

url = "http://jwts.hit.edu.cn/xfj/queryListXfj"

# 数据爬取
result = requests.get(url=url, headers=headers).text
# 给定学分绩数据
given_average = re.search('id="pjxfj">(.*?)</span>', result).group(1)
# print(given_average)
given_rank = re.search('id="zrs">(.*?)</span>', result).group(1)
given_exam_class_scores = re.search(
    'id="kskxfj">(.*?)</span>', result).group(1)
given_exam_scores = re.search('id="kskxfs">(.*?)</span>', result).group(1)
given_look_failed_scores = re.search(
    'id="kckxfj">(.*?)</span>', result).group(1)
given_semes = re.search('id="xqs">(.*?)</span>', result).group(1)
print("数据提取成功！")

# 提取数据
# 课程信息列表
title = re.findall('>(.*?)</th>', result)
# 课程信息
courses = re.findall('>(.*?)</td>', result)
del courses[0:2]  # 删除冗余信息
# 写入文件
with open("res/gpa.md", "w", encoding="utf-8") as file:
    # 写入标题
    file.write("# GPA\n\n")
    file.write("**以下所有数据截至"+get_time()+"**\n\n")
    # 写入给定数据
    file.write("## 给定数据\n\n")
    file.write("本校学分绩："+given_average+"\n\n")
    file.write("排名："+given_rank+"\n\n")
    file.write("考试课程学分绩："+given_exam_class_scores+"\n\n")
    file.write("考试课程学分数："+given_exam_scores+"\n\n")
    file.write("考查重修课程学分绩："+given_look_failed_scores+"\n\n")
    file.write("计算学期数："+given_semes+"\n\n")
    # 写入课程信息
    file.write("## 课程信息\n\n")
    file.write("|")
    for i in range(0, len(title)):
        file.write(title[i]+"|")
    file.write("\n")
    file.write("|")
    for i in range(0, len(title)):
        file.write("----|")
    file.write("\n")
    for i in range(0, len(courses), len(title)):
        file.write("|")
        for j in range(0, len(title)):
            file.write(courses[i+j]+"|")
        file.write("\n")

    # 学分绩计算
    # 加权学分绩
    scores = Class = class_score = 0
    for i in range(0, len(courses), len(title)):
        scores += float(courses[i+7])  # 总学分计算
        class_score += float(courses[i+8])*float(courses[i+7])  # 总绩点计算
        Class += float(courses[i+8])  # 总分数计算
    file.write("截至")
    get_time()
    file.write("总学分：%.4f\n\n" % scores)
    file.write("总绩点：%.4f\n\n" % class_score)
    file.write("总分数：%.4f\n\n" % Class)
    file.write("加权学分绩：%.4f\n\n" % (class_score/scores))
    file.write("平均分：%.4f\n\n" % (Class/len(courses)*len(title)))
print("写入文件成功！")

# 转换为pdf并删除源文件
FileChange("res/gpa")
