#include <iostream>
#include <string>
#include <fstream>
using namespace std;

int main()
{
    string buf, ip;
    fstream read, write, num;
    bool flag = false, test = false;
    int len;
    // 读取ip地址
    num.open("ip.txt", ios::in);
    while (getline(num, buf))
    {
        len = buf.length();
        if (len >= 10 && buf.substr(len - 5, 4) == "WLAN")
        {
            flag = true;
        }
        if (flag && len >= 30 && buf.substr(3, 4) == "IPv4")
        {
            test = true;
            break;
        }
    }
    if (flag && test)
    {
        ip = buf.substr(39, len - 39);
        cout << "ip: " << ip << endl;
    }
    else
    {
        cout << "Error: IPv4 read failed!" << endl;
        return -1;
    }
    // 更改ip地址
    read.open("settings.json", ios::in);
    write.open("new.txt", ios::out);
    if (!read.is_open() || !write.is_open())
    {
        cout << "open file failed" << endl;
        return -1;
    }
    while (getline(read, buf))
    {
        if (buf.length() >= 30 && buf.substr(5, 24) == "liveServer.settings.host")
        {
            buf = "    \"liveServer.settings.host\": \"" + ip + "\",";
        }
        write << buf << endl;
    }
    cout << "Success!" << endl;
    read.close();
    write.close();
    return 0;
}