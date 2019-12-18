//
//  UMUIConstructor.m
//  youmei
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 um. All rights reserved.
//

#import "UIMainConstructor.h"
#import "UNMainFileManageViewController.h"
#import "UNSettingViewController.h"
#import "FourthViewController.h"
static const NSArray *imageNames;
static const NSArray *selectedImageNames;
static UIMainConstructor *constructor;

@interface UIMainConstructor ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarController *tabBarController;

//@property (nonatomic, assign) BOOL isShowBar;
@end

@implementation UIMainConstructor


+ (instancetype)sharedUIConstructor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        constructor = [[UIMainConstructor alloc] init];
        
        
    });
    return constructor;
}


- (instancetype)init
{
    if (self = [super init])
    {
        if (!imageNames) {
            imageNames = @[@"a",
                           @"b",
                           
                           @"c",
                           @"d"
            ];
        }
        
        if (!selectedImageNames) {
            selectedImageNames = @[@"1",
                                   @"2",
                                   
                                   @"3",
                                   @"4"
            ];
        }
        
        
    }
    return self;
}



- (UITabBarController *)constructUI
{
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    [self setupViewControllers];
    
    return self.tabBarController;
}

//设置UI层次结构
- (void)setupViewControllers
{
    
    
    // 主页
    UNMainFileManageViewController *homeVc = [[UNMainFileManageViewController alloc] init];
    
    homeVc.title = @"文件";
    homeVc.hidesBottomBarWhenPushed = NO;
    LYTBaseNavigationController *homeNC = [[LYTBaseNavigationController alloc] initWithRootViewController:homeVc];
    
    //传输
    UNSettingViewController *findVc = [[UNSettingViewController alloc] init];
    findVc.title = @"传输";
    findVc.hidesBottomBarWhenPushed =NO;
    LYTBaseNavigationController *findNC = [[LYTBaseNavigationController alloc] initWithRootViewController:findVc];
    
    //我的
    FourthViewController *meVc = [[FourthViewController alloc] init];
    meVc.title = @"设置";
    meVc.hidesBottomBarWhenPushed =NO;
    LYTBaseNavigationController *meNC = [[LYTBaseNavigationController alloc] initWithRootViewController:meVc];
    
    
    self.tabBarController.viewControllers = @[
        homeNC,
        findNC,
        meNC
    ];
    
    
    [self.tabBarController.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        UIImage *image = [UIImage imageNamed:imageNames[idx]];
        UIImage *imageSelected = [UIImage imageNamed:selectedImageNames[idx]];
        item.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];
    
    self.tabBarController.tabBar.barTintColor = RGBCOLOR(19, 29, 50);
    self.tabBarController.tabBar.tintColor = [UIColor colorWithHexString:@"5fa6f8"];
    self.tabBarController.tabBar.translucent = NO;
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.whiteColor,
//                                                        NSFontAttributeName:[UIFont fontWithName:fFont size:10.f]
//    } forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(13, 117, 254)} forState:UIControlStateSelected];
//    [UITabBarItem appearance].titlePositionAdjustment = UIOffsetMake(0, -2.0f);
}


@end
