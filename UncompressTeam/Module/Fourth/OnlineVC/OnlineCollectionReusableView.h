//
//  OnlineCollectionReusableView.h
//  UncompressTeam
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^interBlock)();

NS_ASSUME_NONNULL_BEGIN
@interface OnlineCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *interBtn;
@property (nonatomic ,copy) interBlock interDownBlock;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

NS_ASSUME_NONNULL_END
