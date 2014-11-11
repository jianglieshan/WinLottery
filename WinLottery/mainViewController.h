//
//  mainViewController.h
//  calculator
//
//  Created by jiangzheng on 14-7-15.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
#define XLCYCLE_SCEOLL_VIEW_WIDTH 150
@interface mainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *newsArray;
}
@property(strong,nonatomic)    NSArray *_recommendDataArray;
@property (strong,nonatomic)UIPageControl *pageControl;

@property (nonatomic , retain) CycleScrollView *mainScorllView;
@property (weak, nonatomic) IBOutlet UITableView *tableview_;
@end
