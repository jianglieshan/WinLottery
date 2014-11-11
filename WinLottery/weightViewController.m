//
//  weightViewController.m
//  calculator
//
//  Created by jiangzheng on 14-7-19.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import "weightViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Managet.h"
#import "AFCustomClient.h"
@interface weightViewController (){
    NSMutableArray *_recommendDataArray;
    UIToolbar *topView;
}

@end

@implementation weightViewController

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
    
    btnArray = @[_annulsBtn,_cicleBtn,_tileBtn,_squareBtn];
    _toolBar.barTintColor = MAINCOLOR;
    self.view.backgroundColor = MAINBGCOLOR;
    textArray = [[NSMutableArray alloc] initWithCapacity:1];
    sharpArray = [[NSMutableArray alloc] initWithCapacity:1];
    type =0;
    titleArray = @[@"数量",@"公斤价",@"单价",@"单重",@"总重量"];
    unitArray =@[@"",@"/kg",@"",@"g/pcs",@"kg"];
    square=@[@"长度",@"宽度",@"高度"];
    round=@[@"直径",@"厚度"];
    annulus=@[@"外径",@"内径",@"厚度"];
    tile=@[@"外弧半径",@"内弧半径",@"瓦高",@"瓦宽",@"瓦厚",@"弧度"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view from its nib.
    
    topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone  target:self action:@selector(dismissKeyBoard)];
    doneButton.tintColor=[UIColor colorWithRed:39/255.0f green:103/255.0f blue:213/255.0f alpha:1];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    [self.view addSubview:topView];
    topView.hidden = YES;
}
-(void)dismissKeyBoard{
    for (UITextField *tf in sharpArray) {
        [tf resignFirstResponder];
    }
    for (UITextField *tf in textArray) {
        [tf resignFirstResponder];
    }
    topView.hidden = YES;
}
-(void)didShow:(NSNotification*)aNotification{
    
    NSDictionary *info = [aNotification userInfo];
    NSValue *value = [info objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGSize keyboardSize = [value CGRectValue].size;//获取键盘的size值
    NSLog(@"value %@ %f",value,keyboardSize.height);
    topView.frame = CGRectMake(0,self.view.frame.size.height-keyboardSize.height-topView.frame.size.height, 320, 44);

    //获取键盘出现的动画时间
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    CGFloat height =self.view.frame.size.height - keyboardSize.height ;//加上导航栏的高度44
    NSLog(@"height = %f",height);
    NSTimeInterval animation = animationDuration;
    
    //视图移动的动画开始
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animation];
    topView.hidden=NO;

    CGRect frame =CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width,height);
    self.tableview_.frame = frame;
    [UIView commitAnimations];
    //[self.view setCenter:CGPointMake(self.view.center.x, self.view.center.y-50)];
}
-(void)didHide:(NSNotification*)aNotification{
    NSDictionary *info = [aNotification userInfo];
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    NSTimeInterval animation = animationDuration;
    
    [UIView beginAnimations:@"animal" context:nil];
    [UIView setAnimationDuration:animation];
    self.tableview_.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-44);
    [UIView commitAnimations];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        switch (type) {
            case 0:
                return 3;
            case 1:
                return 2;
            case 2:
                return 3;
            case 3:
                return 6;
            default:
                return 0;
        }
    }
    else{
        return 7;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell.backgroundColor = [UIColor clearColor];

            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
            [title setTextAlignment:NSTextAlignmentRight];
            title.tag = 1001;
            UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(110, 5, 100, 34)];
            [sharpArray addObject:text];
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            text.leftView = v;
            text.leftViewMode = UITextFieldViewModeAlways;
            [text addTarget:self action:@selector(cancleFocus:) forControlEvents:UIControlEventEditingDidEndOnExit];
            text.backgroundColor = [UIColor whiteColor];
            text.layer.borderColor = [UIColor lightGrayColor].CGColor;
            text.layer.borderWidth = 1.0f;
            text.layer.cornerRadius = 5.0f;
            text.backgroundColor = [UIColor whiteColor];
            text.keyboardType = UIKeyboardTypeDecimalPad;
           // text.keyboardType = UIKeyboardTypeDecimalPad;
            text.tag = 1002;
            text.returnKeyType = UIReturnKeyDone;
            UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(220, 0, 60, 44)];
            unit.tag = 1003;
            unit.textColor = [UIColor darkGrayColor];
            if (indexPath.row!=5) {
                unit.text = @"mm";
            }
            [cell.contentView addSubview:unit];
            [cell.contentView addSubview:text];
            [cell.contentView addSubview:title];
        }
        UILabel *title = (UILabel*)[cell viewWithTag:1001];
        NSArray *array;
        switch (type) {
            case 0:
                array = square;
                break;
            case 1:
                array = round;
                break;
            case 2:
                array = annulus;
                break;
            default:
                array = tile;
                break;
        }
        title.text = [array objectAtIndex:indexPath.row];
        return cell;
    }
    else{
        if (indexPath.row==0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
                cell.backgroundColor = [UIColor clearColor];
                UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
                title.text = @"密度";
                
                title.textAlignment = NSTextAlignmentRight;
                UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(200, 5, 100, 34)];
                [textArray addObject:text];
                text.backgroundColor = [UIColor whiteColor];
                text.layer.borderColor = [UIColor lightGrayColor].CGColor;
                text.keyboardType = UIKeyboardTypeDecimalPad;

                text.layer.borderWidth = 1.0f;
                text.layer.cornerRadius = 5.0f;
                UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
                text.leftView = v;
                text.leftViewMode = UITextFieldViewModeAlways;
                text.returnKeyType = UIReturnKeyDone;
                text.text = @"7.5";
                [text addTarget:self action:@selector(cancleFocus:) forControlEvents:UIControlEventEditingDidEndOnExit];
                text.backgroundColor = [UIColor whiteColor];
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                matiBtn = btn;
                [btn setTitle:@"钕铁硼" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(changeMaterial:) forControlEvents:UIControlEventTouchUpInside];
                [btn setFrame:CGRectMake(100, 7, 80, 30)];
                [cell.contentView addSubview:btn];
                [cell.contentView addSubview:title];
                [cell.contentView addSubview:text];
            }
            return cell;
        }
        else if (indexPath.row == 6){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
                cell.backgroundColor = [UIColor clearColor];
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [btn setTitle:@"计算" forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"normal.png"] forState:UIControlStateNormal];
            [btn setFrame:CGRectMake(120, 10, 80, 30)];
            [btn addTarget:self action:@selector(calculate:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
            return cell;
        }
        else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
                cell.backgroundColor = [UIColor clearColor];
                UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
                title.textAlignment = NSTextAlignmentRight;
                title.tag = 1001;
                UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(110, 5, 100, 34)];
                [textArray addObject:text];
                [text addTarget:self action:@selector(cancleFocus:) forControlEvents:UIControlEventEditingDidEndOnExit];
                text.returnKeyType = UIReturnKeyDone;
                text.backgroundColor = [UIColor whiteColor];
                text.layer.borderColor = [UIColor lightGrayColor].CGColor;
                text.keyboardType = UIKeyboardTypeDecimalPad;

                text.layer.borderWidth = 1.0f;
                text.layer.cornerRadius = 5.0f;
                UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
                text.leftView = v;
                text.leftViewMode = UITextFieldViewModeAlways;
                text.tag = 1002;
                UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(220, 0, 60, 44)];
                unit.tag = 1003;
                unit.textColor = [UIColor darkGrayColor];
                [cell.contentView addSubview:unit];
                [cell.contentView addSubview:text];
                [cell.contentView addSubview:title];
            }
            UILabel *title = (UILabel*)[cell viewWithTag:1001];
            UITextField *text =(UITextField*)[cell viewWithTag:1002];
            UILabel *unit = (UILabel*)[cell viewWithTag:1003];
            title.text = [titleArray objectAtIndex:indexPath.row-1];
            unit.text = [unitArray objectAtIndex:indexPath.row-1];
            if (indexPath.row>2) {
                text.enabled=NO;
                text.textColor = [UIColor redColor];
            }
            else{
                text.enabled=YES;
            }
            return cell;
        }
    }
}
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
- (IBAction)changeType:(UIButton*)sender {
    for (UIButton*btn in btnArray) {
        [btn setBackgroundColor:MAINCOLOR];
    }
    [sender setBackgroundColor:SELECTCOLOR];
    NSInteger n =0;
    for (UITextField *tf in textArray) {
        if (n==0) {
            n++;
            continue;
        }
        tf.text = @"";
    }
    for (UITextField *tf in sharpArray) {
        tf.text = @"";
    }
    type = [(UIButton*)sender tag];
    [self.tableview_ reloadData];
}
-(void)calculate:(UIButton*)sender{
    double des = [[[textArray objectAtIndex:0] text] floatValue];
   double weight =  [Managet calWeightByType:type
                         Des:des Param:sharpArray];
    
    UITextField *tf;
    
    //数量
    tf = [textArray objectAtIndex:1];
    double amount = [tf.text doubleValue];
    //单重
    UITextField *signalweight = [textArray objectAtIndex:4];
    signalweight.text = [NSString stringWithFormat:@"%.3f",weight];
    
    UITextField *totalWeight = [textArray objectAtIndex:5];
    totalWeight.text = [NSString stringWithFormat:@"%.3f",weight*amount/1000];
    
    tf = [textArray objectAtIndex:2];
    double price = [tf.text doubleValue];
    tf = [textArray objectAtIndex:3];
    tf.text = [NSString stringWithFormat:@"%.3f",weight*price/1000];
    
}
-(void)cancleFocus:(id)sender{
    [sender resignFirstResponder];
}
-(void)changeMaterial:(UIButton*)sender{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"选择材料" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"钕铁硼",@"铁氧体",@"钐钴", nil];
    [alert show];
}
#pragma mark -- alert delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex>0) {
        UITextField *text = [textArray objectAtIndex:0];
        switch (buttonIndex) {
            case 1:
                [matiBtn setTitle:@"钕铁硼" forState:UIControlStateNormal];
                text.text = @"7.5";
                break;
            case 2:
                [matiBtn setTitle:@"铁氧体" forState:UIControlStateNormal];
                text.text = @"4.8";
                break;
            default:
                [matiBtn setTitle:@"钐钴" forState:UIControlStateNormal];
                text.text = @"8.4";
                break;
        }
    }
}

@end
