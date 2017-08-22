//
//  UIImage+Image.m
//  RunTime
//
//  Created by 王盛魁 on 2017/8/22.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/message.h>
/*
 Objective-C 提供了一下API用于动态替换类方法或者实例方法的实现：
    class_replaceMethod 替换类方法的定义
    method_exchangeImplementations 交换两个方法的实现
    method_setImplementation 设置一个方法的实现
 注：class_replaceMethod 试图替换一个不存在的方法时候，会调用class_addMethod为该类增加一个新方法
 */
@implementation UIImage (Image)
#pragma mark - 交换方法实现
// 把类加载进内存的时候调用,只会调用一次
+ (void)load{
    // 修改类方法实现示例：
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method xmg_imageNamedMethod = class_getClassMethod(self, @selector(xmg_imageNamed:));
    // 利用runtime实现方法的交换
    method_exchangeImplementations(imageNamedMethod, xmg_imageNamedMethod);

    // 修改对象方法实现示例：
    Method method1 = class_getInstanceMethod(self, @selector(sayOne));
    Method method2 = class_getInstanceMethod(self, @selector(sayTwo));
    method_exchangeImplementations(method1, method2);
}
// 此方法会调用多次
/*
+ (void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

    });
}
*/
// 在分类中,最好不要重写系统方法,一旦重写,把系统方法实现给干掉
/*
+ (UIImage *)imageNamed:(NSString *)name{
    // super -> 父类NSObject

}
*/

+ (UIImage *)xmg_imageNamed:(NSString *)name{
    // 由于已经实现了方法交换，故[UIImage xmg_imageNamed:name]的内部调用实际上走的是[UIImage imageNamed:name]原本的内部实现。
    UIImage *image = [UIImage xmg_imageNamed:name];
    
    if (image) {
        NSLog(@"加载成功");
    } else {
        NSLog(@"加载失败");
    }
    return image;
}


- (void)sayOne{
    NSLog(@"One");
}
- (void)sayTwo{
    NSLog(@"Two");
}
#pragma mark - 动态添加方法
// 对象方法未实现，会调用此类方法
+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    [NSStringFromSelector(sel) isEqualToString:@"clearImage"]; // 判断方式1
    // BOOL class_addMethod(Class cls, SEL name, IMP imp,const char *types)
    // 参数一：为哪个类添加方法；参数二：添加什么方法；参数三：方法实现 => 函数 => 函数入口 => 函数名；参数四：方法类型：void用v来表示，id参数用@来表示，SEL用:来表示
    if (NSSelectorFromString(@"clearImage") == sel) {
        class_addMethod(self, sel, (IMP)clearImage, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
void clearImage(id self, SEL _cmd, NSNumber *number){

    NSLog(@"clearImage for %@--%@--%@", self,NSStringFromSelector(_cmd),number);
}

// 如果是类方法未实现，则会调用下述方法：
/*
 + (BOOL)resolveClassMethod:(SEL)sel{
 }
 */
#pragma mark - 动态添加属性
- (void)setImageUrl:(NSString *)imageUrl{
    objc_setAssociatedObject(self, "imageUrl", imageUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)imageUrl{
    return objc_getAssociatedObject(self, "imageUrl");
}

@end
