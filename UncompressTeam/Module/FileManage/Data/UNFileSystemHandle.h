//
//  FileSystemHandle.h
//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNFileCollectionViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface UNFileSystemHandle : NSObject


+(void)fileHandleAlertShowFileName:(NSString*)fileName FilePath:(NSString *)path collectionVC:(UNFileCollectionViewController*)collVC withVC:(UIViewController*)vc;

+(void)addActionShowViewFilePath:(NSString *)path collectionVC:(UNFileCollectionViewController*)collVC withVC:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
