//
//  DTOSettingViewController.m
//  DuoTotalPlayer
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 DJ. All rights reserved.
//

#import "DJP_SettingViewController.h"
#import "DJP_AdviceViewController.h"
#import "DJP_AboutUsViewController.h"
#import <MessageUI/MessageUI.h>
#import "SetTableViewCell.h"
#import "DJPayViewController.h"
@interface DJP_SettingViewController ()<MFMailComposeViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *imgArr;
@property (nonatomic ,strong) NSArray *titleArr;
@property (nonatomic ,strong) UIView *headView;
@end

@implementation DJP_SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self.view addSubview:self.tableView];
    [self setLoadData];
}
-(void)setLoadData
{
    self.imgArr = @[@"清理缓存备份 2",@"意见反馈备份",@"关于我们备份",@"vip备份"];
    self.titleArr = @[@"清理缓存",@"意见反馈",@"关于我们",@"升级VIP"];
    [self.tableView reloadData];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"SetTableViewCell" bundle:nil] forCellReuseIdentifier:@"SetTableViewCell"];
    }
    return _tableView;
}
-(UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 220)];
    }
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width,220)];
    headImgView.contentMode = UIViewContentModeScaleAspectFit;
    headImgView.image = [UIImage imageNamed:@"banner备份"];
    [_headView addSubview:headImgView];
    return _headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self delete];
    }
    else if (indexPath.row == 1)
    {
        [self advice];
    }
    else if (indexPath.row == 2)
    {
        [self aboutUs];
    }
    else if (indexPath.row == 3)
    {
        [self pushPayVC];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetTableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArr[indexPath.row];
    cell.imgView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    if (indexPath.row == 0) {
        cell.interImgView.image = [UIImage imageNamed:@"清理缓存"];
    }
    return cell;
}
-(void)delete
{
    [SVProgressHUD showWithStatus:@"清除缓存……"];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0  inSection:0];
    SetTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    [self shakeView:cell.interImgView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"清除成功"];
        [SVProgressHUD dismiss];
    });
}
#pragma mark 抖动
- (void)shakeView:(UIView*)viewToShake
{
    CGFloat t =4.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    viewToShake.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}
-(void)advice
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你使用过程遇到什么问题或有改进的地方，可以发邮件告诉我，谢谢。" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"写邮件" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString *mailUrl = [[NSMutableString alloc] init];
        [mailUrl appendFormat:@"mailto:%@?", @"951891012@qq.com"];
        NSString *emailPath = [mailUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailPath]options:nil completionHandler:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

-(void)aboutUs
{
    DJP_AboutUsViewController *about = [[DJP_AboutUsViewController alloc] init];
    [self.navigationController pushViewController:about animated:YES];
}
-(void)pushPayVC
{
    DJPayViewController *pay = [[DJPayViewController alloc] init];
    pay.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.navigationController presentViewController:pay animated:YES completion:nil];
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
