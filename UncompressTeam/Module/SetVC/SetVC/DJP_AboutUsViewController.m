//
//  AboutUsViewController.m
//  DuoTotalPlayer
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 DJ. All rights reserved.
//

#import "DJP_AboutUsViewController.h"
#import "Current_WebViewController.h"
@interface DJP_AboutUsViewController ()

@end

@implementation DJP_AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];

}
- (IBAction)pushProtol:(id)sender {
    Current_WebViewController *web = [[Current_WebViewController alloc] init];
    [self.navigationController pushViewController:web animated:YES];
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
