//
//  mainViewController.m
//  calculator
//
//  Created by jiangzheng on 14-7-15.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//
#import "mainViewController.h"
#import "AFCustomClient.h"
#import "CalculatorViewController.h"
#import "newsDetailVC.h"
#import "newsListVC.h"
#import "UIImageView+AFNetworking.h"
#import "weightViewController.h"
#import "surfaceMagneticV2.h"
#import "userMethodVC.h"
#import "aboutUsVC.h"
@interface mainViewController ()

@end

@implementation mainViewController
@synthesize pageControl,_recommendDataArray;
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
    self.title = @"磁铁计算器";
    // Do any additional setup after loading the view from its nib.
    SHOWHUD
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:UUID,@"deviceId",@"",@"imsi", nil];
    [[AFCustomClient sharedClient] getPath:MAKEPATH(@"Home.jsp") parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *ret = [responseObject objectFromJSONData];
        if ([[ret valueForKey:@"ret"] intValue] == 0 ) {
            newsArray = [ret valueForKey:@"newsList"];
            _recommendDataArray = [ret valueForKey:@"recList"];
        }
        else{
            ALERT(@"提示", [ret valueForKey:@"msg"] );
        }
        DLog(@"%@",ret);
        [_tableview_ reloadData];
        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getMoreNews:(UIButton*)sender{
    newsListVC *nl = [[newsListVC alloc] init];
    [self.navigationController pushViewController:nl animated:YES];
}
#pragma mark -
#pragma mark tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0&&indexPath.row ==3) {
        return 150;
    }
    else
        return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==1) {
    return 31;
    }
    else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
       // v.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
        v.backgroundColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 30)];
        label.text = @"新闻列表";
        [v addSubview:label];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"更多" forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(265, 0, 40, 30)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(getMoreNews:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setTextColor:[UIColor blackColor]];
        [v addSubview:btn];
        return v;
    }
    else{
        return nil;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }
    else{
        return [newsArray count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifer = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if (indexPath.section== 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"计算器";
            cell.imageView.image = [UIImage imageNamed:@"calculator.png"];
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = @"表磁计算器";
            cell.imageView.image = [UIImage imageNamed:@"density.png"];

        }
        else if (indexPath.row == 2){
            cell.textLabel.text = @"重量计算器";
            cell.imageView.image = [UIImage imageNamed:@"weight.png"];

        }
        else{
            UITableViewCell* cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_"];
            NSMutableArray *viewsArray = [@[] mutableCopy];
            NSMutableArray *titlesArray = [@[] mutableCopy];
            for (int i = 0; i < [_recommendDataArray count]; ++i) {
                UIImageView *_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,XLCYCLE_SCEOLL_VIEW_WIDTH)];
                NSString* url=[[_recommendDataArray objectAtIndex:i] objectForKey:@"img"];
                NSURL *imagUrl_ = [NSURL URLWithString:url];
                [_imageView setImageWithURL:imagUrl_
                           placeholderImage:nil];
                
                [viewsArray addObject:_imageView];
                
                [titlesArray addObject:[[_recommendDataArray objectAtIndex:i] objectForKey:@"title"]];
            }
            self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 150) animationDuration:2];
            UILabel* _activeLabel_ = [[UILabel alloc] initWithFrame:
                                      CGRectMake(0,130,320,20)];
            //_activeLabel_.backgroundColor = [UIColor clearColor];
            [_activeLabel_ setBackgroundColor:[UIColor blackColor]];
            //设置背景颜色
            //_activeLabel_.textAlignment = UITextAlignmentCenter;
            _activeLabel_.textColor = [UIColor whiteColor];
            [_activeLabel_ setFont:[UIFont systemFontOfSize:14]];
            //_activeLabel_.shadowColor = [UIColorcolorWithWhite:0.1f alpha:0.8f];
            //设置UILabel为半透明取值为0.0－1.0
            _activeLabel_.alpha = 0.5;
            
            
            self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
            __weak typeof(self) weakSelf = self;
            weakSelf.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
                pageControl.currentPage = pageIndex;
                int index_;
                if(pageIndex==0)
                    index_=[titlesArray count]-1;
                else
                    index_=pageIndex-1;
                
                _activeLabel_.text=[titlesArray objectAtIndex:index_];
                return viewsArray[pageIndex];
            };
            weakSelf.mainScorllView.totalPagesCount = ^NSInteger(void){
                return [viewsArray count];
            };
            self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
                
                NSLog(@"点击了第%d个",pageIndex);
                NSDictionary *newsDic = [weakSelf. _recommendDataArray objectAtIndex:pageIndex];
                newsDetailVC *det = [[newsDetailVC alloc] init];
                det.urlStr  = [newsDic valueForKey:@"url"];
                det.type = @"rec";
                det.newsDic = newsDic;
                [weakSelf.navigationController pushViewController:det animated:YES];
            };
            
            [cell addSubview:self.mainScorllView];
            
            self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(220,130,100,20)]; // 初始化mypagecontrol
            [pageControl setCurrentPageIndicatorTintColor:[UIColor lightGrayColor]];
            [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
            pageControl.numberOfPages = [viewsArray count];
            pageControl.currentPage = 1;
            [cell addSubview:_activeLabel_];
            [cell addSubview:pageControl];
            return cell;
        }
    }
    else {
        cell.textLabel.textColor = MAINCOLOR;
        /*
        if(indexPath.row == 0){
            UITableViewCell* cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_"];
            NSMutableArray *viewsArray = [@[] mutableCopy];
            NSMutableArray *titlesArray = [@[] mutableCopy];
            for (int i = 0; i < [_recommendDataArray count]; ++i) {
                UIImageView *_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,XLCYCLE_SCEOLL_VIEW_WIDTH)];
                NSString* url=[[_recommendDataArray objectAtIndex:i] objectForKey:@"img"];
                NSURL *imagUrl_ = [NSURL URLWithString:url];
                [_imageView setImageWithURL:imagUrl_
                           placeholderImage:nil];
                
                [viewsArray addObject:_imageView];
                
                [titlesArray addObject:[[_recommendDataArray objectAtIndex:i] objectForKey:@"title"]];
            }
             self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 150) animationDuration:2];
            UILabel* _activeLabel_ = [[UILabel alloc] initWithFrame:
                                      CGRectMake(0,130,320,20)];
            //_activeLabel_.backgroundColor = [UIColor clearColor];
            [_activeLabel_ setBackgroundColor:[UIColor blackColor]];
            //设置背景颜色
            //_activeLabel_.textAlignment = UITextAlignmentCenter;
            _activeLabel_.textColor = [UIColor whiteColor];
            [_activeLabel_ setFont:[UIFont systemFontOfSize:14]];
            //_activeLabel_.shadowColor = [UIColorcolorWithWhite:0.1f alpha:0.8f];
            //设置UILabel为半透明取值为0.0－1.0
            _activeLabel_.alpha = 0.5;
            
            
            self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
            __weak typeof(self) weakSelf = self;
            weakSelf.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
                pageControl.currentPage = pageIndex;
                int index_;
                if(pageIndex==0)
                    index_=[titlesArray count]-1;
                else
                    index_=pageIndex-1;
                
                _activeLabel_.text=[titlesArray objectAtIndex:index_];
                return viewsArray[pageIndex];
            };
            weakSelf.mainScorllView.totalPagesCount = ^NSInteger(void){
                return [viewsArray count];
            };
            self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
                
                NSLog(@"点击了第%d个",pageIndex);
                NSDictionary *newsDic = [weakSelf. _recommendDataArray objectAtIndex:pageIndex];
                newsDetailVC *det = [[newsDetailVC alloc] init];
                det.urlStr  = [newsDic valueForKey:@"url"];
                det.type = @"rec";
                det.newsDic = newsDic;
                [weakSelf.navigationController pushViewController:det animated:YES];
            };
            
            [cell addSubview:self.mainScorllView];
            
            self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(220,130,100,20)]; // 初始化mypagecontrol
            [pageControl setCurrentPageIndicatorTintColor:[UIColor lightGrayColor]];
            [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
            pageControl.numberOfPages = [viewsArray count];
            pageControl.currentPage = 1;
            [cell addSubview:_activeLabel_];
            [cell addSubview:pageControl];
            return cell;
            
        }
        
        if (indexPath.row<newsArray.count) {
            NSDictionary *news = [newsArray objectAtIndex:indexPath.row];
            cell.textLabel.text = [news  valueForKey:@"title"];
        }*/
        
            NSDictionary *news = [newsArray objectAtIndex:indexPath.row];
            cell.textLabel.text = [news  valueForKey:@"title"];
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CalculatorViewController *cal = [[CalculatorViewController alloc] init];
            [self.navigationController pushViewController:cal animated:YES];
        }
        else if (indexPath.row==2)
        {
            weightViewController *we = [[weightViewController alloc] init];
            [self.navigationController pushViewController:we animated:YES];
        }
        else{
            surfaceMagneticV2 *su = [[surfaceMagneticV2 alloc] init];
            su._recommendDataArray = _recommendDataArray;
            [self.navigationController pushViewController:su animated:YES];
        }
    }
    else{
        if (indexPath.row<newsArray.count) {
            NSDictionary *newsDic = [newsArray objectAtIndex:indexPath.row];
            newsDetailVC *det = [[newsDetailVC alloc] init];
            det.urlStr  = [newsDic valueForKey:@"url"];
            det.type = @"news";
            det.newsDic = newsDic;
            //[[AFCustomClient sharedClient] newsCountbyId:[newsDic valueForKey:@"id"] Type:@"news"];
            [self.navigationController pushViewController:det animated:YES];
        }
        
    }
}
#pragma mark --
#pragma mark button event
- (IBAction)userMethod:(id)sender {
    userMethodVC *um = [[userMethodVC alloc] init];
    [self.navigationController pushViewController:um animated:YES];
}

- (IBAction)aboutUs:(id)sender {
    aboutUsVC *au = [[aboutUsVC alloc] init];
    [self.navigationController pushViewController:au animated:YES];
}
@end
