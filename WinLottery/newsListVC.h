//
//  newsListVC.h
//  calculator
//
//  Created by jiangzheng on 14-7-16.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newsListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *newsArray;
    NSInteger page;
    NSInteger rowsInPage;
    BOOL hasmore;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview_;

@end
