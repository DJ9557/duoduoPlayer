//
//  SMBManager.m
//  UncompressTeam
//
//  Created by MAC on 28/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "DJP_SMBManager.h"

@implementation DJP_SMBManager

static DJP_SMBManager *_manager;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    
    return _manager;
}

@end
