//
//  OnlineCollectionCell.h
//  UncompressTeam
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OnlineCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

NS_ASSUME_NONNULL_END
