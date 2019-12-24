#import "DJP_ChangePasswordViewController.h"
#import "DJP_LoginTool.h"
#import "DJP_UserCenter.h"
@interface DJP_ChangePasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdAgainTF;

@property (weak, nonatomic) IBOutlet UIButton *changeBtn;


@end

@implementation DJP_ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    self.oldTF.attributedPlaceholder = [DJP_LoginTool textFieldPlaceholderString:@"请输入老密码" AndTextColor:[UIColor whiteColor]];
    self.pwdTF.attributedPlaceholder = [DJP_LoginTool textFieldPlaceholderString:@"请输入新密码（6位以上）" AndTextColor:[UIColor whiteColor]];
    self.pwdAgainTF.attributedPlaceholder = [DJP_LoginTool textFieldPlaceholderString:@"请再次输入密码（6位以上）" AndTextColor:[UIColor whiteColor]];
    [DJP_LoginTool setCornerRadiusAndBorderWithButton:self.changeBtn AndBorderColor:ASOColorTheme];
    [self.changeBtn setTitleColor:ASOColorTheme forState:UIControlStateNormal];
}

- (IBAction)clickChangeButton:(id)sender {
    
    if ([DJP_UserCenter userPassWordIsRightAndPasswordString:self.oldTF.text AndPhoneNumebr:[DJP_UserCenter getUserPhoneNumber]]) {
        if ([self.pwdTF.text isEqualToString:self.pwdAgainTF.text] && self.pwdTF.text.length >= 6) {
            [DJP_UserCenter changePassword:self.pwdAgainTF.text];
            [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
            [SVProgressHUD dismissWithDelay:1.0];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
            [SVProgressHUD dismissWithDelay:1.0];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"老密码错误"];
        [SVProgressHUD dismissWithDelay:1.0];
    }
    
}

@end
