#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main(int argc, char *argv[])
{
    string buf, file_name = argv[1];
    fstream read, write;
    int pos;
    read.open(file_name, ios::in);
    write.open("myheaders.py", ios::out);
    if (!read.is_open() || !write.is_open())
    {
        printf("Error: File open failed!");
        return 1;
    }

    write << "headers = {\n";
    while (getline(read, buf))
    {
        pos = buf.find(':', 1);
        write << "\t\'" << buf.substr(0, pos) << "\':\'" << buf.substr(pos + 2, buf.length() - pos - 2) << "\'," << endl;
    }
    write << "}\n";
    read.close();
    write.close();
    printf("Success!\n");
    return 0;
}
