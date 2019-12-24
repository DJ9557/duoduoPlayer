#import "DJP_LoginViewController.h"
#import "DJP_RegisterViewController.h"
#import "MainTabVC.h"
#import "DJP_LoginTool.h"
#import "DJP_UserCenter.h"
@interface DJP_LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginTF;
@property (weak, nonatomic) IBOutlet UITextField *padTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation DJP_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}


- (IBAction)clickLoginButton:(id)sender {
    if([DJP_UserCenter userPassWordIsRightAndPasswordString:self.padTF.text AndPhoneNumebr:self.loginTF.text]){
        [[DJP_UserCenter getInstance]userLogIn];
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        [SVProgressHUD dismissWithDelay:1.0];
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        MainTabVC *root = [[MainTabVC alloc] init];
        window.rootViewController = root;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:@"密码错误"];
        [SVProgressHUD dismissWithDelay:1.0];
    }
}

- (IBAction)clickRegisterButton:(id)sender {
    DJP_RegisterViewController *registerVC = [[DJP_RegisterViewController alloc]init];
    registerVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:registerVC animated:YES completion:nil];
}

@end
