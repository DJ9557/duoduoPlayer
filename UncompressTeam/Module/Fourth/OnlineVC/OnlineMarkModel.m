//
//  OnlineMarkModel.m
//  UncompressTeam
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "OnlineMarkModel.h"

@implementation OnlineMarkModel
+(NSArray *)configData
{
    NSArray *arr = @[
        @{
            @"name":@"新手教程",
            @"urlStr":@"https://www.jianshu.com/p/933a40f9f9fb",
            @"imgStr":@"新手教程",
        },
        @{
            @"name":@"百度",
            @"urlStr":@"https://www.baidu.com",
            @"imgStr":@"百度",
        },
        
        @{
            @"name":@"YouTube",
            @"urlStr":@"https://www.youtube.com",
            @"imgStr":@"YouTube",
        },
        @{
            @"name":@"哔哩哔哩",
            @"urlStr":@"https://www.bilibili.com",
            @"imgStr":@"bilibili",
        },
        @{
            @"name":@"六间房",
            @"urlStr":@"https://www.6.cn/?mks=cpcbaidu&mkk=六间房&mkc=g0007",
            @"imgStr":@"六间房",
        },
        @{
            @"name":@"梨视频",
            @"urlStr":@"https://www.pearvideo.com/category_5",
            @"imgStr":@"梨视频",
        },
    ];
    return arr;
}
@end
