//
//  ExchangeViewController.m
//  RunTime
//
//  Created by 王盛魁 on 2017/8/21.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "ExchangeViewController.h"
#import <objc/message.h> // 需要导入此框架
@interface ExchangeViewController ()

@end

@implementation ExchangeViewController
/*
 runtime 实现方法交换
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"----runtime实现方法交换-开始----");
    
    
    
    
    NSLog(@"----runtime实现方法交换-结束----");
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
