//
//  Person.m
//  RunTime
//
//  Created by 王盛魁 on 2017/8/15.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)sayHello{
    NSLog(@"Hello");
}
- (void)sayMessage:(NSString *)message{
    NSLog(@"%@",message);
}
- (void)sayMessage:(NSString *)message WithBool:(BOOL)isBool{
    if (isBool) {
        NSLog(@"%@",message);
    }
}


@end
