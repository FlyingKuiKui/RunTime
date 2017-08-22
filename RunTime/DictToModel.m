//
//  DictToModel.m
//  RunTime
//
//  Created by 王盛魁 on 2017/8/22.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "DictToModel.h"
#import <objc/message.h>

@implementation DictToModel
+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary{
    id model = [[self alloc] init];
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList(self, &count);
    // count：属性个数  ivars：属性指针数组
    for (int i = 0 ; i < count; i++) {
        Ivar ivar = ivars[i];
        
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //这里注意，拿到的成员变量名(ivarName)为_name,_gender,因此需要截取字符串获得真正的成员变量名
        
        ivarName = [ivarName substringFromIndex:1];
        id value = dictionary[ivarName];
        
        [model setValue:value forKeyPath:ivarName];
    }
    
    return model;

}
@end
