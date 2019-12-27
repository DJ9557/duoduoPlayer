#import "DJP_RegisterViewController.h"
#import "DJP_LoginTool.h"
#import "DJP_UserCenter.h"
#import "DJP_MainTabVC.h"
#import "DJP_SearviceViewController.h"
@interface DJP_RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdAgainTF;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@end

@implementation DJP_RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerBtn.backgroundColor = ASOColorTheme;
}

-(IBAction)registervcDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickRegisterButton:(id)sender {
    NSString *phoneStr = self.numberTF.text;
    NSString *pwdStr = self.pwdTF.text;
    NSString *pwdAgainStr = self.pwdAgainTF.text;
    if (pwdStr.length >= 6 || pwdAgainStr.length >= 6) {
        if ([pwdStr isEqualToString:pwdAgainStr]){
            [[NSUserDefaults standardUserDefaults]setObject:phoneStr forKey:@"phone"];
            [[NSUserDefaults standardUserDefaults]setObject:pwdStr forKey:phoneStr];
            [[DJP_UserCenter getInstance]userLogIn];
            UIWindow *window = UIApplication.sharedApplication.keyWindow;
            DJP_MainTabVC *root = [[DJP_MainTabVC alloc] init];
            window.rootViewController = root;
            [self.navigationController popToRootViewControllerAnimated:YES];

        }else{
            [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
            [SVProgressHUD dismissWithDelay:1.0];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"密码大于6位数"];
        [SVProgressHUD dismissWithDelay:1.0];
    }
    
}
- (IBAction)clickUserAgreementButton:(id)sender {
    // 用户协议
    DJP_SearviceViewController *service = [[DJP_SearviceViewController alloc]init];
    service.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:service animated:YES completion:nil];
}

@end
