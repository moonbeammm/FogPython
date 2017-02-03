# !/usr/bin/python
#coding=utf-8

#Python中默认的编码格式是 ASCII 格式，在没修改编码格式时无法正确打印汉字，所以在读取中文时会报错。
#解决方法为只要在文件开头加入#coding=utf-8 就行了。
##coding=utf-8必须紧跟着# !/usr/bin/python下一行.中间不能空行.


def do_print():
    print 'hello world'
    print '100 + 200 =', 100 + 200
    print 100 + 200

# code 1 打印
# do_print()






def do_appendent_string():
    import sys
    x = 'runloop'
    sys.stdout.write(x+'second')

# code 2 拼接字符串
# do_appendent_string()




def do_user_input():
    name = raw_input('please enter your name:')
    print 'hello %s!' , name
    if name == "sunguangxin":
	    print 'i love you,%s!', name
    else :
	    print '呵呵~~'

# code 2 下面的程序在按回车键后就会等待用户输入：
# 这样传入的变量只能放在最后.并不能指定位置.为什么?
# do_user_input()




def create_array():
    clasmates1 = ['michael', 'bob', 'tracy']
    clasmates2 = [11111,22222,3333,4444]
    clasmates3 = (44444,3333,2222,11111) # 这个也是数组吗?
    print clasmates1, clasmates2, clasmates3
    print clasmates1[0],clasmates2[0],clasmates3[0]
# code 3 创建数组
# create_array()


def create_dict():
    clasmates = {'name' : 'sunxxxxx', 'age' : 18}
    print clasmates
    print 'name: ', clasmates['name']
    print 'age: ',clasmates['age']

# code 4 创建字典
# create_dict()

# 这个忘了是干啥的.
# clasmates = set([1,2,2,3,3])


def if_else_method():
    # 从控制台输入的默认为字符串.怎么转成数字?
    # 使用int()可以强转类型
    age = int(raw_input('please enter your age: '))
    if age > 18 :
	    print 'you are a adult'
    else :
    	print 'you are a children'

# code 5 if-else判断
# if_else_method()



# code 6 绝对值
# print abs(-1)


# code 8 比较大小.
# A<B = -1
# A=B = 0
# A>B = 1
# print cmp(4, 3)

# code 9 类型强转.浮点型强转整型
# print int(12.3)

# code 10 给方法取别名
# a = abs
# print a(-1)



def my_abs(x):
	if not isinstance(x, (int, float)):
        # 相当于OC的NSAssert
		raise TypeError('input pram is error')
	if x >= 0:
		return x
	else:
		return -x

# code 11 自己写一个取绝对值方法
# print my_abs(-22)




# code 12 导入数学三方库,math.pi为180°
# import math
# print math.sin(math.pi / 4)


def multiReturn(x,y):
	x += 2
	y -= 10
	return x, y

# x, y = multiReturn(1,5)
# r = multiReturn(1,5)
# # code 13 传入多个参数.并返回多个参数
# print x, y
# # 返回的为(3,-5).这是什么类型?
# print r
print '-------->>>>>>'
print '1.Python变量类型'
print '<<<<<---------'
# 概念
# python中有五个标准的数据类型

# Numbers 数字

# 四种不同的数字类型:
# int 有符号整型
# long 长整型
# float 浮点型
# complex 复数


# String 字符串
# List 列表  -->> []
# Tuple 元组
# Dictionary 字典 -->> {}



def string_methon():
    str = 'Hello World!'

    print str  # 输出完整字符串
    print str[0]  # 输出字符串中的第一个字符
    print str[2:5]  # 输出字符串中第三个至第五个之间的字符串
    print str[2:]  # 输出从第三个字符开始的字符串
    print str * 2  # 输出字符串两次
    print str + "TEST"  # 输出连接的字符串

# python的字符串列表有两种取值顺序
# 从左到右索引默认0开始的，最大范围是字符串长度少1
# 从右到左索引默认-1开始的，最大范围是字符串开头
# string_methon()



def array_method():
    list = ['runoob', 786, 2.23, 'john', 70.2]
    tinylist = [123, 'john']

    print '输出完整列表', list
    print '输出列表的第一个元素', list[0]
    print '输出列表的第一个元素', list[1:3]
    print '输出从第三个开始至列表末尾的所有元素', list[2:]
    print tinylist * 2 # 输出列表两次
    print '打印组合的列表', list + tinylist
# array_method()



def tupple_method():
    tuple = ('runoob', 786, 2.23, 'john', 70.2)
    tinytuple = (123, 'john')

    print tuple  # 输出完整元组
    print tuple[0]  # 输出元组的第一个元素
    print tuple[1:3]  # 输出第二个至第三个的元素
    print tuple[2:]  # 输出从第三个开始至列表末尾的所有元素
    print tinytuple * 2  # 输出元组两次
    print tuple + tinytuple  # 打印组合的元组

# 元组是另一个数据类型，类似于List（列表）。
# 元组用"()"标识。内部元素用逗号隔开。但是元组不能二次赋值，相当于只读列表。
# 因为元组是不允许更新的。而列表是允许更新的.
# tupple_method()


def dict_method():
    dict = {}
    dict['one'] = "This is one"
    dict[2] = "This is two"

    tinydict = {'name': 'john', 'code': 6734, 'dept': 'sales'}

    print '输出键为one 的值', dict['one']
    print '输出键为 2 的值', dict[2]
    print '输出完整的字典', tinydict
    print '输出所有键', tinydict.keys()
    print '输出所有值', tinydict.values()

# dict_method()

print '--------->>>>>'
print '2.Python运算符'
print '<<<<<---------'
# 见笔记Note_Python

print '--------->>>>>'
print '3.Python条件语句'
print '<<<<<---------'

