# encoding:'UTF-8'

# 使用说明：
# 		请将本脚本放在与ShadowsocksR.exe同级目录下，并且可运行的主程序名字修改为ShadowsocksR.exe。
# 		通过本脚本可以自动获取http://goagentss.cc/（极光网）的免费账户并进行自动配置。

import requests
from bs4 import BeautifulSoup
import re
import json
import win32api
import time
# 关闭SS程序以便于修改配置后重新开启新设置
win32api.ShellExecute(0, 'open', 'taskkill', '/F /IM ShadowsocksR.exe','',0)
time.sleep(1.5)

# 定义浏览器访问数据
headers = {
	'Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
	'Accept-Encoding':'gzip, deflate, sdch',
	'Accept-Language':'zh-CN,zh;q=0.8',
	'Cache-Control':'max-age=0',
	'Connection':'keep-alive',
	'Host':'goagentss.cc',
	'Upgrade-Insecure-Requests':'1',
	'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'
}
url = 'http://goagentss.cc/'

# 定义函数获取服务器地址等数据
def get_data(f_html):
	data = []
	for num in range(0,4):
		f_html = f_html.next_sibling.next_sibling
		pattern = r'(?<=：)[^\r\n]*$'
		data.append( re.search(pattern,f_html.string).group(0))	
	return data

# 访问网站获取网站返回值
resp = requests.get(url,headers = headers)
html = BeautifulSoup(resp.text,'html.parser').select('.text > h5')

# 数据格式化为JSON可以接受的数据
xianlu_data = [ get_data(html[0]) , get_data(html[1]) ]
json_data = { "configs":[ {"server":0,'server_port':0,'password':0,'method':0} ,{"server":1,'server_port':1,'password':1,'method':1} ] }
json_data['configs'][0]['server']=xianlu_data[0][0]
json_data['configs'][0]['server_port']=xianlu_data[0][1]
json_data['configs'][0]['method']=xianlu_data[0][2]
json_data['configs'][0]['password']=xianlu_data[0][3]
json_data['configs'][1]['server']=xianlu_data[1][0]
json_data['configs'][1]['server_port']=xianlu_data[1][1]
json_data['configs'][1]['method']=xianlu_data[1][2]
json_data['configs'][1]['password']=xianlu_data[1][3]

# 将获取的数据写入gui-config.json
with open('gui-config.json', 'w') as f:
 json.dump(json_data, f)

# 打开ShadowsocksR.exe主程序
win32api.ShellExecute(0, 'open', 'ShadowsocksR.exe', '','',0)
