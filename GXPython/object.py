# !/usr/bin/python
#coding=utf-8


class Employee:
    "所有员工的基类"
    employee_count = 0

    # 两个下划线开头，声明该属性为私有，不能在类的外部被使用或直接访问。
    # 在类内部的方法中使用时self.__private_attrs。
    __private_attr = 100

    def __init__(self,name,salary):
        self.name = name
        self.salary = salary
        # 全局变量最好还是用类调用.(为啥?)
        Employee.employee_count += 1

        self.__private_attr = 10000


    def __private_method(self):
        self.name = "sunguangxin"

    def public_method(self):
        self.__private_method()
        print "name: ",self.name,"private_attr: ",self.__private_attr
        print 'name:%s; private_attr:%d' % (self.name, self.__private_attr)

    def __del__(self):
        print "销毁", self.name


print '-------->>>>>>'
print "1.创建类"


def private_method_and_attr():
    emp = Employee("sunxin",10000)
    print "name: ",emp.name
    emp.public_method()
    print "name: ",emp.name

private_method_and_attr()





def create_object():
    emp1 = Employee("sun", 100000)
    print "员工1详情:", emp1.name, emp1.salary, emp1.employee_count

    emp2 = Employee("liu", 100000)
    print "员工2详情:", emp2.name, emp2.salary, emp2.employee_count

    print "员工总数:", Employee.employee_count

def object_attr():
    emp1 = Employee("sun", 100000)
    print "如果存在 'age' 属性返回 True: ", hasattr(emp1, 'age')
    print "添加属性 'age' 值为 8:  ", setattr(emp1, 'age', 8)
    print "返回 'age' 属性的值: ", getattr(emp1, 'age')
    print "删除属性 'age':  ", delattr(emp1, 'age')

def object_class_attr():
    # Python内置类属性
    # __dict__ : 类的属性（包含一个字典，由类的数据属性组成）
    # __doc__ :类的文档字符串
    # __name__: 类名
    # __module__: 类定义所在的模块
    # 类的全名是'__main__.className'
    # 如果类位于一个导入模块mymod中
    # 那么className.__module__ 等于 mymod）
    # __bases__ : 类的所有父类构成元素（包含了一个由所有父类组成的元组）
    emp1 = Employee("sun", 100000)
    print "Employee.__doc__:", Employee.__doc__
    print "Employee.__name__:", Employee.__name__
    print "Employee.__module__:", Employee.__module__
    print "Employee.__bases__:", Employee.__bases__
    print "Employee.__dict__:", Employee.__dict__





