//
//  newsDetailVC.m
//  calculator
//
//  Created by jiangzheng on 14-7-16.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import "newsDetailVC.h"
#import "MBProgressHUD.h"
#import "AFCustomClient.h"
@interface newsDetailVC ()
{
    MBProgressHUD *hud;
}
@end

@implementation newsDetailVC
@synthesize webView,urlStr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[AFCustomClient sharedClient] newsCountbyId:[_newsDic valueForKey:@"id"] Type:_type];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    [hud show:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark webview delegate
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [hud hide:YES];
    ALERT(@"提示", @"数据请求失败")
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [hud hide:YES];
}
@end
