//
//  aboutUsVC.h
//  calculator
//
//  Created by jiangzheng on 14-7-28.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface aboutUsVC : UIViewController<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *mainTV;
@property (weak, nonatomic) IBOutlet UIImageView *imgVC;

@end
