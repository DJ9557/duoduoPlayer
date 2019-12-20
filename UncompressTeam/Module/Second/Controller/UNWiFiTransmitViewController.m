//
//  FAPWiFiTransmitViewController.m
//  UncompressTeam
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "UNWiFiTransmitViewController.h"
#import "WiFiTransmitTableViewCell.h"
#import "TitleSwitchTableViewCell.h"
#import "GCDWebUploader.h"
#import "GCDWebServerDataResponse.h"
//#import <HTTPServer.h>
//#import "UNHmHTTPConnection.h"
//#import "UNHmTool.h"
@interface UNWiFiTransmitViewController ()<UITableViewDelegate, UITableViewDataSource,GCDWebUploaderDelegate>
{
    GCDWebUploader *_webServer;
}
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy) NSString *urlString;

@end

@implementation UNWiFiTransmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"WiFi传输";
     [self startWebServer];
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = 80;
        [self.view addSubview:tableView];
        tableView;
    });
    [_myTableView registerNib:[UINib nibWithNibName:@"WiFiTransmitTableViewCell" bundle:nil] forCellReuseIdentifier:@"WiFiTransmitTableViewCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"TitleSwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"TitleSwitchTableViewCell"];
    [_myTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"HEADER"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HEADER"];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return 120;
    } else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ) {
        TitleSwitchTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"TitleSwitchTableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"如需Wi-Fi共享服务，请打开开关。";
        cell.mySwith.hidden = YES;
        return cell;
    } else if (indexPath.row == 1) {
        TitleSwitchTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"TitleSwitchTableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"开启";
        [cell.mySwith addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
        cell.mySwith.hidden = NO;
        cell.mySwith.on = self.isOpen;
        return cell;
    } else if (indexPath.row == 2) {
        WiFiTransmitTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"WiFiTransmitTableViewCell" forIndexPath:indexPath];
        if (self.isOpen) {
            cell.titleLabel.text = self.urlString;
            cell.titleLabel.textColor = ASOColorTheme;
            cell.contentLabel.text = @"已经开启Wi-Fi共享传输，请在电脑的浏览器打开以上地址即可与多多播放器共享文件，点击可拷贝地址,离开此页面自动停止共享服务";
        } else {
            cell.titleLabel.text = @"传输已关闭";
            cell.contentLabel.text = @"";
        }
        cell.bottomLine.hidden = YES;
        return cell;
    }
    return nil;
}

- (void)valueChanged:(UISwitch *)mySwitch {
//    if ([[PayHelp sharePayHelp] isApplePay]) {
        if (mySwitch.on) {
            self.isOpen = YES;

        } else {
            self.isOpen = NO;
            
        }
        [_myTableView reloadData];
//    } else {
//        self.isOpen = NO;
//        [_myTableView reloadData];
//        PayViewController *pay = [[PayViewController alloc] init];
//        pay.modalPresentationStyle = UIModalPresentationFullScreen;
//        [self presentViewController:pay animated:YES completion:^{
//
//        }];
//    }
    
}
 - (void)viewDidDisappear:(BOOL)animated
 {
     [super viewDidDisappear:animated];
     
     [_webServer stop];
 }
#pragma mark - Inner Methods

- (void)startWebServer
{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _webServer = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
    _webServer.delegate = self;
    _webServer.allowHiddenItems = YES;
    _webServer.title = @"页面标题";
    _webServer.header = @"多多播放器";
    [_webServer start];
}

#pragma mark - GCDWebUploaderDelegate
/**
 *  Delegate methods for GCDWebUploader.
 *
 *  @warning These methods are always called on the main thread in a serialized way.
 */
- (void)webUploader:(GCDWebUploader *)uploader didDownloadFileAtPath:(NSString *)path
{
    
}

/**
 *  This method is called whenever a file has been uploaded.
 */
- (void)webUploader:(GCDWebUploader *)uploader didUploadFileAtPath:(NSString *)path
{
    NSLog(@"didUploadFileAtPath: %@", path);
}

/**
 *  This method is called whenever a file or directory has been moved.
 */
- (void)webUploader:(GCDWebUploader *)uploader didMoveItemFromPath:(NSString *)fromPath toPath:(NSString *)toPath
{
    
}

/**
 *  This method is called whenever a file or directory has been deleted.
 */
- (void)webUploader:(GCDWebUploader *)uploader didDeleteItemAtPath:(NSString *)path
{
    
}

/**
 *  This method is called whenever a directory has been created.
 */
- (void)webUploader:(GCDWebUploader *)uploader didCreateDirectoryAtPath:(NSString *)path
{
    
}

#pragma mark - GCDWebServerDelegate
/**
 *  This method is called after the server has successfully started.
 */
- (void)webServerDidStart:(GCDWebServer *)server
{
    NSLog(@"\n\nServerURL: %@\n\n", [[server serverURL] absoluteString]);
}

/**
 *  This method is called after the Bonjour registration for the server has
 *  successfully completed.
 */
- (void)webServerDidCompleteBonjourRegistration:(GCDWebServer *)server
{
    NSLog(@"\n\nBonjourURL: %@\n\n", server.bonjourServerURL);
    self.urlString = [server.bonjourServerURL absoluteString];
    [_myTableView reloadData];
    // web 地址 自动拷贝到粘贴板 方便用户在浏览器内输入
}

/**
 *  This method is called when the first GCDWebServerConnection is opened by the
 *  server to serve a series of HTTP requests.
 *
 *  A series of HTTP requests is considered ongoing as long as new HTTP requests
 *  keep coming (and new GCDWebServerConnection instances keep being opened),
 *  until before the last HTTP request has been responded to (and the
 *  corresponding last GCDWebServerConnection closed).
 */
- (void)webServerDidConnect:(GCDWebServer *)server
{
    
}

/**
 *  This method is called when the last GCDWebServerConnection is closed after
 *  the server has served a series of HTTP requests.
 *
 *  The GCDWebServerOption_ConnectedStateCoalescingInterval option can be used
 *  to have the server wait some extra delay before considering that the series
 *  of HTTP requests has ended (in case there some latency between consecutive
 *  requests). This effectively coalesces the calls to -webServerDidConnect:
 *  and -webServerDidDisconnect:.
 */
- (void)webServerDidDisconnect:(GCDWebServer *)server
{
    
}

/**
 *  This method is called after the server has stopped.
 */
- (void)webServerDidStop:(GCDWebServer *)server
{
    
}
@end
