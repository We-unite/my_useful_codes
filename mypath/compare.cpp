#include <iostream>
#include <string>
#include <fstream>
using namespace std;

void different(int line)
{
    cout << "Error: They are different in line " << line << endl;
    system("rm -rf new.txt ip.txt");
}

int main(int argc, char *argv[])
{
    string s1, s2;
    fstream read, write;
    read.open(argv[1], ios::in);
    write.open(argv[2], ios::in);
    int line = 0;
    if (!read.is_open() || !write.is_open())
    {
        cout << "open file failed" << endl;
        return -1;
    }

    while (getline(read, s1))
    {
        line++;
        getline(write, s2);
        if (s1 != s2)
        {
            if (s1.length() < 30 || (s1.length() >= 30 && s1.substr(5, 24) == "liveServer.settings.host"))
            {
                continue;
            }
            read.close();
            write.close();
            different(line);
            return -1;
        }
    }
    line++;
    if (getline(write, s2))
    {
        read.close();
        write.close();
        different(line);
        return -1;
    }

    cout << "Congratulations! They are the same!" << endl;
    read.close();
    write.close();
    system("rm -rf ip.txt settings.json");
    system("mv new.txt settings.json");
    system("sleep 2");
    return 0;
}