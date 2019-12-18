//
//  HmTool.h
//  LDDVideoPro
//
//  Created by MAC on 15/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UNHmTool : NSObject

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (BOOL)isValidatIP:(NSString *)ipAddress;

+ (NSDictionary *)getIPAddresses;

@end

NS_ASSUME_NONNULL_END
