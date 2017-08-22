//
//  ExchangeViewController.m
//  RunTime
//
//  Created by 王盛魁 on 2017/8/21.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "ExchangeViewController.h"
#import "UIImage+Image.h"  // 方法交换、动态添加方法、动态添加属性
#import "TestDeliverNews.h" // 验证消息的转发
#import "DictToModel.h" // 字典转化为模型

@interface ExchangeViewController ()

@end

@implementation ExchangeViewController
/*
 runtime 实现方法交换
 
 #当系统提供的控件不能满足我们的需求的时候，我们可以
 1：通过继承系统控件，重写系统的方法，来扩充子类的行为（super的调用三种情况）
 2：当需要为系统类扩充别的属性或是方法的时候，与哪个类有关系，就为哪个类创建分类。
 3：利用runtime修改系统的类，增加属性，交换方法，消息机制，动态增加方法
 
 #解决方法：
 1：重写系统的方法：新建类继承系统的类，重写系统的方法（要是覆盖父类的行为就不需要调用super，或是在super方法之下调用:在保留父类super原有的行为后，扩充子类自己的行为，代码写在super之上，可以修改super要传递的参数，例如重写setframe，要是想保留父类的行为就不要忘记调用super）。弊端：需要在每个类中都需要引入头文件
 2：写分类：为哪个系统的类扩充属性和方法，就为哪个类写分类 
 3：利用runtime底层的实现来修改或是访问系统的类：增加属性，交换方法，消息机制，动态增加方法
 
 # 本需求利用runtime：不需要导入头文件，调用的还是系统类原来的方法，只是利用了runtime的交换方法。
 给系统的imageNamed添加图片是否加载完全功能,只能使用runtime(交互方法)
 1.给系统的方法添加分类
 2.自己实现一个带有扩展功能的方法
 3.交互方法,只需要交互一次,
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self exchangeMethod];
    
    [self addMethod];
    
    [self addAttribute];
    
    [self testDeliverNews];
    
    [self dictToModel];
    
}

#pragma mark - 方法交换
- (void)exchangeMethod{
    NSLog(@"----runtime--方法交换-开始----");
    UIImage *image = [[UIImage alloc]init];
    [image sayOne]; // Two
    [UIImage imageNamed:@"one.png"]; // 加载成功
    NSLog(@"----runtime--方法交换-结束----");
}

#pragma mark - 动态添加方法
- (void)addMethod{
    NSLog(@"----runtime--动态添加方法-开始----");
    UIImage *image = [[UIImage alloc]init];
    //    [image clearImage];
    [image performSelector:@selector(clearImage) withObject:@"kkkk"];
    NSLog(@"----runtime--动态添加方法-结束----");
}

#pragma mark - 动态添加属性
- (void)addAttribute{
    NSLog(@"----runtime--动态添加属性-开始----");
    UIImage *image = [[UIImage alloc]init];
    image.imageUrl = @"http://";
    NSLog(@"%@",image.imageUrl);
    NSLog(@"----runtime--动态添加属性-结束----");
}

#pragma Mark - 消息转发
- (void)testDeliverNews{
    TestDeliverNews *test = [[TestDeliverNews alloc]init];
    [test clearNews];
}

#pragma mark - 字典转化为模型
- (void)dictToModel{
    DictToModel *model = [DictToModel modelWithDictionary:@{@"name":@"wang",@"gender":@"man"}];
    NSLog(@"%@",model.name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
