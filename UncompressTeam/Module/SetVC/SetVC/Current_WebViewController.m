
#import "Current_WebViewController.h"
#import <WebKit/WebKit.h>
#define SCREEN_WIDTH self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.height
@interface Current_WebViewController ()<WKNavigationDelegate>
@property (nonatomic ,strong) WKWebView *onlineWebView;
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) UIButton *closeBtn ;
@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation Current_WebViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self performSelectorOnMainThread:@selector(showProgress) withObject:nil waitUntilDone:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"用户使用协议";
    WKWebViewConfiguration *confifg = [[WKWebViewConfiguration alloc] init];
    confifg.selectionGranularity = WKSelectionGranularityCharacter;
    self.onlineWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:confifg];
    
    //    onlineWebView.backgroundColor = UIColor.blackColor;
    self.onlineWebView.opaque=NO;
    self.onlineWebView.navigationDelegate = self;
    [self.onlineWebView.scrollView setShowsVerticalScrollIndicator:NO];
    
    if (self.isHttpWork) {
        [self.onlineWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.cu_UrlStrOrName]]];
    }else{
        
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"server" ofType:@"html"];
        //    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [self.onlineWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
    }
    
    _onlineWebView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.onlineWebView];
    
     self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 3)];
    self.progressView.progressTintColor = [UIColor greenColor];
    [self.view addSubview:self.progressView];
     // 给webview添加监听
    [self.onlineWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

-(void)showProgress{
//     [SVProgressHUD show];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"] && object == self.onlineWebView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.onlineWebView.estimatedProgress animated:YES];
        if (self.onlineWebView.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:1.5 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
//                [SVProgressHUD dismiss];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
//                 [SVProgressHUD dismiss];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.navigationItem.title = @"加载中...";
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.navigationItem.title = self.cu_titlestring;
}


- (void)exitClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
