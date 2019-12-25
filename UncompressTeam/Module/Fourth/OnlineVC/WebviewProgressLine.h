//
//  WebviewProgressLine.h
//  UncompressTeam
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebviewProgressLine : UIView
//进度条颜色
@property (nonatomic,strong) UIColor  *lineColor;

//开始加载
-(void)startLoadingAnimation;

//结束加载
-(void)endLoadingAnimation;
@end

NS_ASSUME_NONNULL_END
