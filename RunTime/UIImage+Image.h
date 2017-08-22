//
//  UIImage+Image.h
//  RunTime
//
//  Created by 王盛魁 on 2017/8/22.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
@property (nonatomic, copy) NSString *imageUrl; // 动态添加属性


// 对象方法
- (void)sayOne;
- (void)sayTwo;

// 未实现的对象方法
- (void)clearImage;


@end
