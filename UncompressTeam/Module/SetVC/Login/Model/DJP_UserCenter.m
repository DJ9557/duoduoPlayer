#import "DJP_UserCenter.h"

@implementation DJP_UserCenter


#define kSAVE_USERINFOR @"save_userinfor"
static DJP_UserCenter *instance = nil;
+(DJP_UserCenter *) getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      instance = [[self alloc]init];
                  });
    return instance;
}

// 用户退出登录
- (void)userLogOut{
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kSAVE_USERINFOR];
    
}
- (BOOL) getUserIsLogin{
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kSAVE_USERINFOR] boolValue];
}
// 用户登录
- (void)userLogIn{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kSAVE_USERINFOR];
}

+ (NSString *)getUserPhoneNumber{
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    return phoneStr;
}

+ (BOOL)userPassWordIsRightAndPasswordString:(NSString *)password AndPhoneNumebr:(NSString *)phone{
    NSString *pwdString = [[NSUserDefaults standardUserDefaults]objectForKey:phone];
    if ([pwdString isEqualToString:password]) {
        return YES;
    }else{
        if ([phone isEqualToString:Account] && [password isEqualToString:Password]) {
            [[NSUserDefaults standardUserDefaults]setObject:Account forKey:@"phone"];
            [[NSUserDefaults standardUserDefaults]setObject:Password forKey:Account];
            return YES;
        }else{
            return NO;
        }
    }
}

+ (void)changePassword:(NSString *)password{
    NSString *phone = [DJP_UserCenter getUserPhoneNumber];
    [[NSUserDefaults standardUserDefaults]setObject:password forKey:phone];
}


@end
