//
//  userMethodVC.m
//  calculator
//
//  Created by jiangzheng on 14-7-28.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import "userMethodVC.h"

@interface userMethodVC ()

@end

@implementation userMethodVC

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
    _squareLabel.textColor = MAINCOLOR;
    _circleLabel.textColor = MAINCOLOR;
    _circleTV.text = @"使用方法：\n长度尺寸不能小于宽度尺寸；\n测试前先选择材料和性能；\n高度H为充磁方向；\n填写直径和长度后可直接计算；\n表磁单位：10GS=1mT；/n计算结果因各厂商材料不一致，计算个别会有误差，结果请以实物测量为准。";
    _circleTV.font = [UIFont systemFontOfSize:14.0f];
    _rectTV.text = @"使用方法：\n长度尺寸不能小于宽度尺寸；\n测试前先选择材料和性能；\n高度H为充磁方向；\n填写长宽高后可直接计算；\n表磁单位：10GS=1mT；\n计算结果因各厂商材料不一致，计算个别会有误差，结果请以实物测量为准。";
    _rectTV.font = [UIFont systemFontOfSize:14.0f];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
