//
//  WatchMovieOnlineViewController.m
//  GQAllPlayer
//
//  Created by MAC on 09/12/2019.
//  Copyright © 2019 wache. All rights reserved.
//

#import "UNWatchMovieOnlineViewController.h"
#import "UNHistoryTableViewCell.h"
#import "UNHistoryManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <Masonry/Masonry.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "WebviewProgressLine.h"
#import "AVPlayerItem+Hook.h"
#import "AvplayItemManger.h"
#import "OnlineCollectionCell.h"
#import "OnlineCollectionReusableView.h"
#import "OnlineMarkModel.h"
#import "OnlinePlayModel.h"
#import "DJP_VideoManager.h"
#define WEAKSELF                    typeof(self) __weak weakSelf=self;

@interface UNWatchMovieOnlineViewController ()<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIBarButtonItem *shuaxinBtn;
    UIBarButtonItem *backBtn;
    UIBarButtonItem *forwardBtn;
    UIBarButtonItem *mainBtn;
    UIBarButtonItem *putBtn;
    UIBarButtonItem *handleBtn;
    UIBarButtonItem *spaceItem;
}
@property (nonatomic, strong)UITextField *urlTextField;
@property (nonatomic, strong)UITableView *historyTableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic ,strong)UISearchBar *searchBar;
@property (nonatomic, strong) UIView *webBgView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic ,strong) UIButton *reloadBtn;
@property (nonatomic,strong) WebviewProgressLine  *progressLine;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *markDataArray;
@property (nonatomic, strong) NSMutableArray *historyDataArray;
@property (nonatomic ,copy) NSString *markTitleStr;
@property (nonatomic ,copy) NSString *markUrl;

@end

