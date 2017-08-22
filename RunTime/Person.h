//
//  Person.h
//  RunTime
//
//  Created by 王盛魁 on 2017/8/15.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
- (void)sayHello;
- (void)sayMessage:(NSString *)message;
- (void)sayMessage:(NSString *)message WithBool:(BOOL)isBool;
@end
