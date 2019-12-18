//
//  HistoryManager.m
//  GQAllPlayer
//
//  Created by MAC on 09/12/2019.
//  Copyright © 2019 DJ. All rights reserved.
//

#import "UNHistoryManager.h"

@implementation UNHistoryManager

+ (void)historyAdd:(NSString *)palyUrl
{
    NSMutableArray *histotyAll = [NSMutableArray arrayWithArray:[UNHistoryManager getAllHistory]];
    if ([histotyAll containsObject:palyUrl]) {
    } else {
        [histotyAll addObject:palyUrl];
        NSString *key = @"WatchMovieOnline_Url_History";
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:histotyAll];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)historyDel:(NSString *)palyUrl {
    NSMutableArray *histotyAll = [NSMutableArray arrayWithArray:[UNHistoryManager getAllHistory]];
    if ([histotyAll containsObject:palyUrl]) {
        [histotyAll removeObject:palyUrl];
        NSString *key = @"WatchMovieOnline_Url_History";
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:histotyAll];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        
    }
}
+ (NSArray *)getAllHistory{
    NSString *key = @"WatchMovieOnline_Url_History";
    NSArray *histotyAll = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    if (histotyAll) {
        return histotyAll;
    }
    return nil;
}

@end
