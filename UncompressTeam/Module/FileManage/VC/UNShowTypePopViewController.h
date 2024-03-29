//
//  ShowTypePopViewController.h
//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UNShowTypePopViewController;

@protocol ShowTypePopViewControllerDelegate<NSObject>

- (void)chooseShowType:(UNShowTypePopViewController*)controller didSelectAtIndex:(int)index btnTag:(int)tag isDirectoryFirst:(BOOL)isDirectoryFirst isDesc:(BOOL)isDesc;

@end

@interface UNShowTypePopViewController : UITableViewController

@property (nonatomic, assign) id<ShowTypePopViewControllerDelegate> delegate;

/**
 *    @brief    根据点击的按钮初始化弹出框
 *    @param     btn (btn.tag = 0:切换视图模式弹出框 btn.tag = 1:排序弹出框)
 *    @param     isDirectoryFirst 是否目录优先
 *    @param     isDesc 是否降序
 *    @param     selectedSortType 选择的排序方式(1:名称 2:大小 3:日期 4:类型)
 */
- (instancetype)initWithPopView:(UIBarButtonItem*)btn isDirectoryFirst:(BOOL)isDirectoryFirst isDesc:(BOOL)isDesc selectedSortType:(NSInteger)selectedSortType;

@end
