//
//  aboutUsVC.m
//  calculator
//
//  Created by jiangzheng on 14-7-28.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import "aboutUsVC.h"
@interface aboutUsVC ()

@end

@implementation aboutUsVC

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = MAINBGCOLOR;
    // Do any additional setup after loading the view from its nib.
    _mainTV.text = @"    磁铁计算器-东莞市银磁磁性材料有限公司（东莞银磁）IT事业部旗下系统之一，经过多年的数据积累和试验结果专门为磁材行业开发的移动客户端系统，也是目前最最准确的模拟计算器。\n    磁铁计算器已经经过1年多的内测和行业个别用户使用，已经有过10多次版本升级，后期我们会增加更多的功能给同行业一个更好的服务！\n    广告合作和数据反馈请联系我们！\n    电话：0769-83504288\n    电话：0769-83504211";
    _mainTV.font = [UIFont systemFontOfSize:14.0f];
    [_imgVC setFrame:CGRectMake(110, 10, 100, 150)];
    
    UIButton *email = [UIButton buttonWithType:UIButtonTypeCustom];
    [email setFrame:CGRectMake(10, 345, 170, 30)];
    email.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [email setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [email setTitle:@"IT@agmagnet.com" forState:UIControlStateNormal];
    [email addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:email];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 360, 320, 30)];
    label.text = @"      版权所有：东莞市银磁磁性材料有限公司";
    label.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sendEmail:(UIButton*)sender{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
       [self alertWithMessage:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"];
        return;
    }
    if (![mailClass canSendMail]) {
        [self alertWithMessage:@"用户没有设置邮件账户"];
        return;
    }
    [self displayMailPicker];
}
//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @""];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"IT@agmagnet.com"];
    [mailPicker setToRecipients: toRecipients];
    
    [self presentViewController:mailPicker animated:YES completion:^{
        
    }];
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"用户点击发送，将邮件放到队列中，还没发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
    [self alertWithMessage:msg];
}
-(void)alertWithMessage:(NSString*)mes{
    ALERT(@"提示", mes);
}
@end
