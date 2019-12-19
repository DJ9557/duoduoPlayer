//
//  VideoManager.h
//  PrettyPatPlayerPlayer
//
//  Created by MAC on 2019/12/9.
//  Copyright © 2019 PPVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h> //音视频库
#import <AudioToolbox/AudioToolbox.h> //音视频处理

NS_ASSUME_NONNULL_BEGIN

typedef void (^ReturnTextBlock)(NSString *showText);//给block重命名,方便调用

typedef void (^ReturnVideoPath)(NSString *newPath);

@interface PPVideo_VideoManager : NSObject

/**
*  获取视频的缩略图方法
*
*  @param filePath 视频的本地路径
*
*  @return 视频截图
*/
+ (UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath;

/**
*  获取视频中的音频
*
*  @param videoUrl 视频的本地路径
*  @param newFile 导出音频的路径
*  @completionHandle 音频路径的回调
*/
+ (void)VideoManagerGetBackgroundMiusicWithVideoUrl:(NSURL *)videoUrl newFile:(NSString*)newFile completion:(void(^)(NSString *data))completionHandle;

/*
 *  获取视频播放时长
 *  @param urlString 视频路径
 */
+ (NSInteger)getVideoTimeByUrlString:(NSString*)urlString;

/*
*  获取视频某一秒第一帧图片
*  @param videoURL 视频路径
*  @param time 时间
*/
+ (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;


+ (void)reverseVideo:(NSString *)oldPath newPath:(NSString *)newPath reversePross:(ReturnVideoPath)rever;

/*
获取音频文件播放时长
name：音频名称
*/
+ (NSString *)durationWithVideo:(NSString *)name;
+ (NSString *)timpDurationVideo:(NSString *)name;
+ (double)AudioDuration:(NSString *)name;

/*
 删除单个音频
 nameStr:要删除的文件名称（不是文件路径）
 stateStr:如果文件不存在返回“已删除”，存在则删除文件并告诉用户“文件删除”
 */
+(void)DeletFileName:(NSString *)nameStr Returnstate:(ReturnTextBlock)stateStr;

//重命名
+(void)getOldName:(NSString *)oldName newName:(NSString *)newName SF:(void(^)(NSString*data))comp;

+(void)createNewFile;

/*
读取音频列表
*/
+(NSArray *)readTheDirectory;

@end

NS_ASSUME_NONNULL_END
