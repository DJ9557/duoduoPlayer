//
//  AvplayItemManger.m
//  UncompressTeam
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "AvplayItemManger.h"

@implementation AvplayItemManger
#define AVHook @"avHook"

static AvplayItemManger *instance = nil;
+(AvplayItemManger *) getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
        instance = [[self alloc]init];
                  });
    return instance;
}
-(BOOL)getAVItemIsHook
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:AVHook] boolValue];
}
-(void)AVItemStartHook
{
     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:AVHook];
}
-(void)AVItemStopHook
{
 [[NSUserDefaults standardUserDefaults] setBool:NO forKey:AVHook];
}
@end
