#import "DJP_SearviceViewController.h"
#import <WebKit/WebKit.h>
@interface DJP_SearviceViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation DJP_SearviceViewController


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.webView evaluateJavaScript:@"document.body.style.webkitTextFillColor=\"#FFFFFF\"" completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.webView evaluateJavaScript:@"document.body.style.webkitTextFillColor=\"#FFFFFF\"" completionHandler:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户协议";
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height-NAVIGATION_BAR_HEIGHT)];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    if (@available(iOS 9.0, *)) {
        [self.webView loadFileURL:[[NSBundle mainBundle] URLForResource:@"VVServer" withExtension:@"html"] allowingReadAccessToURL:NSBundle.mainBundle.bundleURL];
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:self.webView];
    [self.webView setOpaque:NO];
}



@end
