//
//  DataModel.h
//  File Master
//
//  Created by wyx on 2018/5/25.
//  Copyright © 2018年 wyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJP_DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataSource;

- (instancetype)initWithPath:(NSString*)path;

@end
