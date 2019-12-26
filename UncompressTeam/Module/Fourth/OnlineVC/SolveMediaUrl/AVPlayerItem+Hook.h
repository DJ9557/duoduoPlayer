//
//  AVPlayerItem+Hook.h
//  PrettyPatPlayerPlayer
//
//  Created by mac on 2019/12/13.
//  Copyright © 2019 PPVideo. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVPlayerItem (Hook)
//@property (nonatomic ,assign) BOOL enableHook;
+(void)startHook;
+(void)stopHook;
@end

NS_ASSUME_NONNULL_END
