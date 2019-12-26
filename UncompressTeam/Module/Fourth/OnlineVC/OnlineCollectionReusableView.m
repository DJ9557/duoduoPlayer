//
//  OnlineCollectionReusableView.m
//  UncompressTeam
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "OnlineCollectionReusableView.h"

@implementation OnlineCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)interDown:(id)sender {
    if (self.interDownBlock) {
        self.interDownBlock();
    }
}

@end
