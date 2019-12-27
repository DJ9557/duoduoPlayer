//
//  MainTabVC.m
//  FutureGoodsProject
//
//  Created by mac on 2019/7/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DJP_MainTabVC.h"
#import "DJP_MainNavController.h"
#import "UNMainFileManageViewController.h"
#import "DJP_SettingViewController.h"
#import "UNMoreSettingViewController.h"
#import "UNWatchMovieOnlineViewController.h"
@interface DJP_MainTabVC ()<UITabBarControllerDelegate>

@end

@implementation DJP_MainTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    self.delegate = self;
    [self.tabBar setTintColor:ASOColorTheme];
    self.tabBar.translucent = NO;
    UIColor* color = [UIColor whiteColor];
    [self.tabBar setBarTintColor:color];
}
-(void)initViews
{
    UNMainFileManageViewController* homeVC = [[UNMainFileManageViewController alloc] init];
    
    UNMoreSettingViewController * marketVC = [[UNMoreSettingViewController alloc] init];
    
    UNWatchMovieOnlineViewController *selectVC = [[UNWatchMovieOnlineViewController alloc] init];
    
    DJP_SettingViewController* mineVC = [[DJP_SettingViewController alloc] init];
    
    
    NSArray*  normalImgArr= @[@"1",@"2",@"4",@"5"];
    NSArray*  seleImgArr= @[@"a",@"b",@"d",@"e",];
    NSArray*  titleArr= @[@"文件",@"传输",@"在线观看",@"我的"];
    //创建存有视图控制器的数组
    NSArray *ViewControllers = [NSArray arrayWithObjects:homeVC,marketVC,selectVC,mineVC,nil];
    
    for (int i=0; i<ViewControllers.count; i++) {
        
        UIImage* itemImg = [UIImage imageNamed:normalImgArr[i]];
        UIImage* selectItemImg = [UIImage imageNamed:seleImgArr[i]];
        
        DJP_MainNavController *baseNav = [[DJP_MainNavController alloc] initWithRootViewController:ViewControllers[i]];
        
        [baseNav.tabBarItem setTitle:[NSString stringWithFormat:@"%@",titleArr[i]]];
        //图片居中显示
        CGFloat offset = 3.0;
        baseNav.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
        [baseNav.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName:KGray2Color}  forState:UIControlStateNormal];
        [baseNav.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName:ASOColorTheme}  forState:UIControlStateSelected];
       
        //做一下图片的渲染效果
        [baseNav.tabBarItem setImage:[itemImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [baseNav.tabBarItem setSelectedImage:[selectItemImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        [self addChildViewController:baseNav];
    }
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
   
    return YES;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
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
