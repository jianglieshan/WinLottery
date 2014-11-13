//
//  AppDelegate.m
//  calculator
//
//  Created by jiangzheng on 14-7-15.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//
#import "AppDelegate.h"
#import "mainViewController.h"
#import "CommonNetClient.h"
#import "CommonTool.h"
#import "BaseParam.h"
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setBarTintColor:MAINCOLOR];
    application.applicationIconBadgeNumber = 0;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    mainViewController *main = [[mainViewController alloc] init];
    nav = [[UINavigationController alloc] initWithRootViewController:main];
    nav.navigationBar.titleTextAttributes= [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    nav.navigationBar.tintColor=[UIColor whiteColor];

    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"UUID"]==nil) {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        CFStringRef uuidstring = CFUUIDCreateString(NULL, uuid);
        // 就下面这个玩意
        NSString *identifierNumber = [NSString stringWithFormat:@"%@",uuidstring];
        // 存起来以后用
        [[NSUserDefaults standardUserDefaults] setObject:identifierNumber forKey:@"UUID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        CFRelease(uuidstring);
        CFRelease(uuid);
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    //[[CommonNetClient shareNetClient]addSelector:@selector(getVerifyCodeByDeviceId:) WithParam:UUID];
    BaseParam *param = [[BaseParam alloc] initWithTarget:self Cbselector:@selector(test:) Classname:nil Requestname:@"getVerifyCode:" Params:[NSMutableArray arrayWithObjects:UUID, nil]];
    [[CommonNetClient shareNetClient] addSelector:@selector(commonDataRequest:) WithParam:param];
    return YES;
}
-(void)test:(id)retdata{
    NSLog(@"%@",retdata);
}



- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //点击提示框的打开
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    //当程序还在后天运行
    application.applicationIconBadgeNumber = 0;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
