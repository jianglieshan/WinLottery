//
//  AppDelegate.m
//  calculator
//
//  Created by jiangzheng on 14-7-15.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//
#import "newsDetailVC.h"
#import "AppDelegate.h"
#import "mainViewController.h"
#import "AFCustomClient.h"
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
    UIApplication *app = [UIApplication sharedApplication];
    [app cancelAllLocalNotifications];
    [self autoLogin];
    [self getPushInfo];
    [self setLocalNotifycation];
   
    return YES;
}
-(void)getPushInfo{
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:@"iPhone",@"imsi",UUID,@"deviceId", nil];
    [[AFCustomClient sharedClient] postPath:MAKEPATH(@"Push.jsp") parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [responseObject objectFromJSONData];
        DLog(@"%@",dic);
        NSString *url = [[[dic valueForKeyPath:@"rows"] objectAtIndex:0]valueForKeyPath:@"url"];
        
        NSString *lastUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"pushurl"];
        
        if (![url isEqualToString:lastUrl]&&![url isEqualToString:@""]) {
            [[NSUserDefaults standardUserDefaults] setValue:url  forKey:@"pushurl"];
            isSetNotice = YES;
        }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)displayPushInfo{
    NSString *url = [[NSUserDefaults standardUserDefaults] valueForKey:@"pushurl"];
    if (![url isEqualToString:@""]) {
        newsDetailVC *detail = [newsDetailVC alloc];
        detail.type = @"news";
        detail.urlStr = url;
        [nav pushViewController:detail animated:YES];
    }
}

-(void)autoLogin{
    NSString *model = [UIDevice currentDevice].model;
    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:model,@"model",@"",@"imsi",UUID,@"deviceId",sysVersion,@"release",VERSION,@"versionCode",@"iPhone",@"brand", nil];
    [[AFCustomClient sharedClient] postPath:MAKEPATH(@"Login.jsp") parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [responseObject objectFromJSONData];
        DLog(@"%@",dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
-(void)setLocalNotifycation{
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *tenAM = @"2014-01-01 10:00";
    NSString *sixPM = @"2014-01-01 18:00";
    NSDate *ten = [matter dateFromString:tenAM];
    NSDate *six = [matter dateFromString:sixPM];
    
    UILocalNotification *notification=[[UILocalNotification alloc] init];
      //  NSDate *now=[NSDate new];
    //notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
       notification.fireDate=ten;//10秒后通知
        notification.repeatInterval=kCFCalendarUnitDay;//循环次数，kCFCalendarUnitWeekday一周一次
    NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
    notification.userInfo = info;
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber=1; //应用的红色数字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不会弹出提示框
        notification.alertBody=@"来自磁铁计算器的上午推送";//提示信息 弹出提示框
        //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    UILocalNotification *noti=[[UILocalNotification alloc] init];
    noti.fireDate=six;//10秒后通知
    noti.repeatInterval=kCFCalendarUnitDay;//循环次数，kCFCalendarUnitWeekday一周一次
    noti.timeZone=[NSTimeZone defaultTimeZone];
    noti.applicationIconBadgeNumber=1; //应用的红色数字
    noti.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
    //去掉下面2行就不会弹出提示框
    noti.alertBody=@"来自磁铁计算器的下午推送";//提示信息 弹出提示框
    //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
    
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //点击提示框的打开
    application.applicationIconBadgeNumber = 0;
    [self displayPushInfo];
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

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if (isSetNotice) {
        UILocalNotification *notification=[[UILocalNotification alloc] init];
        //  NSDate *now=[NSDate new];
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
        // notification.fireDate=ten;//10秒后通知
        notification.repeatInterval=0;//循环次数，kCFCalendarUnitWeekday一周一次
        NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
        notification.userInfo = info;
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber=1; //应用的红色数字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不会弹出提示框
        notification.alertBody=@"来自磁铁计算器的推送";//提示信息 弹出提示框
        //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
