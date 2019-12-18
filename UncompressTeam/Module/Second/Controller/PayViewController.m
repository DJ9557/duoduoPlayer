//
//  PayViewController.m
//  UncompressTeam
//
//  Created by MAC on 29/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *payBtn;
@property (nonatomic ,strong) UIButton *repayBtn;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pay_bg_image"]];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.repayBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(23, 23));
        make.left.equalTo(bgImageView.mas_left).offset(20);
        make.top.equalTo(bgImageView.mas_top).offset(40);
    }];
  
    [self.view addSubview:self.payBtn];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).offset(40);
        make.right.equalTo(bgImageView.mas_right).offset(-40);
        make.bottom.equalTo(bgImageView.mas_bottom).offset(-50);
        make.height.mas_equalTo(44);
    }];
    [self.repayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(self.payBtn.mas_bottom).offset(5);
          make.size.mas_equalTo(CGSizeMake(80, 25));
        make.centerX.equalTo(self.payBtn.mas_centerX);
      }];
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
        _closeBtn.adjustsImageWhenHighlighted = NO;
        [_closeBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
-(UIButton *)repayBtn
{
    if (!_repayBtn) {
        _repayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_repayBtn setTitle:@"恢复购买" forState:UIControlStateNormal];
        [_repayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _repayBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_repayBtn addTarget:self action:@selector(repayDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _repayBtn;
}

- (void)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_payBtn setBackgroundImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payBtn setTitle:@"￥60 购买一次，永久免费" forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

- (void)buyClick {
    if ([[PayHelp sharePayHelp] isApplePay]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已购买过专业版，无需重复购买。" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    [[PayHelp sharePayHelp] applePayWithProductId:@""];
}
-(void)repayDown
{
    [[PayHelp sharePayHelp] restorePurchase];
}
@end
