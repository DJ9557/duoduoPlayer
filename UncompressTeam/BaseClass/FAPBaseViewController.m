//
//  FAPBaseViewController.m
//  LDDVideoPro
//
//  Created by Mac on 2019/5/9.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPBaseViewController.h"
#import <objc/message.h>
@interface FAPBaseViewController ()


@end

@implementation FAPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ASOColorBackGround;
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = barItem;
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
