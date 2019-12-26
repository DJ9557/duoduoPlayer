//
//  OnlineMarkModel.h
//  UncompressTeam
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "JKDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OnlineMarkModel : JKDBModel
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *urlStr;
@property (nonatomic ,copy) NSString *imgStr;

+(NSArray*)configData;

@end

NS_ASSUME_NONNULL_END
