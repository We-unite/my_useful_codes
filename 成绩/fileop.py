import os


def FileChange(filename):
    os.system('pandoc -s '+filename+'.md -o '+filename+'.pdf --pdf-engine=xelatex -V CJKmainfont="Microsoft YaHei" -M geometry:"top=0.5in, inner=4ex,outer=4ex,bottom=0.5in, headheight=3ex, headsep=2ex"')
    os.remove(filename+".md")
    print("文件转换成功！")
