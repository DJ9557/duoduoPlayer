//
//  FAPAppDelegate.m
//  LDDVideoPro
//
//  Created by Mac on 2019/5/9.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>
#import "MainTabVC.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self configSys:launchOptions];
    [self addDefaultFile];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    
//    _viewController = [[UNMainFileManageViewController alloc] initWithFile:nil fileName:nil];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_viewController];
//    self.window.rootViewController = nav;
//
    MainTabVC *main = [[MainTabVC alloc] init];
    self.window.rootViewController = main;
    [self.window makeKeyAndVisible];
        
    return YES;
}

- (void)configSys:(NSDictionary*)launchOptions {
    [UMConfigure initWithAppkey:@"5dd62ecf570df3fc4e000a67" channel:@"App Store"];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
    
}

- (void)addDefaultFile{
 
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirst"] integerValue]==0) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"zip"];
         NSData *data = [NSData dataWithContentsOfFile:filePath];
         [data writeToFile:[DocumentsPath stringByAppendingPathComponent:@"demo.zip"] atomically:YES];
         
         NSData *data1 = [@"hello world" dataUsingEncoding:NSUTF8StringEncoding];
         [data1 writeToFile:[DocumentsPath stringByAppendingPathComponent:@"demo.txt"] atomically:YES];
         for (int i =1; i < 3;i ++) {
             NSString *fileName = [NSString stringWithFormat:@"示例视频%d",i];
             NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp4"];
             NSData *showData = [NSData dataWithContentsOfFile:filePath];
             if ([showData writeToFile:[DocumentsPath stringByAppendingPathComponent:[fileName stringByAppendingString:@".mp4"]] atomically:YES]) {
             }
         }
         
         NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"iTunes传输教程" ofType:@"png"];
         NSData *showPictureData = [NSData dataWithContentsOfFile:filePath2];
         if ([showPictureData writeToFile:[DocumentsPath stringByAppendingPathComponent:@"iTunes传输教程.png"] atomically:YES]) {
         }
         
         NSString *txtFilePath = [[NSBundle mainBundle] pathForResource:@"示例文档" ofType:@"txt"];
         NSData *showTxtData = [NSData dataWithContentsOfFile:txtFilePath];
         if ([showTxtData writeToFile:[DocumentsPath stringByAppendingPathComponent:@"示例文档.txt"] atomically:YES]) {
         }
         NSUserDefaults *user =  [NSUserDefaults standardUserDefaults];
         [user setInteger:1 forKey:@"isFirst"];
         [user synchronize];
     }
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
