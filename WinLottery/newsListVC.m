//
//  newsListVC.m
//  calculator
//
//  Created by jiangzheng on 14-7-16.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import "newsListVC.h"
#import "AFCustomClient.h"
#import "newsDetailVC.h"
@interface newsListVC ()

@end

@implementation newsListVC

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
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    [item setTitle:@"磁铁计算器"];
    self.navigationItem.backBarButtonItem = item;
    page =1;
    rowsInPage = 20;
    // Do any additional setup after loading the view from its nib.
    [self getNewsWithPage:page];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- data request
-(void)getNewsWithPage:(NSInteger)pages{
    SHOWHUD
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:UUID,@"deviceId",@"",@"imsi", [NSString stringWithFormat:@"%d",pages],@"page", [NSString stringWithFormat:@"%d",rowsInPage],@"rows",nil];
    [[AFCustomClient sharedClient] getPath:MAKEPATH(@"NewsList.jsp") parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *ret = [responseObject objectFromJSONData];
        if ([[ret valueForKey:@"ret"] intValue] == 0 ) {
            if (newsArray == nil) {
                
                newsArray =[[NSMutableArray alloc] initWithArray: [ret valueForKey:@"rows"]];
            }
            else {
                NSArray *array =[ret valueForKey:@"rows"];
                if ([array count]==0) {
                    hasmore = YES;
                }
                else{
                    [newsArray addObjectsFromArray:array];
                    hasmore = NO;
                }
            }
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



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return [newsArray count]+2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
        label.text = @"";
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        label.tag =100;
    }
    UILabel *label = (UILabel*)[cell viewWithTag:100];
    if (indexPath.row == 0) {
        label.textColor = [UIColor blackColor];
        label.text = @"点击可以刷新";
        label.textAlignment = NSTextAlignmentCenter;

    }
     else   if (indexPath.row-1<newsArray.count) {
            NSDictionary *news = [newsArray objectAtIndex:indexPath.row-1];
         label.textColor = MAINCOLOR;
            label.text = [news  valueForKey:@"title"];
         label.textAlignment = NSTextAlignmentLeft;

        }
    else if (indexPath.row==newsArray.count+1)
    {
        if (hasmore) {
            label.textColor = [UIColor blackColor];
            label.text = @"没有更多了";
        }
        else{
            label.textColor = [UIColor blackColor];
            label.text = @"更多";
        }
        label.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *label = (UILabel*)[cell viewWithTag:100];

    if (indexPath.row ==0) {
        [newsArray removeAllObjects];
        page =1;
        [self getNewsWithPage:page];
    }
     else   if (indexPath.row-1<newsArray.count) {
            NSDictionary *newsDic = [newsArray objectAtIndex:indexPath.row-1];
            newsDetailVC *det = [[newsDetailVC alloc] init];
            det.urlStr  = [newsDic valueForKey:@"url"];
         det.newsDic = newsDic;
         det.type = @"news";
           // [[AFCustomClient sharedClient] newsCountbyId:[newsDic valueForKey:@"id"] Type:@"news"];

            [self.navigationController pushViewController:det animated:YES];
        }
     else if(indexPath.row-1==newsArray.count&&[label.text isEqualToString:@"更多"]){
         page++;
         [self getNewsWithPage:page];
     }
}
@end