# if 判断条件：
#     执行语句……
# else：
#     执行语句……

print '--------->>>>>'
print '4.Python循环语句'
print '<<<<<---------'


def do_while_method():
    count = 0
    while (count < 9):
        print 'The count is:', count
        count = count + 1

    print "Good bye!"

# do_while_method()



def do_for_in_method():
    for letter in 'Python':  # 第一个实例
        print '当前字母 :', letter

    fruits = ['banana', 'apple', 'mango']
    for fruit in fruits:  # 第二个实例
        print '当前字母 :', fruit

    print "Good bye!"

# do_for_in_method()


def output_prime_number():
    i = 2
    while (i < 100):
        j = 2
        while (j <= (i / j)):
            if not (i % j): break
            j = j + 1
        if (j > i / j): print i, " 是素数"
        i = i + 1

    print "Good bye!"

# output_prime_number()

print '--------->>>>>'
print '5.Python日期和时间'
print '<<<<<---------'


import time;

def date_formatter():
    print '当前时间戳: ',time.time()
    local_time = time.localtime(time.time())
    year = local_time[2]
    print '当前时间: ',year

    asc_time = time.asctime(local_time)
    print '当前时间: ',asc_time


    # 格式化成2016-03-20 11:45:39形式
    print time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

    # 格式化成Sat Mar 28 22:24:24 2016形式
    print time.strftime("星期:%a 月:%b day:%d %H:%M:%S 年:%Y",time.localtime())

    # 将格式字符串转换为时间戳
    a = "Sat Mar 28 22:24:24 2016"
    print time.mktime(time.strptime(a, "%a %b %d %H:%M:%S %Y"))

# date_formatter()

def calendar_formatter():
    import calendar
    cal = calendar.month(2017,1)
    print cal

# 打印日历
# calendar_formatter()

print '--------->>>>>'
print '6.调用自定义模块里的方法'
print '<<<<<---------'


# k_date是我自定义的一个模块
# import k_date
# k_date.print_hello()



print '--------->>>>>'
print '7.dir()函数'
print '<<<<<---------'

# dir()函数一个排好序的字符串列表，内容是一个模块里定义过的名字。
# 返回的列表容纳了在一个模块里定义的所有模块，变量和函数。如下一个简单的实例：
# 他可以返回math模块所有定义的方法

# 导入内置math模块
# import math
#
# content = dir(math)
#
# print content;

print '-------->>>>>>'
print '8.globals()和locals()函数'
print '<<<<<---------'
# 根据调用地方的不同，globals()和locals()函数可被用来返回全局和局部命名空间里的名字。
# 如果在函数内部调用locals()，返回的是所有能在该函数里访问的命名。
# 如果在函数内部调用globals()，返回的是所有在该函数里能访问的全局名字。
# 两个函数的返回类型都是字典。所以名字们能用keys()函数摘取。

# def mine_method():
#     name = 'sun'
#     age = 12
#     print locals().keys()
#
# all_name = 'world'
# print globals().keys()
# mine_method()


print '-------->>>>>>'
print '9.Python中的包'
print '<<<<<---------'

# 不是很理解.
# 但是功能就是:
# hello模块import了k_date模块.
# 然后k_date模块显式包含了alloc和init模块的alloc_method和init_method方法.
# 这样hello模块只要包含了k_date模块.就可以通过k_date直接调用alloc_method和init_method方法.

# import k_date
#
# k_date.init_method()
# k_date.alloc_method()


print '-------->>>>>>'
print '10.读取键盘输入'
print '<<<<<---------'

# input([prompt]) 函数和 raw_input([prompt]) 函数基本类似
# 但是 input 可以接收一个Python表达式作为输入，并将运算结果返回。

def raw_input_and_input():
    name = raw_input("你的名字:")
    print "hello,",name

    list = input("数组:")
    print "你输入的数组是:",list

# raw_input_and_input()


print '-------->>>>>>'
print '11.打开和关闭文件'
print '<<<<<---------'
# http://www.runoob.com/python/python-files-io.html

def open_and_close_file():
    file = open("foo.txt","r+")
    print "文件名:",file.name



    file.write("i am a boy!\ngood boy!")
    # 关闭打开的文件
    file.close()

    file1 = open("foo.txt","r+")

    str = file1.read(3)
    print "从foo.txt文件里读取的字符串:",str
    file.close()

# open_and_close_file()

def location_file():
    import os


    print "当前目录:",os.getcwd()

    fo1 = open("foo.txt","wb")
    fo1.close()

    # 打开一个文件
    fo = open("foo.txt", "r+")
    fo.write("i am a good man!")
    str = fo.read(10)
    print "读取的字符串是 : ", str

    # 查找当前位置
    position = fo.tell()
    print "当前文件位置 : ", position

    str = fo.read(10)
    print "读取的字符是:",str

    # 把指针再次重新定位到文件开头
    position = fo.seek(0, 0)
    str = fo.read(10)
    print "重新读取字符串 : ", str
    # 关闭打开的文件
    fo.close()

    os.rename("foo.txt","foo2.txt")


    # 删除文件
    os.remove("foo2.txt")


# location_file()


print '-------->>>>>>'
print '11.Python里的目录'
print '<<<<<---------'

def file_manager():
    import os
    print "当前目录为:",os.getcwd()

    # os.mkdir("sun")
    os.chdir("sun")

    print "当前目录为:", os.getcwd()

    # os.chdir("GXPython")
    # print "当前目录为:", os.getcwd()

    print "",os.pardir
    print "",os.path.dirname(os.getcwd())

    # 返回上一级目录
    os.chdir(os.path.dirname(os.getcwd()))

    print "当前目录为:", os.getcwd()


    # 删除文件夹
    os.rmdir("sun")


# file_manager()




