//
//  ViewController.m
//  RunTime
//
//  Created by 王盛魁 on 2017/8/14.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>  // 导入此框架，验证消息发送机制，其内已导入<objc/runtime.h>
#import "ExchangeViewController.h"
@interface ViewController ()

@end
/*
 Runtime是运行时机制，是一套纯C的代码库，是OC的幕后工作者，整个OC的底层，我们编写的OC代码，在程序运行的时候，都经过Runtime机制转译成了C语言代码。
 Runtime是运行时机制，其中最主要的是消息机制。
 对于C语言而言，函数的调用在编译的时候决定调用哪个函数；
 而对于OC而言，并不会在编译的时候真正决定调用哪个函数，只有在真正调用的时候，才会根据函数的名称找到对应的函数来调用。
 在编译阶段，OC可以调用任何已声明的函数，至于函数是否实现，并不重要。
 在编译阶段，C调用未实现的函数，将会报错
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"----验证消息发送机制-开始----");
    
    // OC调用示例：
    [self exampleTransferWithOC];
    // 消息发送机制示例：
    objc_msgSend(self, @selector(exampleTransferWithOC));
    // 该行代码经过runtime就编译成了objc_msgSend(self,@selector(exampleTransferWithOC)); 向self发送exampleTransferWithOC方法
    NSLog(@"------分隔线--------");
    
    
    [self exampleTransferWithmsgSend];
    objc_msgSend(self, @selector(exampleTransferWithmsgSend));
    NSLog(@"------分隔线--------");
    
    
    // 其它验证
    [self otherTest];
    NSLog(@"----验证消息发送机制-结束----");
}

- (void)exampleTransferWithOC{
    Person *per = [[Person alloc]init];
    [per sayHello];
    [per sayMessage:@"说句话听听"];
}
- (void)exampleTransferWithmsgSend{
    id object = objc_msgSend([Person class], @selector(alloc));
    Person *per = objc_msgSend(object, @selector(init));
    objc_msgSend(per,@selector(sayHello));
    objc_msgSend(per, @selector(sayMessage:),@"我也会说hello");
    // 多个参数方法的消息发送
    objc_msgSend(per, @selector(sayMessage:WithBool:),@"我要说话",NO);
}

- (void)otherTest{
    Person *per = objc_msgSend(objc_msgSend(objc_getClass("Person"), sel_registerName("alloc")), sel_registerName("init"));
    objc_msgSend(per,sel_registerName("sayHello"));
    /*
     objc_getClass("Person")表示获得类对象，等同于[Person class]
     sel_registerName("alloc")表示注册一个方法，等同于@selector(alloc)
     */
}

- (IBAction)goToNextBtn {
    ExchangeViewController *exchangeVC = [[ExchangeViewController alloc]init];
    [self.navigationController pushViewController:exchangeVC animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
