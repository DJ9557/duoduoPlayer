
//
//  BaseViewController.m
//  FutureGoodsProject
//
//  Created by mac on 2019/7/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()
@property (nonatomic,strong) UIImageView * backView;
@property (nonatomic,strong) UIImage * backImage;
@property (nonatomic,strong) UIImageView * addBackView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat bottomView_H = 0;
    if (iPhoneX) {
        bottomView_H = 34;
    }
    
//    self.backView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height + bottomView_H + STATUS_BAR_HEIGHT)];
//
//    UIImage * addImage =[UIImage imageNamed:@"viewBack"];
//    self.addBackView =[[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width/2 -addImage.size.width/2, Screen_Height/2 - addImage.size.width/2, addImage.size.width, addImage.size.height)];
//    self.addBackView.image = addImage;
//    self.addBackView.alpha = 0.1;
//
//    [self.backView addSubview:self.addBackView];
    
//    [self.view addSubview:self.backView];
}
#pragma mark - 屏幕旋转 ---

/**
 是否需要旋转
 */
- (BOOL)shouldAutorotate {
    return NO;
}

/**
 支持的方向
 */
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

/**
 默认支持的方向
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
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
