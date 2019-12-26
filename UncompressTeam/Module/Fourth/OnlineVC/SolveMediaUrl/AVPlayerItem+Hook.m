//
//  AVPlayerItem+Hook.m
//  PrettyPatPlayerPlayer
//
//  Created by mac on 2019/12/13.
//  Copyright © 2019 PPVideo. All rights reserved.
//

#import "AVPlayerItem+Hook.h"
#import "NSObject+MethodSwizzle.h"
#import "AvplayItemManger.h"

@implementation AVPlayerItem (Hook)
+(void)load
{
    [self PPVideo_swizzleMethod:@selector(initWithAsset:automaticallyLoadedAssetKeys:) withMethod:@selector(DJ_initWithAsset:automaticallyLoadedAssetKeys:)];
}

+(void)startHook
{
    [[AvplayItemManger getInstance] AVItemStartHook];
}
+(void)stopHook
{
   [[AvplayItemManger getInstance] AVItemStopHook];

}
-(instancetype)DJ_initWithAsset:(AVAsset *)asset automaticallyLoadedAssetKeys:(NSArray<NSString *> *)automaticallyLoadedAssetKeys
{
    if ([[AvplayItemManger getInstance] getAVItemIsHook]&&[asset isKindOfClass:AVURLAsset.class]) {
        AVURLAsset *urlAssert = (AVURLAsset*)asset;
        NSString *url = urlAssert.URL.absoluteString;
        BOOL isVideo = urlAssert.isCompatibleWithAirPlayVideo;
        NSString *ext = isVideo ? @"mp4":@"mp3";
        NSString *rui = [url componentsSeparatedByString:@"?"].firstObject;
        if (rui.pathExtension.length) {
            ext = @"";
        }
        if (url.length) {
            [AVPlayerItem stopHook];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedPlayMedia" object:@{@"url":url,@"ext":ext}];
        }
        return nil;
    }
    return [self DJ_initWithAsset:asset automaticallyLoadedAssetKeys:automaticallyLoadedAssetKeys];
}
@end
