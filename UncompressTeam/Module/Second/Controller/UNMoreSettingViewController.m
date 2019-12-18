//
//  SecondViewController.m
//  LDDVideoPro
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "UNMoreSettingViewController.h"
#import "UNiTunesDownloadViewController.h"
#import "UNWiFiTransmitViewController.h"
#import "UNiCloudManager.h"
#import "ImageTitleTableViewCell.h"
#import "UNSMBViewController.h"
#import "SecondHeaderView.h"
#import "UNWatchMovieOnlineViewController.h"
#import "UNSettingViewController.h"
@interface UNMoreSettingViewController ()<UITableViewDelegate, UITableViewDataSource,UIDocumentPickerDelegate>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,copy) NSArray *nameArray;
@property (nonatomic ,strong) NSArray *imgArr;
@end

@implementation UNMoreSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更多功能";
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = 60;
        [self.view addSubview:tableView];
        tableView;
    });
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.bottom.equalTo(self.view);
    }];
    [_myTableView registerNib:[UINib nibWithNibName:@"ImageTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImageTitleTableViewCell"];
     [_myTableView registerClass:[SecondHeaderView class] forHeaderFooterViewReuseIdentifier:@"HEADER"];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.nameArray.count;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SecondHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HEADER"];
    if (section == 0) {
        header.timeLabel.text = @"传输";
    } else {
        header.timeLabel.text = @"设置";
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ImageTitleTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"ImageTitleTableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = self.nameArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
        return cell;
    } else {
        ImageTitleTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"ImageTitleTableViewCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"专业版";
            cell.imageView.image = [UIImage imageNamed:@"goumai"];
        } else {
            cell.titleLabel.text = @"设置";
            cell.imageView.image = [UIImage imageNamed:@"set"];
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
                case 0:
                {
                    UNWiFiTransmitViewController *wifi = [[UNWiFiTransmitViewController alloc] init];
                    wifi.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:wifi animated:YES];
                }
                    break;
                case 1:
                {
                    UNiTunesDownloadViewController *itunes = [[UNiTunesDownloadViewController alloc] init];
                    itunes.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:itunes animated:YES];
                }
                    break;
                case 2:
                {
                    UNWatchMovieOnlineViewController *online = [[UNWatchMovieOnlineViewController alloc] init];
                    online.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:online animated:YES];
                }
                    break;
                case 3:
                {
                   UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.data"]
                                                                                                                                  inMode:UIDocumentPickerModeImport];
                          documentPicker.delegate = self;

                    documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
                    [self presentViewController:documentPicker animated:YES completion:nil];
                }
                    break;
                case 4:
                {
                    UNSMBViewController *smb = [[UNSMBViewController alloc] init];
                    smb.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:smb animated:YES];
                }
                    break;

                    
                default:
                    break;
            }
    } else {
        if (indexPath.row == 0) { //购买
            PayViewController *pay = [[PayViewController alloc] init];
            pay.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:pay animated:YES completion:^{
                
            }];
        } else {//恢复购买
            UNSettingViewController *set = [[UNSettingViewController alloc] init];
            [self.navigationController pushViewController:set animated:YES];
        }
    }
    
}

#pragma mark - iCloud files
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        //  NSString *alertMessage = [NSString stringWithFormat:@"Successfully imported %@", [url lastPathComponent]];
        //do stuff
        NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
        NSString *fileName = [array lastObject];
        fileName = [fileName stringByRemovingPercentEncoding];
//        if ([iCloudManager iCloudEnable]) {
            [UNiCloudManager downloadWithDocumentURL:url callBack:^(id obj) {
                NSData *data = obj;
                
                //写入沙盒Documents
                 NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",fileName]];
                [data writeToFile:path atomically:YES];
                [SVProgressHUD showSuccessWithStatus:@"下载成功，请前往首页查看"];
            }];
//        }
    }
    
}

- (NSArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [NSArray arrayWithObjects:@"WiFi传输",@"iTunes传输",@"在线观看",@"文件/iCloud Driver",@"SMB", nil];
    }
    return _nameArray;
}
-(NSArray *)imgArr
{
    if (!_imgArr) {
        _imgArr = [NSArray arrayWithObjects:@"wifi传输",@"iTunes传输",@"在线观看",@"文件",@"SMB", nil];
    }
    return _imgArr;
}
@end
