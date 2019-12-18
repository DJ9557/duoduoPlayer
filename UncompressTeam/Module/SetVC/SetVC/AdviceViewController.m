//
//  AdviceViewController.m
//  DuoTotalPlayer
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 DJ. All rights reserved.
//

#import "AdviceViewController.h"

@interface AdviceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = ASOColorBackGround;
}
- (IBAction)subBtnDown:(id)sender {
    if (_textView.text.length && _textFiled.text.length ) {
        [SVProgressHUD showSuccessWithStatus:@"提交中"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"您的反馈已收到，我们会尽快与你联系，处理问题，谢谢。"];
        });
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"邮箱和意见不能为空"];
    }
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
