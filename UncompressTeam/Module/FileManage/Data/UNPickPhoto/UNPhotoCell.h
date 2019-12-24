//
//  ZLPhotoCell.h
//  PhotoKit的使用
//
//  Created by qq on 16/6/5.
//  Copyright © 2016年 lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PhotosUI/PhotosUI.h>
@class UNPhotoCell;

@protocol ZLPhotoCellDelegate <NSObject>
@optional
- (void)photoCell:(UNPhotoCell *)cell longPressImage:(UIImage *)image;
@end

@interface UNPhotoCell : UICollectionViewCell

@property (nonatomic,strong) UIImage *img;
@property (nonatomic, assign) BOOL isSelectPhoto;
@property (nonatomic, weak) id<ZLPhotoCellDelegate> deleage;
@end
