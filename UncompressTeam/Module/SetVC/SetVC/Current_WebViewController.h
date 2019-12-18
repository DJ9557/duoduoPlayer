
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


 ///本地url 加载
// Current_WebViewController * web = [[Current_WebViewController alloc] init];
// web.isHttpWork = NO;
// web.cu_UrlStrOrName = @"PerfectChat";
 ////////////////////////

@interface Current_WebViewController : FAPBaseViewController
///标题
@property (nonatomic,strong) NSString *cu_titlestring;
///网页URL，本地的HTML名称
@property (nonatomic,strong) NSString *cu_UrlStrOrName;
///是不是网页的，NO：就是本地的
@property (nonatomic,assign) BOOL isHttpWork;

@end

NS_ASSUME_NONNULL_END
