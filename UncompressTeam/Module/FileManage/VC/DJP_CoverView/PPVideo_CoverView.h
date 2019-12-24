//
//  TTIICoverView.h
//  PrettyPatPlayerPlayer
//
//  Created by MAC on 2019/12/9.
//  Copyright © 2019 PPVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^didSelectIndex)(NSInteger);

NS_ASSUME_NONNULL_BEGIN

@interface PPVideo_CoverView : UIView

@property (nonatomic, strong) NSMutableArray *PPVideo_imagesArr;

@property (nonatomic, strong) NSMutableArray *PPVideo_labelArr;

@property (nonatomic, copy) didSelectIndex PPVideo_jump;

@property (nonatomic, assign) BOOL PPVideo_inLeft;

@end

NS_ASSUME_NONNULL_END
