# =============================================================================
#    FileName: rgb.py
#        Desc:
#      Author: Marslo
#       Email: marslo.jiao@gmail.com
#
#     Created: 2013-12-30 19:40:24
#     Version: 0.0.1
#  LastChange: 2013-12-30 19:40:48
#     History:
#              0.0.1 | Marslo | init
# =============================================================================

def gethex(colorlist):
  colorstr = ''
  for i, v in enumerate(colorlist):
    if v.isdigit():
      colorstr = colorstr + str(twoDigit(int(v)))
    else:
      print 'change to gethex false!'
  return "#" + colorstr

def twoDigit(x):
  if len(hex(x)) < 4:
    return '0' + str(hex(x).split('0x')[-1])
  elif len(hex(x)) == 4:
    return str(hex(x).split('0x')[-1])

def getPrettyDic(d):
  strs = ''
  itemlen = 0
  dicitem = []
  for i, v in d.items():
    if 0 == itemlen:
      itemlen = len(i)
    else:
      if len(i) > itemlen:
        itemlen = len(i)
        print i
    dicitem.append(i)

  dicitem.sort()
  for i in dicitem:
    strs = strs + (r"\'" + i.lower() +  r"':" + ' '*(itemlen - len(i)) + "'" + d[i]['new'] + "',") + '\n'
  return strs

def writeDic(mystr):
  myfile = open(r'myrgb.txt', 'w')
  myfile.write(mystr)
  myfile.close

if __name__ == '__main__':
  line = []
  dic = {}

  line = open(r'rgb.txt').readlines()
  for i, v in enumerate(line):
    dic[v.split('\t\t')[-1].strip()] = {}
    dic[v.split('\t\t')[-1].strip()]['orig'] = v.split('\t\t')[0]
    dic[v.split('\t\t')[-1].strip()]['new'] = gethex(v.split('\t\t')[0].split())
  writeDic(getPrettyDic(dic))
