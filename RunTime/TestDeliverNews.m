//
//  TestDeliverNews.m
//  RunTime
//
//  Created by 王盛魁 on 2017/8/22.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "TestDeliverNews.h"
#import <objc/message.h>
#import "Person.h"

/*
  调用未实现的方法，进行消息转发
 */
@implementation TestDeliverNews
//  方法一
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    // 消息接收者没有找到对应的方法实现的时候，会先调用此方法，可在此方法实现中动态添加新的方法
    // 返回YES表示相应selector的实现已经被找到，或者添加新方法到了类中，否则返回NO
    return YES;
}

//  方法二
- (id)forwardingTargetForSelector:(SEL)aSelector {
    //  如果方法一的返回NO，或者直接返回了YES，而没有添加方法，该方法将会被调用
    //  在这个方法中，我们可以指定一个对象作为返回值，而返回的对象可以响应(aSelector)方法
    //  注意如果返回self就会死循环
    return nil;
}


//  方法三
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    //  如果方法二的返回值为nil，则此方法(方法三)会被调用，系统会询问我们要一个合法的『类型编码(Type Encoding)』
    //  如果该方法返回 nil，则不会进入下一步，而是无法处理消息

    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

// 方法四(1)
// 在这里进行消息转发
// 当方法四(1)被实现之后，方法四(2)将不会被调用
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    // 在这里可以改变方法选择器
    [anInvocation setSelector:@selector(sayHello)];
    
    // 改变方法选择器后，需要指定消息的接收者
    // 这里指定Person的对象为消息的接受者
    Person *per = objc_msgSend(objc_msgSend(objc_getClass("Person"), sel_registerName("alloc")), sel_registerName("init"));
    [anInvocation invokeWithTarget:per];
    
    // 注意：anInvocation需要先改变方法选择器，然后再指定消息的接受者
}
// 方法四(2)
// 如果没有实现消息转发 forwardInvocation  则调用此方法
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"unresolved method ：%@", NSStringFromSelector(aSelector));
}

@end
