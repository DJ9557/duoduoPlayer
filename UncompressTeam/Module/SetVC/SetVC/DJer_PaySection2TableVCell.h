//
//  PaySection2TableViewCell.h
//  PrettyPatPlayerPlayer
//
//  Created by MAC on 09/12/2019.
//  Copyright © 2019 PPVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^payBlock)(void);
@interface DJer_PaySection2TableVCell : UITableViewCell
@property(nonatomic,copy)payBlock PPVideo_yearBlock;
@property(nonatomic,copy)payBlock PPVideo_monthBlock;
@property (weak, nonatomic) IBOutlet UIButton *lijiPayBtn;
@property(nonatomic,copy)payBlock PPVideo_seasonBlock;
@end

NS_ASSUME_NONNULL_END
