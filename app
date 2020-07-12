import base64
import sys
import subprocess
import os


from flask import Flask
app = Flask(__name__)

def getVarFromFile(filename):
    import imp
    f = open(filename)
    global data
    data = imp.load_source('data', '', f)
    f.close()

def re_write(new):
    with open("file_a.py", 'r') as file:
        new_file = []
        for line in file:
            if "var1" in line:
                new_file.append(line.split("var1")[0] + "var1 = " + new + "")
            else:
                new_file.append(line)
        with open("file_a.py", 'w') as file:
            for line in new_file:
                file.writelines(line)
    file.close()


@app.route('/reqcert/<number>')
def hello_world2(number):
    getVarFromFile('file_a.py')
    temp = data.var1
    print("check -1"+str(temp))
    r = './'+str(temp)+'.ovpn'
    os.remove(r)
    temp = temp + 1
    re_write(str(temp))
    client = str(temp)
    print(temp)
    subprocess.check_call(['./scriptGenereCert2.sh', client, number])
    encoded = ""

    with open(client+".ovpn") as f:
        mystr = f.readlines()
        strcomp = ""
        for line in mystr:
            strcomp += line
        strcomp = bytes(strcomp, encoding='utf-8')
        encoded = base64.b64encode(strcomp)
        encodedStr = str(encoded,"utf-8")
        #print(encodedStr)
    return (encodedStr)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
