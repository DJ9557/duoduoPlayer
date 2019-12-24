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

#define WEAKSELF                    typeof(self) __weak weakSelf=self;

@interface UNWatchMovieOnlineViewController ()<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITextField *urlTextField;
@property (nonatomic, strong)UITableView *historyTableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation UNWatchMovieOnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"在线观看";
    self.view.backgroundColor = [UIColor colorWithHexString:@"F8F8F8"];
    [self initSubViews];
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
      
      UIView *whiteView = [[UIView alloc] init];
      whiteView.backgroundColor = [UIColor whiteColor];
      whiteView.layer.cornerRadius = 20;
      whiteView.layer.masksToBounds = YES;
      [self.view addSubview:whiteView];
      [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.view.mas_left).offset(20);
          make.right.equalTo(self.view.mas_right).offset(-100);
          make.top.equalTo(self.view.mas_top).offset(25+NAVIGATION_BAR_HEIGHT);
          make.height.mas_equalTo(40);
      }];
      
      [self.view addSubview:self.urlTextField];
      [self.urlTextField mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.bottom.equalTo(whiteView);
          make.left.equalTo(whiteView.mas_left).offset(5);
          make.right.equalTo(whiteView.mas_right).offset(-5);
      }];
      
      UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [playButton setBackgroundImage:[UIImage imageNamed:@"history_watch"] forState:UIControlStateNormal];
      //    [playButton setTitle:@"搜索" forState:UIControlStateNormal];
      [playButton addTarget:self action:@selector(d_playClick) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:playButton];
      [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.equalTo(whiteView.mas_centerY);
          make.right.equalTo(self.view.mas_right).offset(-20);
          make.size.mas_equalTo(CGSizeMake(184/3, 100/3));
      }];
      
      UILabel *titleLabel = [[UILabel alloc] init];
      titleLabel.text = @"播放历史";
      titleLabel.font = [UIFont systemFontOfSize:14];
      [self.view addSubview:titleLabel];
      [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.view.mas_left).offset(10);
          make.top.equalTo(whiteView.mas_bottom).offset(20);
          make.size.mas_equalTo(CGSizeMake(100, 30));
      }];
      UIView *line = [[UIView alloc] init];
      line.backgroundColor = [UIColor colorWithHexString:@"999999"];
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

@end
