//
//  weightViewController.h
//  calculator
//
//  Created by jiangzheng on 14-7-19.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface weightViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    NSInteger type;
    NSArray *titleArray;
    NSArray *unitArray;
    NSArray *square;
    NSArray *round;
    NSArray *annulus;
    NSArray *tile;
    NSMutableArray *sharpArray;
    NSMutableArray *textArray;
    UIButton *matiBtn;
    NSArray *btnArray;
}
@property (weak, nonatomic) IBOutlet UIButton *squareBtn;
@property (weak, nonatomic) IBOutlet UIButton *cicleBtn;
@property (weak, nonatomic) IBOutlet UIButton *annulsBtn;
@property (weak, nonatomic) IBOutlet UIButton *tileBtn;

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UITableView *tableview_;
- (IBAction)changeType:(UIButton*)sender;
@end
