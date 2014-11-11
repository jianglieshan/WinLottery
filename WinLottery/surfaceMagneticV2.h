//
//  surfaceMagneticV2.h
//  calculator
//
//  Created by jiangzheng on 14-7-26.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
#define XLCYCLE_SCEOLL_VIEW_WIDTH 150
@interface surfaceMagneticV2 : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    BOOL iscylinder;
    BOOL isrect;
    UIButton *matiBtn;
    UIButton *detaiBtn;
    UIPickerView *materialPicker;
    UIPickerView *detailPicker;
}
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property(strong,nonatomic)    NSArray *_recommendDataArray;
@property (strong,nonatomic)UIPageControl *pageControl;
@property (nonatomic , retain) CycleScrollView *mainScorllView;
@property (weak, nonatomic) IBOutlet UITableView *maintable;
- (IBAction)disCylinder:(id)sender;
- (IBAction)disRect:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cyBtn_;
@property (weak, nonatomic) IBOutlet UIButton *rectBtn_;
@end
