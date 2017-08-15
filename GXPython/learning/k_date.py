# !/usr/bin/python
#coding=utf-8

from alloc import alloc_method
from init import init_method


def print_hello():
    print '调用了另一个模块的hello方法!'
    print 'hello'

def print_world():
    print '调用了另一个模块的world方法'
    print 'world!!'