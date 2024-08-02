#!/usr/bin/python3

import paramiko
import socket
import threading
import urllib.parse
import requests

max_bytes = 1000
Response = list()
Treshold = 90

def sendToTelegram(text):
    chatid = "-485942271"
    botid = "237261483:AAHcWKJLNXnkIWvKywaY_98OJMdqwlkeujd3lHOhLg"
    url = ("https://api.telegram.org/bot" + botid + "/sendMessage?&chat_id=" + chatid + "&text=" + text + "\n")
    url = urllib.parse.quote(url, safe=':/&?=')
    print(url)
    res = requests.get(url, headers = {'Content-Type': 'application/x-www-form-urlencoded'} )
    print(res)


def send_cmd(
    ip_host_port,
    username,
    command
):
    cl = paramiko.SSHClient()
    cl.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    print("connecting...")
    cl.connect(
        hostname=ip_host_port[0],
        port=ip_host_port[1],
        username=username,
    password="password"
        #look_for_keys=True,
        #allow_agent=True,
        #key_filename='/root/.ssh/id_rsa'
    )
    stdin, stdout, stderr = cl.exec_command(command)
    dl=stdout.read().decode("utf-8").split("\n")[:-1]
    for d in dl:
        Response.append(ip_host_port[0]+' '+ip_host_port[2]+' '+d)

if __name__ == "__main__":
    devices = [['10.10.10.153', 8100, 'hostname1'],
            ['10.10.10.155', 22, 'hostname2'],
            ["10.10.10.64", 22, "hostname3"]]


    command = "df -h | grep '^/dev/\|192\.168' | grep -v 'loop' | sed -r 's/ +/ /g' | tr -s '\n'"

    threads = list()

    for d in devices:
        x = threading.Thread(target=send_cmd, args=(d, "root", command))
        threads.append(x)
        x.start()

    for d in threads:
        d.join()

    print(Response)

    for r in Response:
        c = r.split(' ')
        if int(c[6][:-1]) >= Treshold:
            sendToTelegram(r)
            print(r, c[6][:-1])

