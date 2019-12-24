//
//  DJPayViewController.m
//  UncompressTeam
//
//  Created by mac on 2019/12/24.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "DJPayViewController.h"
#import "payTopTableViewCell.h"
#import "DJer_PaySection2TableVCell.h"
#import "PayHelp.h"
@interface DJPayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *imgArr;
@property (nonatomic ,strong) NSArray *titleArr;
@property (nonatomic ,strong) UIView *headView;
@end

@implementation DJPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paybg"]];
    [self createNav];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: YES];
    self.navigationController.navigationBar.hidden = NO;
    
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headView;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"payTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"payTopTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"DJer_PaySection2TableVCell" bundle:nil] forCellReuseIdentifier:@"DJer_PaySection2TableVCell"];
    }
    return _tableView;
}
- (void)createNav
{
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.frame = CGRectMake(15, 35, 35, 35);
    [navBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [navBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navBtn];
    UIButton *huifuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    huifuBtn.frame = CGRectMake(KScreenWidth-75, 35, 60, 30);
    [huifuBtn setImage:[UIImage imageNamed:@"huifu"] forState:UIControlStateNormal];
    [huifuBtn addTarget:self action:@selector(rePay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:huifuBtn];
    [self.view bringSubviewToFront:navBtn];
    [self.view bringSubviewToFront:huifuBtn];
}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rePay
{
    [[PayHelp sharePayHelp] restorePurchase];
}
-(UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 120)];
    }
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 40, SCREEN_Width-90,60)];
    headImgView.contentMode = UIViewContentModeScaleAspectFit;
    headImgView.image = [UIImage imageNamed:@"payTitle"];
    [_headView addSubview:headImgView];
    return _headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 300;
    }
    else
    {
        return 420;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
    }
    else if (indexPath.row == 1)
    {
        
    }
    else if (indexPath.row == 2)
    {
        
    }
    else if (indexPath.row == 3)
    {
        
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        payTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payTopTableViewCell" forIndexPath:indexPath];
        cell.imgView.image = [UIImage imageNamed:@"payfuction"];
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
    else if (indexPath.row == 1)
    {
        DJer_PaySection2TableVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DJer_PaySection2TableVCell"];
        cell.backgroundColor = [UIColor clearColor];
        [cell setPPVideo_monthBlock:^{
            [[PayHelp sharePayHelp] applePayWithProductId:@"com.wuyou.video1"];
        }];
        [cell setPPVideo_seasonBlock:^{
            [[PayHelp sharePayHelp] applePayWithProductId:@"com.wuyou.video3"];
        }];
        [cell setPPVideo_yearBlock:^{
            [[PayHelp sharePayHelp] applePayWithProductId:@"com.wuyou.video12"];
        }];
        return cell;
    }
    else
    {
        return nil;
    }
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
