#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJP_UserCenter : NSObject

+ (DJP_UserCenter *) getInstance;

///获取用户是否登录
- (BOOL) getUserIsLogin;
/// 用户退出登录
- (void)userLogOut;

/// 用户登录
- (void)userLogIn;

/// 改密码
+ (void)changePassword:(NSString *)password;

/// 判断密码是否正确
+ (BOOL)userPassWordIsRightAndPasswordString:(NSString *)password AndPhoneNumebr:(NSString *)phone;

/// 获取当前手机号
+ (NSString *)getUserPhoneNumber;

@end

NS_ASSUME_NONNULL_END
