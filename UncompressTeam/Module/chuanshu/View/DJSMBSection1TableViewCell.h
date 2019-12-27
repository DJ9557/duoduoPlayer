//
//  SMBSection1TableViewCell.h
//  UncompressTeam
//
//  Created by MAC on 28/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJSMBSection1TableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *bottomLine;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end

NS_ASSUME_NONNULL_END