@implementation UNWatchMovieOnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSearchBar];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
    //    [self initSubViews];
    [self.view addSubview:self.collectionView];
    [self getLoadData];
    [self createWebBgVoew];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAVItem:) name:@"NeedPlayMedia" object:nil];
}
- (void)handleAVItem:(NSNotification*)notification
{
    NSDictionary* Info = [notification object];
    NSString *url = Info[@"url"];
    if (url.length) {
        [SVProgressHUD dismiss];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"链接：%@",url] preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction actionWithTitle:@"立即播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                OnlinePlayModel *model = [[OnlinePlayModel alloc] init];
                model.name = self.markTitleStr;
                model.urlStr = url;
                model.imgData = UIImageJPEGRepresentation([DJP_VideoManager getThumbnailImage:url], 1);
                [model save];
                [self getLoadData];
                AVPlayerViewController *playVC = [[AVPlayerViewController alloc] init];
                playVC.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:url]];
                AVAudioSession *session = [AVAudioSession sharedInstance];
                [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
                [self presentViewController:playVC animated:YES completion:^{
                    
                }];
                [playVC.player play];
                
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"拷贝视频链接" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIPasteboard *pboard = [UIPasteboard generalPasteboard];
                pboard.string = url;
                [SVProgressHUD showSuccessWithStatus:@"链接已经拷贝"];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        });
        
    }
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_Width-15)/4-5, 110);
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        layout.headerReferenceSize = CGSizeMake(SCREEN_Width, 50);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 0;
        //        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, ScreenHeight-TAB_BAR_HEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paybg"]];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"OnlineCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"OnlineCollectionCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"OnlineCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"OnlineCollectionReusableView"];
    }
    return _collectionView;
}
-(NSMutableArray *)markDataArray
{
    if (!_markDataArray) {
        _markDataArray = [NSMutableArray array];
    }
    return _markDataArray;
}
-(NSMutableArray *)historyDataArray
{
    if (!_historyDataArray) {
        _historyDataArray = [NSMutableArray array];
    }
    return _historyDataArray;
}
- (void)getLoadData
{
    if (self.markDataArray.count) {
        [self.markDataArray removeAllObjects];
    }
    for (OnlineMarkModel *model in [OnlineMarkModel findAll]) {
          [self.markDataArray addObject:model];
    }
    [self.collectionView reloadData];
    
    if (self.historyDataArray.count) {
          [self.historyDataArray removeAllObjects];
      }
      for (OnlinePlayModel *model in [OnlinePlayModel findAll]) {
            [self.historyDataArray addObject:model];
      }
      [self.collectionView reloadData];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    OnlineCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"OnlineCollectionReusableView" forIndexPath:indexPath];
    NSArray *headerArr = @[@"我的标签",@"在线播放记录"];
    header.titleLabel.text = headerArr[indexPath.section];
    header.interDownBlock = ^{
        NSLog(@"oooo%@",headerArr[indexPath.section]);
    };
    return header;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return  self.markDataArray.count;
    }
    else
    {
        return self.historyDataArray.count;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
    {
        OnlineMarkModel *model = self.markDataArray[indexPath.row];
        OnlineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OnlineCollectionCell" forIndexPath:indexPath];
        cell.titlelabel.text = model.name;
        cell.imgView.image = [UIImage imageNamed:model.imgStr];
        return cell;
    }
    else
    {
        OnlinePlayModel *model = self.historyDataArray[indexPath.row];
        OnlineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OnlineCollectionCell" forIndexPath:indexPath];
        cell.titlelabel.text = model.name;
        if (model.imgData) {
             cell.imgView.image = [UIImage imageWithData:model.imgData];
        }
        else
        {
            cell.imgView.image = [UIImage imageNamed:@"播放占位"];
        }
              return cell;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        OnlineMarkModel *model = self.markDataArray[indexPath.row];
        [self startWebViewWithUrlStr:model.urlStr];
    }
    else
    {
        OnlinePlayModel *model = self.historyDataArray[indexPath.row];

        //跳转到播放器
             AVPlayerViewController *playVC = [[AVPlayerViewController alloc] init];
             playVC.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:model.urlStr]];
             AVAudioSession *session = [AVAudioSession sharedInstance];
             [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
             [self presentViewController:playVC animated:YES completion:^{
                 
             }];
             [playVC.player play];
    }
}
#pragma mark - webview
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate =self;
        _webView.scalesPageToFit = YES;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _webView.contentMode = UIViewContentModeRedraw;
        _webView.opaque = YES;
    }
    return _webView;
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.progressLine startLoadingAnimation];
    [AVPlayerItem startHook];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL * url = [request URL];
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.progressLine endLoadingAnimation];
     self.markTitleStr = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.markUrl = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    self.searchBar.text = self.markUrl;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.progressLine endLoadingAnimation];
}
#pragma mark - 搜索
//搜索
- (void)createSearchBar {
    //页面原始数据
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    CGRect frame = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, 40);
    _searchBar = [[UISearchBar alloc] initWithFrame:frame];
    _searchBar.placeholder = @"请输入链接";
    _searchBar.delegate = self;
    _searchBar.tintColor = ASOColorTheme;
    _searchBar.showsCancelButton = NO;
    self.reloadBtn.frame = CGRectMake(_searchBar.width-40, 20, 20, 20);
    [_searchBar addSubview:self.reloadBtn];
   
    if(@available(iOS 11.0, *)) {
        [[_searchBar.heightAnchor constraintEqualToConstant:44] setActive:YES];
    }
    self.navigationItem.titleView = _searchBar;
    UIButton *cancleBtn = [_searchBar valueForKey:@"cancelButton"];
    [cancleBtn addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:ASOColorTheme forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(UIButton *)reloadBtn
{
    if (!_reloadBtn) {
        _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reloadBtn setImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
        [_reloadBtn addTarget:self action:@selector(reloadButtonPush) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadBtn;
}
- (void)cancelSearch {
    [self.searchBar resignFirstResponder];
    [self WebViewIsHidden:YES];
    self.searchBar.showsCancelButton = NO;
    self.reloadBtn.hidden = NO;
}
- (void)startWebViewWithUrlStr:(NSString*)urlStr
{
     [self WebViewIsHidden:NO];
     [self webViewLoadUrlStr:urlStr];
}
#pragma mark - UISearchBarDelegate
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//
//}
//-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
//{
//    if (_searchBar.text.length) {
//        [self startWebViewWithUzhengrlStr:_searchBar.text];
//    }
//    return YES;
//}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    UIButton *cancleBtn = [_searchBar valueForKey:@"cancelButton"];
    [cancleBtn addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [searchBar setShowsCancelButton:YES animated:YES];
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _searchBar.showsCancelButton = YES;
    self.reloadBtn.hidden = YES;
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (_searchBar.text.length) {
           [self startWebViewWithUrlStr:_searchBar.text];
       }
    [self cancelSearch];
}

- (void)WebViewIsHidden:(BOOL)ishide
{
    _webBgView.hidden = ishide;
    [self handleWebBtns];
    [self.navigationController setToolbarHidden:ishide animated:YES];
}
- (void)webViewLoadUrlStr:(NSString*)str
{
    NSURL *url = [NSURL URLWithString:str];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}
- (void)handleWebBtns
{
    spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"后退"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPush)];
    forwardBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"前进"] style:UIBarButtonItemStylePlain target:self action:@selector(forwardButtonPush)];
    
    mainBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"首页"] style:UIBarButtonItemStylePlain target:self action:@selector(pushMainView)];
    putBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"导出"] style:UIBarButtonItemStylePlain target:self action:@selector(putData)];
    handleBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"操作"] style:UIBarButtonItemStylePlain target:self action:@selector(handleWebView)];
    
    [self setToolbarItems:@[backBtn,spaceItem, forwardBtn,spaceItem,  handleBtn,spaceItem, putBtn,spaceItem,mainBtn] animated:YES];
}
- (void)backButtonPush {
    if (self.webView.canGoBack)
    {
        [self.webView goBack];
    }
}
- (void)forwardButtonPush {
    if (self.webView.canGoForward)
    {
        [self.webView goForward];
    }
}
-(void)pushMainView
{
    [self WebViewIsHidden:YES];
}
- (void)putData
{
    NSString *textToShare = [NSString stringWithFormat:@"%@",@"分享网站"];
    UIImage *imageToShare = [UIImage imageNamed:@"AppIcon"];
    
    //分享的url
    NSURL *urlToShare = [NSURL URLWithString:_searchBar.text];
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare,imageToShare,urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //        activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            
        } else  {
            NSLog(@"cancled");
            
        }
    };
}
- (void)handleWebView
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"视频云解析" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [AVPlayerItem startHook];
//        [SVProgressHUD showWithStatus:@"正在解析视频链接，请稍等"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            //            if ([[AvplayItemManger getInstance] getAVItemIsHook] == YES) {
//            //                [SVProgressHUD showErrorWithStatus:@"视频链接解析失败"];
//            //                [AVPlayerItem stopHook];
//            //            }
//        });
//    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"添加书签" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         OnlineMarkModel *model = [OnlineMarkModel findFirstByCriteria:[NSString stringWithFormat:@"WHERE name = '%@'",self.markTitleStr]];
        if (model.name.length) {
            model.name = self.markTitleStr?self.markTitleStr:@"百度";
                 model.urlStr = self.markUrl?self.markUrl:@"www.baidu.com";
                 model.imgStr = @"百度";
                 [model save];
                 [self getLoadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"该标签已存在"];
        }
     
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)reloadButtonPush {
    
    [self.webView reload];
}

