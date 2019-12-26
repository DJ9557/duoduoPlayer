//
//  AvplayItemManger.h
//  UncompressTeam
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AvplayItemManger : NSObject
+ (AvplayItemManger *) getInstance;

- (BOOL)getAVItemIsHook;
- (void)AVItemStartHook;
- (void)AVItemStopHook;
@end

NS_ASSUME_NONNULL_END
