//
//  FileManageViewController.h
//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "DJP_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UNMainFileManageViewController : DJP_BaseViewController
@property (nonatomic ,strong) UIBarButtonItem *selectAllBtn;

@property (nonatomic ,assign) BOOL isSelectAll;

@property (nonatomic ,strong) NSString *sourcePath;

@property (nonatomic ,strong) NSString *fileTitle;

@property (nonatomic, strong) UISearchBar *searchBar;

- (instancetype)initWithFile:(NSString*)path fileName: (NSString*)name;

- (void)enterFolder: (NSString*)path fileName: (NSString*)name;
@end

NS_ASSUME_NONNULL_END
