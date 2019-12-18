//
//  DTOSettingViewController.m
//  DuoTotalPlayer
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 DJ. All rights reserved.
//

#import "UNSettingViewController.h"
#import "AdviceViewController.h"
#import "AboutUsViewController.h"
#import <MessageUI/MessageUI.h>
@interface UNSettingViewController ()<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *deleteMemory;
@property (weak, nonatomic) IBOutlet UIView *adviceView;
@property (weak, nonatomic) IBOutlet UIView *aboutUsView;
@property (weak, nonatomic) IBOutlet UIButton *logOutBTn;

@end

@implementation UNSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = ASOColorBackGround;
    [self initViewsAddGesture];
    
}
- (void)initViewsAddGesture
{
    _deleteMemory.layer.masksToBounds = YES;
    _deleteMemory.layer.cornerRadius = 5;
    [_deleteMemory addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delete)]];
    
    _adviceView.layer.masksToBounds = YES;
    _adviceView.layer.cornerRadius = 5;
    [_adviceView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(advice)]];
    
    _aboutUsView.layer.masksToBounds = YES;
    _aboutUsView.layer.cornerRadius = 5;
    [_aboutUsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aboutUs)]];
}

-(void)delete
{
    [SVProgressHUD showWithStatus:@"清除缓存……"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"清除成功"];
        [SVProgressHUD dismiss];
    });
}
-(void)advice
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你使用过程遇到什么问题或有改进的地方，可以发邮件告诉我，谢谢。" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"写邮件" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString *mailUrl = [[NSMutableString alloc] init];
        [mailUrl appendFormat:@"mailto:%@?", @"951891012@qq.com"];
        NSString *emailPath = [mailUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailPath]options:nil completionHandler:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

-(void)aboutUs
{
    AboutUsViewController *about = [[AboutUsViewController alloc] init];
    [self.navigationController pushViewController:about animated:YES];
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
