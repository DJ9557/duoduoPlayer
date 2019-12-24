//
//  FAPBaseViewController.m
//  LDDVideoPro
//
//  Created by Mac on 2019/5/9.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "DJP_BaseViewController.h"
#import <objc/message.h>
@interface DJP_BaseViewController ()


@end

@implementation DJP_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    self.navigationController.view.backgroundColor = [UIColor whiteColor];
//   self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = ASOColorTheme;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ASOColorTheme, NSForegroundColorAttributeName, nil]];
    [self.navigationItem setHidesBackButton:YES];
    // Do any additional setup after loading the view.
    //    self.view.backgroundColor = [UIColor whiteColor];
    //    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    //    self.navigationItem.leftBarButtonItem = barItem;
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.navigationController.navigationBar.translucent = NO;
    //    self.navigationController.navigationBar.tintColor = ASOColorTheme;
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
