//
//  VideoManager.m
//  PrettyPatPlayerPlayer
//
//  Created by MAC on 2019/12/9.
//  Copyright © 2019 PPVideo. All rights reserved.
//

#import "DJP_VideoManager.h"

@implementation DJP_VideoManager

+(UIImage *)getThumbnailImage:(NSString *)videoURL
 
{
 
 AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
 
 AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
 
gen.appliesPreferredTrackTransform = YES;
 
 CMTime time = CMTimeMakeWithSeconds(0.0, 600);
 
 NSError *error = nil;
 
 CMTime actualTime;
 
 CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
 
 UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
 
 CGImageRelease(image);
 
 return thumb;
}
/**
 *  获取视频的缩略图方法
 *
 *  @param filePath 视频的本地路径
 *
 *  @return 视频截图
 */
+ (UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath{
    
    UIImage *shotImage;
    //视频路径URL
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:fileURL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    shotImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return shotImage;
    
}

/**
*  获取视频中的音频
*
*  @param videoUrl 视频的本地路径
*  @param newFile 导出音频的路径
*  @completionHandle 音频路径的回调
*/
+ (void)VideoManagerGetBackgroundMiusicWithVideoUrl:(NSURL *)videoUrl newFile:(NSString*)newFile completion:(void(^)(NSString*data))completionHandle{
    
    AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];;
    NSArray *keys = @[@"duration",@"tracks"];
    [videoAsset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSError *error = nil;
        AVKeyValueStatus status = [videoAsset statusOfValueForKey:@"tracks" error:&error];
        if(status ==AVKeyValueStatusLoaded) {//数据加载完成
            AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
            // 2 - Video track
            //Audio Recorder
            //创建一个轨道,类型是AVMediaTypeAudio
            AVMutableCompositionTrack *firstTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
            //获取videoAsset中的音频,插入轨道
            [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration) ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
            NSURL *url = [NSURL fileURLWithPath:newFile];
            AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetAppleM4A];//输出为M4A音频
            exporter.outputURL = url;
            exporter.outputFileType = @"com.apple.m4a-audio";//类型和输出类型一致
            exporter.shouldOptimizeForNetworkUse = YES;
            [exporter exportAsynchronouslyWithCompletionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (exporter.status == AVAssetExportSessionStatusCompleted) {
                        completionHandle(newFile);
                    }else{
                        NSLog(@"提取失败原因：%@",exporter.error);
                        completionHandle(nil);
                    }
                });
            }];
        }
    }];

}


/*
 *  获取视频播放时长
 *  @param urlString 视频路径
 */
+ (NSInteger)getVideoTimeByUrlString:(NSString*)urlString {

    NSURL*videoUrl = [NSURL URLWithString:urlString];

    AVURLAsset *avUrl = [AVURLAsset assetWithURL:videoUrl];

    CMTime time = [avUrl duration];

    int seconds = ceil(time.value/time.timescale);

    return seconds;
}

/*
*  获取视频某一秒第一帧图片
*  @param videoURL 视频路径
*  @param time 时间
*/
+ (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    NSParameterAssert(asset);
    
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    
    assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    
    CFTimeInterval thumbnailImageTime = time;
    
    NSError *thumbnailImageGenerationError = nil;
    
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef){
        NSLog(@"获取失败日志打印：%@",thumbnailImageGenerationError);
    }
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

+ (void)reverseVideo:(NSString *)oldPath newPath:(NSString *)newPath reversePross:(ReturnVideoPath)rever{
    NSURL *videoURL = [NSURL fileURLWithPath:oldPath];

    NSError *error;
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    AVAssetReader *reader = [[AVAssetReader alloc] initWithAsset:asset error:&error];
    AVAssetTrack *videoTrack = [asset tracksWithMediaType:AVMediaTypeVideo].firstObject;
    NSDictionary *readerOutputSettings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange], kCVPixelBufferPixelFormatTypeKey, nil];
    AVAssetReaderTrackOutput *readerOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:videoTrack outputSettings:readerOutputSettings];
    readerOutput.alwaysCopiesSampleData = NO;
    // 在开始读取之前给reader指定一个output
    [reader addOutput:readerOutput];
    [reader startReading];
    
    NSMutableArray *samples = [[NSMutableArray alloc] init];
    CMSampleBufferRef sample;
    while ((sample = [readerOutput copyNextSampleBuffer])) {
        [samples addObject:(__bridge id)sample];
        CFRelease(sample);
    }
    
    
    unlink([newPath UTF8String]);   // 删除当前该路径下的文件
    NSURL *outputURL = [NSURL fileURLWithPath:newPath];
    
    AVAssetWriter *writer = [[AVAssetWriter alloc] initWithURL:outputURL fileType:AVFileTypeMPEG4 error:&error];
    NSDictionary *videoCompressionProps = [NSDictionary dictionaryWithObjectsAndKeys:@(videoTrack.estimatedDataRate), AVVideoAverageBitRateKey, nil];
    NSDictionary *writerOutputSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                          AVVideoCodecH264, AVVideoCodecKey,
                                          [NSNumber numberWithInt:videoTrack.naturalSize.width], AVVideoWidthKey,
                                          [NSNumber numberWithInt:videoTrack.naturalSize.height], AVVideoHeightKey,
                                          videoCompressionProps, AVVideoCompressionPropertiesKey, nil];
    AVAssetWriterInput *writerInput = [[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeVideo outputSettings:writerOutputSettings sourceFormatHint:(__bridge CMFormatDescriptionRef)[videoTrack.formatDescriptions lastObject]];
    [writerInput setExpectsMediaDataInRealTime:NO];
    writerInput.transform = videoTrack.preferredTransform;
    
    AVAssetWriterInputPixelBufferAdaptor *pixelBufferAdaptor = [[AVAssetWriterInputPixelBufferAdaptor alloc] initWithAssetWriterInput:writerInput sourcePixelBufferAttributes:nil];
    [writer addInput:writerInput];
    [writer startWriting];
    [writer startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp((__bridge CMSampleBufferRef)samples[0])];
    for (NSInteger i = 0; i < samples.count; i ++) {
        CMTime presentationTime = CMSampleBufferGetPresentationTimeStamp((__bridge CMSampleBufferRef)samples[i]);
        CVPixelBufferRef imageBufferRef = CMSampleBufferGetImageBuffer((__bridge CMSampleBufferRef)samples[samples.count - i - 1]);
        while (!writerInput.readyForMoreMediaData) {
            [NSThread sleepForTimeInterval:0.1];
        }
        [pixelBufferAdaptor appendPixelBuffer:imageBufferRef withPresentationTime:presentationTime];
    }
    [writer finishWritingWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            rever(newPath);
        });
    }];
}


//传入完整路径
+ (NSString *)timpDurationVideo:(NSString *)path{
    
    NSData *data= [NSData dataWithContentsOfFile:path];
    
    AVAudioPlayer* player = [[AVAudioPlayer alloc]initWithData:data error:nil];
    
    double duration = player.duration;
    
    NSInteger time = (int)duration / 60;
    
    NSInteger second = (int)duration - time * 60;
    return [NSString stringWithFormat:@"%02ld:%02ld",(long)time,(long)second];
}

/*
 获取音频文件播放时长
 name：音频名称
 return double类型时长
 */
+ (double)AudioDuration:(NSString *)path{
    
    NSData *data= [NSData dataWithContentsOfFile:path];
    
    AVAudioPlayer* player = [[AVAudioPlayer alloc]initWithData:data error:nil];
    
    double duration = player.duration;
    
    return duration;
}


@end
