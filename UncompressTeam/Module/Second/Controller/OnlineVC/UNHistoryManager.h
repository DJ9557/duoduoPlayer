//
//  HistoryManager.h
//  GQAllPlayer
//
//  Created by MAC on 09/12/2019.
//  Copyright © 2019 DJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UNHistoryManager : NSObject
+ (void)historyAdd:(NSString *)palyUrl;
+ (void)historyDel:(NSString *)palyUrl;
+ (NSArray *)getAllHistory;
@end

NS_ASSUME_NONNULL_END
