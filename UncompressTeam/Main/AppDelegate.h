//
//  FAPAppDelegate.h
//  LDDVideoPro
//
//  Created by Mac on 2019/5/9.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UNMainFileManageViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate: UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic ,strong) UNMainFileManageViewController* viewController;

@end


NS_ASSUME_NONNULL_END
