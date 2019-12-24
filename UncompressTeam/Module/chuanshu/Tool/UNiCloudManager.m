//
//  iCloudManager.m
//  UncompressTeam
//
//  Created by MAC on 27/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "UNiCloudManager.h"
#import "DJP_Document.h"
@implementation UNiCloudManager

+ (BOOL)iCloudEnable {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSURL *url = [manager URLForUbiquityContainerIdentifier:nil];

    if (url != nil) {
        return YES;
    }
    
    NSLog(@"iCloud 不可用");
    return NO;
}

+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block {
    
    DJP_Document *iCloudDoc = [[DJP_Document alloc]initWithFileURL:url];
    
    [iCloudDoc openWithCompletionHandler:^(BOOL success) {
        if (success) {
            
            [iCloudDoc closeWithCompletionHandler:^(BOOL success) {
                NSLog(@"关闭成功");
            }];
            
            if (block) {
                block(iCloudDoc.data);
            }
            
        }
    }];
}

@end
