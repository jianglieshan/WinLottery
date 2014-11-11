//
//  newsDetailVC.h
//  calculator
//
//  Created by jiangzheng on 14-7-16.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsDetailVC : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(strong,nonatomic) NSString *urlStr;
@property(strong,nonatomic) NSString *type;
@property(strong,nonatomic) NSDictionary *newsDic;
@end