- (void)stopButtonPush {
    
    if (self.webView.loading)
    {
        [self.webView stopLoading];
    }
}
- (void)createWebBgVoew
{
    _webBgView = [[UIView alloc] initWithFrame:self.view.bounds];
    _webBgView.backgroundColor = [UIColor whiteColor];
    _webBgView.hidden = YES;
    [self.view addSubview:_webBgView];
    [_webBgView addSubview:self.webView];
    _progressLine = [[WebviewProgressLine alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+18, KScreenWidth, 2)];
    _progressLine.lineColor = ASOColorTheme;
    [_webBgView addSubview:self.progressLine];
    [_webView bringSubviewToFront:_progressLine];
    
}
- (void)initSubViews
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    bgImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"播放历史";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(NAVIGATION_BAR_HEIGHT+20);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = APPGrayColor;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(titleLabel.mas_bottom);
    }];
    
    [self.view addSubview:self.historyTableView];
    [self.historyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(line);
        make.top.equalTo(line.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
    }];
    
}
- (void)d_playClick {
    if (self.urlTextField.text.length > 0) {
        if (![self.dataArray containsObject:self.urlTextField.text]) {
            [UNHistoryManager historyAdd:self.urlTextField.text];
            [self.dataArray addObject:self.urlTextField.text];
        }
        [self.historyTableView reloadData];
        //跳转到播放器
        AVPlayerViewController *playVC = [[AVPlayerViewController alloc] init];
        playVC.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.urlTextField.text]];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
        [self presentViewController:playVC animated:YES completion:^{
            
        }];
        [playVC.player play];
    } else {
        [SVProgressHUD showErrorWithStatus:@"链接不能为空"];
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self d_playClick];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UNHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UNHistoryTableViewCell" forIndexPath:indexPath];
    NSString *url = self.dataArray[indexPath.row];
    cell.urlLabel.text = url;
    WEAKSELF
    
    //删除事件
    [cell setDelBlock:^{
        [UNHistoryManager historyDel:url];
        [weakSelf.dataArray removeObject:url];
        [weakSelf.historyTableView reloadData];
        
    }];
    
    //点击收藏按钮事件
    [cell setFaverateBlock:^{
        
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = self.dataArray[indexPath.row];
    self.urlTextField.text = url;
    //跳转到播放器
    AVPlayerViewController *playVC = [[AVPlayerViewController alloc] init];
    playVC.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:url]];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
    [self presentViewController:playVC animated:YES completion:^{
        
    }];
    [playVC.player play];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:[UNHistoryManager getAllHistory]];
    }
    return _dataArray;
}

- (UITextField *)urlTextField {
    
    if (!_urlTextField) {
        _urlTextField = [[UITextField alloc] init];
        _urlTextField.font=[UIFont systemFontOfSize:14];
        _urlTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _urlTextField.placeholder =@"请输入链接";
        _urlTextField.delegate = self;
        _urlTextField.returnKeyType = UIReturnKeySearch;
    }
    return _urlTextField;
}

- (UITableView *)historyTableView {
    if (!_historyTableView) {
        _historyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _historyTableView.delegate = self;
        _historyTableView.dataSource = self;
        _historyTableView.backgroundColor = [UIColor clearColor];
        [_historyTableView registerNib:[UINib nibWithNibName:@"UNHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"UNHistoryTableViewCell"];
        _historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _historyTableView;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [AVPlayerItem stopHook];
}
@end
