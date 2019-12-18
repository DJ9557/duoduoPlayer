//
//  FAPAppDelegate.m
//  LDDVideoPro
//
//  Created by Mac on 2019/5/9.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+JPush.h"
#import <UMAnalytics/MobClick.h>
#import <UMCommon/UMCommon.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self configSys:launchOptions];
    [self addDefaultFile];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    
    _viewController = [[UNMainFileManageViewController alloc] initWithFile:nil fileName:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_viewController];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
        
    return YES;
}

- (void)configSys:(NSDictionary*)launchOptions {
    [UMConfigure initWithAppkey:@"5dd62ecf570df3fc4e000a67" channel:@"App Store"];
    [self jpushRegWithAppKey:@"cc3219240a331db0ec09af10" launchOptions:launchOptions];
    //GoogleAd
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
    
}

- (void)addDefaultFile{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"zip"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    [data writeToFile:[DocumentsPath stringByAppendingPathComponent:@"demo.zip"] atomically:YES];
    
    
    NSData *data1 = [@"hello world" dataUsingEncoding:NSUTF8StringEncoding];
    [data1 writeToFile:[DocumentsPath stringByAppendingPathComponent:@"demo.txt"] atomically:YES];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    NSLog(@"url  %@",[url absoluteString]);
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if ([[url absoluteString] containsString:@"file"]) {
        NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
        NSString *fileName = [array lastObject];
        fileName = [fileName stringByRemovingPercentEncoding];
        
        NSString *path = [documentsPath stringByAppendingPathComponent:fileName];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
         [data writeToFile:path atomically:YES];
        
        [SVProgressHUD showSuccessWithStatus:@"传输成功"];
    }
    return YES;
}

@end