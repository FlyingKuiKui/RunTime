//
//  DictToModel.h
//  RunTime
//
//  Created by 王盛魁 on 2017/8/22.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictToModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gender;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
