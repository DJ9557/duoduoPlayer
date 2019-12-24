//
//  MainNavController.m
//  FutureGoodsProject
//
//  Created by mac on 2019/7/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DJP_MainNavController.h"

@interface DJP_MainNavController ()

@end

@implementation DJP_MainNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    去除backButton文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin)
                                                         forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    //设置返回图片，防止图片被渲染变蓝，以原图显示
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [[UIImage imageNamed:@"viewBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
      self.navigationController.view.backgroundColor = [UIColor whiteColor];
      self.edgesForExtendedLayout = UIRectEdgeNone;
      self.navigationController.navigationBar.translucent = NO;
      self.navigationController.navigationBar.tintColor = ASOColorTheme;
      [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ASOColorTheme, NSForegroundColorAttributeName, nil]];
      [self.navigationItem setHidesBackButton:YES];
}
- (void)backItemClick
{
    [self popViewControllerAnimated:YES];
}

//拦截push 以后控制器push就不用手动调用隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //navigationBar
    if (self.childViewControllers.count > 0) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 44, 44);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        // 隐藏底部导航栏
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}
- (void)back
{
    [self popViewControllerAnimated:YES];
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
