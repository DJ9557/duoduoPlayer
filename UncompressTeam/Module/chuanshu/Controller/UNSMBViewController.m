//
//  SMBViewController.m
//  UncompressTeam
//
//  Created by MAC on 28/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "UNSMBViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "DJSMBSection0TableViewCell.h"
#import "DJSMBSection1TableViewCell.h"
#import "DJP_SMBManager.h"
#import "UNSMBFileTootListViewController.h"
#import "DJPayViewController.h"

@interface UNSMBViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic, copy) NSArray *nameArray;
@property (nonatomic, copy) NSArray *houlderArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSString *IPAddress;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;

@end

@implementation UNSMBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"SMB";
    self.IPAddress = @"";
    self.userName = @"";
    self.password = @"";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"链接" style:UIBarButtonItemStylePlain target:self action:@selector(dj_rightClick)];
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = 60;
        [self.view addSubview:tableView];
        tableView;
    });
    [_myTableView registerNib:[UINib nibWithNibName:@"DJSMBSection0TableViewCell" bundle:nil] forCellReuseIdentifier:@"DJSMBSection0TableViewCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"DJSMBSection1TableViewCell" bundle:nil] forCellReuseIdentifier:@"DJSMBSection1TableViewCell"];
    [_myTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"HEADER"];
    [self dj_findSMB];
}

- (void)dj_findSMB {
    WEAKSELF
    [[SMBDiscovery sharedInstance] startDiscoveryOfType:SMBDeviceTypeAny added:^(SMBDevice *device) {
        if (![weakSelf.dataArray containsObject:device]) {
            [weakSelf.dataArray addObject:device];
        }
        [weakSelf.myTableView reloadData];
        NSLog(@"Device added: %@", device);
    } removed:^(SMBDevice *device) {
        if ([weakSelf.dataArray containsObject:device]) {
            [weakSelf.dataArray removeObject:device];
        }
        NSLog(@"Device removed: %@", device);
        [weakSelf.myTableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
//        [weakSelf.myTableView reloadData];
    }];
}

- (void)dealloc {
    [[SMBDiscovery sharedInstance] stopDiscovery];
}

- (void)dj_rightClick {
    if ([[PayHelp sharePayHelp] isApplePay]) {
        if (self.IPAddress.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入主机IP"];
            return;
        }
        NSString *host = self.IPAddress;
        WEAKSELF
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        SMBFileServer *fileServer = [[SMBFileServer alloc] initWithHost:host netbiosName:host group:nil];
        [DJP_SMBManager sharedInstance].fileServer = fileServer;
        [fileServer connectAsUser:self.userName password:self.password completion:^(BOOL guest, NSError *error) {
            [SVProgressHUD dismiss];
            if (error) {
                NSLog(@"Unable to connect: %@", error);
                [SVProgressHUD showErrorWithStatus:@"链接失败"];
            } else if (guest) {
                NSLog(@"Logged in as guest");
            } else {
                NSLog(@"Logged in");
                
                UNSMBFileTootListViewController *root = [[UNSMBFileTootListViewController alloc] init];
                [weakSelf.navigationController pushViewController:root animated:YES];
            }
        }];
    } else {
        DJPayViewController *pay = [[DJPayViewController alloc] init];
        pay.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:pay animated:YES completion:^{
            
        }];
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.nameArray.count;
    } else {
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HEADER"];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    } else {
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        DJSMBSection0TableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"DJSMBSection0TableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text =self.nameArray[indexPath.row];
        cell.contentField.placeholder = self.houlderArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.contentField.text = self.IPAddress;
        } else if (indexPath.row == 1) {
            cell.contentField.text = self.userName;
        } else if (indexPath.row == 2) {
            cell.contentField.text = self.password;
        }
        WEAKSELF
        [cell setSuccess:^(NSString * _Nonnull text) {
            if (indexPath.row == 0) {
                weakSelf.IPAddress = text;
            } else if (indexPath.row == 1) {
                weakSelf.userName = text;
            } else if (indexPath.row == 2) {
                weakSelf.password = text;
            }
        }];
        return cell;
    } else if (indexPath.section == 1) {
        DJSMBSection1TableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"DJSMBSection1TableViewCell" forIndexPath:indexPath];
        SMBDevice *device = [self.dataArray objectAtIndex:indexPath.row];
        cell.nameLabel.text = device.netbiosName;
        cell.addressLabel.text = device.host;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        SMBDevice *device = [self.dataArray objectAtIndex:indexPath.row];
        self.IPAddress = device.host;
        if (DEBUG) {
        //        self.IPAddress = @"smb://macdembp-2.lan";
                self.userName = @"share";
                self.password = @"1234";
        } else {
            self.userName = @"";
            self.password = @"";
        }
        
        [self.myTableView reloadData];
    }
}

- (NSArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [NSArray arrayWithObjects:@"主机/IP",@"用户名",@"密码", nil];
    }
    return _nameArray;
}

- (NSArray *)houlderArray {
    if (!_houlderArray) {
        _houlderArray = [NSArray arrayWithObjects:@"必填",@"可选",@"可选", nil];
    }
    return _houlderArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
