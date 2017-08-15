//
//  ViewController.m
//  RunTime
//
//  Created by 王盛魁 on 2017/8/14.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

#import <objc/message.h>  // 导入此框架，验证消息发送机制
#import <objc/runtime.h>  // 导入此框架，验证
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 验证消息发送机制
    /*
     Runtime是运行时机制，是一套纯C的代码库，是OC的幕后工作者，整个OC的底层，我们编写的OC代码，在程序运行的时候，都经过Runtime机制转译成了C语言代码
     */
    Person *per = [[Person alloc]init];
    //    [per sayHello];
    // 该行代码经过runtime就编译成了objc_msgSend(per,@selector(sayHello)); 向per发送sayHello方法
    objc_msgSend(per,@selector(sayHello));

    /*
     Runtime的作用：
     * 动态添加方法（KVO中，监听数组）；
     ** 动态生成类（KVO机制中？系统动态为我们生成了一个中间类，帮助我们完成观察者对象和被观察对象数据的传递）；
     *** 动态获取每个类中的属性名和实例变量名
     */
    // 参数一：获取哪个类中的实例变量  参数二：该类中实例变量的个数
    unsigned int count = 1; // 声明存储实例变量个数的变量
    Ivar *ivarList = class_copyIvarList([Person class], &count);
    // 获取数组中的实例变量名
    for (int i = 0; i < count ; i++) {
        Ivar ivar = ivarList[i];  //获取数组中对应位置的ivar
        // 获取ivar的名字
        const char *cStr = ivar_getName(ivar);
        // 转化为OC的字符串
        NSString *OCStr = [[NSString alloc]initWithCString:cStr encoding:NSUTF8StringEncoding];
        NSLog(@"%@",OCStr);
    }

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
