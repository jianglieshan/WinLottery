//
//  HomeViewController.m
//  PagedScrollView
//
//  Created by 陈政 on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "HomeViewController.h"
#import "CycleScrollView.h"

@interface HomeViewController ()

@property (nonatomic , retain) CycleScrollView *mainScorllView;

@end

@implementation HomeViewController
@synthesize pageControl;
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
    // Do any additional setup after loading the view from its nib.
    NSMutableArray *viewsArray = [@[] mutableCopy];
    NSArray *colorArray = @[[UIColor cyanColor],[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor purpleColor]];
    for (int i = 0; i < 5; ++i) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
        tempLabel.backgroundColor = [(UIColor *)[colorArray objectAtIndex:i] colorWithAlphaComponent:0.5];
        [viewsArray addObject:tempLabel];
    }
    
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 300) animationDuration:2];
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    __weak typeof(self) weakSelf = self;
    weakSelf.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        pageControl.currentPage = pageIndex;

        return viewsArray[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return 5;
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%d个",pageIndex);
    };
    [self.view addSubview:self.mainScorllView];
    
    // 初始化 pagecontrol
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(120,340,100,18)]; // 初始化mypagecontrol
    [pageControl setCurrentPageIndicatorTintColor:[UIColor blueColor]];
    [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 1;
     [self.view addSubview:pageControl];
   // [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
