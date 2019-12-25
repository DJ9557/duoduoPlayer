//
//  ProtolVC.m
//  FutureGoodsProject
//
//  Created by mac on 2019/7/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PDProtolVC.h"
@interface PDProtolVC ()<WKNavigationDelegate>
@property (nonatomic ,strong) UIWebView *webView;

@end

@implementation PDProtolVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self mw_initWebView];
    [self mw_createNav];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [SVProgressHUD dismiss];
}
- (void)mw_initWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"html"];
    NSURL* url = [NSURL  fileURLWithPath:path];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];//加载
    [SVProgressHUD showWithStatus:@"加载中……"];
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [SVProgressHUD dismiss];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD dismiss];
}
-(void)mw_createNav
{
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.frame = CGRectMake(15, 32, 30, 30);
    [navBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [navBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navBtn];
    
    [self.view bringSubviewToFront:navBtn];
}
- (void)dismiss
{
    [self.navigationController popViewControllerAnimated:YES];
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
