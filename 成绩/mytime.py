import time

def get_time():
    # 获取当前时间
    time_now = time.localtime()
    tuple_week = ("星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期天")

    # 返回字符串
    return "目前（"+time.strftime("%Y-%m-%d %H:%M:%S", time_now)+tuple_week[time_now[6]]+"）"