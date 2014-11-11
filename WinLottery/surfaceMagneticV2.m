//
//  surfaceMagneticV2.m
//  calculator
//
//  Created by jiangzheng on 14-7-26.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//
#import "UIImageView+AFNetworking.h"
#import "surfaceMagneticV2.h"
#import "newsDetailVC.h"
#import <QuartzCore/QuartzCore.h>
#import "Managet.h"
#import "AFCustomClient.h"
@interface surfaceMagneticV2 ()
{
    NSArray *cyTitle;
    NSArray *reTitle;
    NSArray *cyUnit;
    NSArray *reUnit;
    NSMutableArray *textArray;
    NSMutableArray *commonArray;
    
    NSDictionary *coefficient;
    NSArray *materialArray;
    NSArray *nvtiepengArray;
    NSArray *feArray;
    NSArray *shanArray;
    UIToolbar *topView;
}
@end

@implementation surfaceMagneticV2
@synthesize _recommendDataArray,pageControl;
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
    
    materialArray = @[@"钕铁硼",@"铁氧体",@"钐钴"];
    nvtiepengArray = @[@"N35",@"N38",@"N40",@"N42",@"N45",@"N48",@"N50",@"N52"];
    feArray =@[@"Y25",@"Y30",@"Y35"];
    shanArray = @[@"26",@"28",@"30",@"32"];
    coefficient = [[NSDictionary alloc] initWithObjectsAndKeys:
                   @"11900",@"钕铁硼N35",
                   @"12300",@"钕铁硼N38",
                   @"12600",@"钕铁硼N40",
                   @"13000",@"钕铁硼N42",
                   @"13500",@"钕铁硼N45",
                   @"14000",@"钕铁硼N48",
                   @"14300",@"钕铁硼N50",
                   @"14550",@"钕铁硼N52",
                   @"3500",@"铁氧体Y25",
                   @"3800",@"铁氧体Y30",
                   @"3300",@"铁氧体Y35",
                   @"10000",@"钐钴26",
                   @"10200",@"钐钴28",
                   @"11000",@"钐钴30",
                   @"11300",@"钐钴32",
                   nil];
    // Do any additional setup after loading the view from its nib.
    textArray = [[NSMutableArray alloc] initWithCapacity:1];
    commonArray = [[NSMutableArray alloc] initWithCapacity:1];
    _toolBar.barTintColor = MAINCOLOR;
    cyTitle = @[@"剩磁BR",@"直径D",@"高度H"];
    cyUnit = @[@"Gs",@"mm",@"mm"];
    reTitle = @[@"剩磁BR",@"长度L",@"宽度W",@"高度H"];
    reUnit =@[@"Gs",@"mm",@"mm",@"mm"];
    iscylinder = YES;
    isrect = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHide:) name:UIKeyboardWillHideNotification object:nil];
    
    topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone  target:self action:@selector(dismissKeyBoard)];
    doneButton.tintColor=[UIColor colorWithRed:39/255.0f green:103/255.0f blue:213/255.0f alpha:1];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    [self.view addSubview:topView];
    topView.hidden = YES;
    /*
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:UUID,@"deviceId",@"",@"imsi",@"表磁",@"type", nil];
    [[AFCustomClient sharedClient] getPath:MAKEPATH(@"ScrollNewsList.jsp") parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *ret = [responseObject objectFromJSONData];
        NSLog(@"%@",ret);
        if ([[ret valueForKey:@"ret"] intValue] == 0 ) {
            _recommendDataArray = [ret valueForKey:@"rows"];
        }
        else{
            ALERT(@"提示", [ret valueForKey:@"msg"] );
        }
        DLog(@"%@",ret);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];*/
}
-(void)dismissKeyBoard{
    for (UITextField *tf in commonArray) {
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
    CGRect frame =CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width,height);
    topView.hidden = NO;
    self.maintable.frame = frame;
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
    self.maintable.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-44);
    [UIView commitAnimations];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)disCylinder:(id)sender {
    [_cyBtn_ setBackgroundColor:SELECTCOLOR];
    [_rectBtn_ setBackgroundColor:MAINCOLOR];
    iscylinder = YES;
    isrect = NO;
    [self cleanData];
    [self.maintable reloadData];
}

- (IBAction)disRect:(id)sender {
    [_rectBtn_ setBackgroundColor:SELECTCOLOR];
    [_cyBtn_ setBackgroundColor:MAINCOLOR];
    iscylinder = NO;
    isrect = YES;
    [self cleanData];
    [self.maintable reloadData];
}
-(void)cleanData{
    for (UITextField*tf in commonArray) {
        tf.text = @"";
    }
    int n  = 0 ;
    for (UITextField*tf in textArray) {
        if (n!=0) {
            tf.text = @"";
        }
        n++;
    }
}
#pragma mark -- tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        if (isrect) {
            return [reTitle count];
        }
        else{
            return [cyUnit count];
        }
    }
    else if (section ==2)
        return 2;
    else
        return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"section%drow%d",indexPath.section,indexPath.row]];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"section%drow%d",indexPath.section,indexPath.row]];
        cell.backgroundColor = [UIColor clearColor];
        if (indexPath.section == 0) {
                UIButton *btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
            matiBtn = btnleft ;
                [btnleft setTitle:@"钕铁硼" forState:UIControlStateNormal];
            [btnleft setTitleColor:MAINCOLOR forState:UIControlStateNormal];
                [btnleft setFrame:CGRectMake(30, 10, 100, 30)];
                [cell.contentView addSubview:btnleft];
            [btnleft setImage:[UIImage imageNamed:@"current_task_pointer.png"] forState:UIControlStateNormal];
            [btnleft setBackgroundImage:[UIImage imageNamed:@"tygj_btn.png"] forState:UIControlStateNormal];
            [btnleft addTarget:self action:@selector(showMaterial:) forControlEvents:UIControlEventTouchUpInside];
                UIButton *btnright = [UIButton buttonWithType:UIButtonTypeCustom];
            detaiBtn = btnright;
                [btnright setTitle:@"N35" forState:UIControlStateNormal];
                [btnright setFrame:CGRectMake(190, 10, 100, 30)];
            [btnright setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            [btnright setImage:[UIImage imageNamed:@"current_task_pointer.png"] forState:UIControlStateNormal];
            [btnright setBackgroundImage:[UIImage imageNamed:@"tygj_btn.png"] forState:UIControlStateNormal];

            [btnright addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btnright];
                [btnright.titleLabel setTextColor:MAINCOLOR];
            /*
            else if (indexPath.row==1){
                [cell.contentView addSubview:rv];
            }
            else{
                UIButton *cal = [UIButton buttonWithType:UIButtonTypeCustom];
                [cal setTitle:@"计算" forState:UIControlStateNormal];
                [cal setFrame:CGRectMake(120, 10, 80, 30)];
                [cell.contentView addSubview:cal];
                [cal.titleLabel setTextColor:MAINCOLOR];
            }*/
            
        }
        else if (indexPath.section==1){
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
            [title setTextAlignment:NSTextAlignmentRight];
            title.tag = 1001;
            UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(110, 5, 100, 34)];
            if (indexPath.row==0) {
                text.text = @"11900";
            }
            text.keyboardType = UIKeyboardTypeDecimalPad;
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            text.leftView = v;
            text.leftViewMode = UITextFieldViewModeAlways;

            [textArray addObject:text];
            [text addTarget:self action:@selector(cancleFocus:) forControlEvents:UIControlEventEditingDidEndOnExit];
            text.returnKeyType = UIReturnKeyDone;
            text.backgroundColor = [UIColor whiteColor];
            text.layer.borderColor = [UIColor lightGrayColor].CGColor;
            text.layer.borderWidth = 1.0f;
            text.layer.cornerRadius = 5.0f;
            text.tag = 1002;
            UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(220, 0, 60, 44)];
            unit.tag = 1003;
            unit.textColor = [UIColor darkGrayColor];
            [cell.contentView addSubview:unit];
            [cell.contentView addSubview:text];
            [cell.contentView addSubview:title];
        }
        else if (indexPath.section==2){
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
            [title setTextAlignment:NSTextAlignmentRight];
            title.tag = 1001;
            UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(110, 5, 100, 34)];
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            text.leftView = v;
            text.leftViewMode = UITextFieldViewModeAlways;
            [commonArray addObject:text];
            [text addTarget:self action:@selector(cancleFocus:) forControlEvents:UIControlEventEditingDidEndOnExit];
            text.returnKeyType = UIReturnKeyDone;
            text.backgroundColor = [UIColor whiteColor];
            text.layer.borderColor = [UIColor lightGrayColor].CGColor;
            text.layer.borderWidth = 1.0f;
            text.layer.cornerRadius = 5.0f;
            text.tag = 1002;
            text.enabled = NO;
            text.textColor = [UIColor redColor];
            UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(220, 0, 60, 44)];
            unit.tag = 1003;
            unit.textColor = [UIColor darkGrayColor];
            [cell.contentView addSubview:unit];
            [cell.contentView addSubview:text];
            [cell.contentView addSubview:title];
        }
        else if (indexPath.section==3){
            UIButton *cal = [UIButton buttonWithType:UIButtonTypeCustom];
            [cal setTitle:@"计算" forState:UIControlStateNormal];
            cal.tintColor = [UIColor blueColor];
            [cal setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            [cal setBackgroundImage:[UIImage imageNamed:@"normal.png"] forState:UIControlStateNormal];
            [cal addTarget:self action:@selector(calculate:) forControlEvents:UIControlEventTouchUpInside];
            [cal setFrame:CGRectMake(120, 10, 80, 30)];
            [cell.contentView addSubview:cal];
            [cal.titleLabel setTextColor:MAINCOLOR];
        }
        else if (indexPath.section==4){
            UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 140, 148)];
            imv.tag = 100;
            imv.image = [UIImage imageNamed:@"cylinder_img.png"];
            [cell.contentView addSubview:imv];
            
            UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(150, 0, 170, 150)];
            text.backgroundColor = [UIColor clearColor];
            text.editable = NO;
            text.selectable = NO;
            text.textAlignment = NSTextAlignmentCenter;
            text.tag =101;
            [cell.contentView addSubview:text];
        }
        else{
           // UITableViewCell* cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_"];
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
                det.newsDic = newsDic;
                det.type = @"rec";
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
    if (indexPath.section ==2) {
        UILabel *title = (UILabel*)[cell viewWithTag:1001];
        UITextField *text =(UITextField*)[cell viewWithTag:1002];
        UILabel *unit = (UILabel*)[cell viewWithTag:1003];
        unit.text = @"Gs";
        if (indexPath.row==0) {
            title.text = @"中心表磁";
        }
        else{
            title.text = @"最高表磁";
        }
    }
    else if (indexPath.section==1){
        UILabel *title = (UILabel*)[cell viewWithTag:1001];
        UITextField *text =(UITextField*)[cell viewWithTag:1002];
        UILabel *unit = (UILabel*)[cell viewWithTag:1003];
        NSArray *titleArray;
        NSArray *unitArray;
        if (isrect) {
            titleArray = reTitle;
            unitArray =reUnit;
        }
        else{
            titleArray = cyTitle;
            unitArray =cyUnit;
        }
        title.text = [titleArray objectAtIndex:indexPath.row];
        unit.text = [unitArray objectAtIndex:indexPath.row];
    }
    else if (indexPath.section==4){
        UIImageView *img = (UIImageView*)[cell viewWithTag:100];
        UITextView *tv = (UITextView*)[cell viewWithTag:101];
        tv.textAlignment = NSTextAlignmentLeft;
        if (isrect) {
            img.image = [UIImage imageNamed:@"cuboid_img.png"];
            tv.text =@"使用方法：\n长度尺寸不能小于宽度尺寸；\n测试前先选择材料和性能；\n高度H为充磁方向；\n填写长宽高后可直接计算；\n表磁单位：10GS=1mT；\n计算结果因各厂商材料不一致，计算个别会有误差，结果请以实物测量为准。";
            //[cell.contentView addSubview:rv];
        }
        else{
            img.image = [UIImage imageNamed:@"cylinder_img.png"];
            tv.text =@"使用方法：\n长度尺寸不能小于宽度尺寸；\n测试前先选择材料和性能；\n高度H为充磁方向；\n填写直径和长度后可直接计算；\n表磁单位：10GS=1mT；\n计算结果因各厂商材料不一致，计算个别会有误差，结果请以实物测量为准。";
            //[cell.contentView addSubview:cy];
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section<4) {
        return 40;
    }
    else{
        return 150;
    }
}
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(void)cancleFocus:(id)sender{
    [sender resignFirstResponder];
}
-(void)calculate:(UIButton*)sender{
    if (isrect) {
        double L = [[((UITextField*)[textArray objectAtIndex:1]) text] floatValue];
        double W = [[((UITextField*)[textArray objectAtIndex:2]) text] floatValue];
        double Br = [[((UITextField*)[textArray objectAtIndex:0]) text] floatValue];
        double H = [[((UITextField*)[textArray objectAtIndex:3]) text] floatValue];
        
       // [Managet validParam:textArray Num:4];
        
        double a = [Managet calCube:0 :L :W :H :Br];
        double b = [Managet getMaxCube:0 :L :W :H :Br];
        [((UITextField*)[commonArray objectAtIndex:0]) setText: [NSString stringWithFormat:@"%.3f",a]];
        [((UITextField*)[commonArray objectAtIndex:1]) setText: [NSString stringWithFormat:@"%.3f",b]];
        
    }
    else{
        /**
         * 圆形磁铁表磁计算公式mm version
         * 英寸计算：1英寸=25.4mm
         * @param Z(X) 磁感应距离 (mm) 磁感应距离是磁铁与被磁化的距离，表磁可以设置为0
         * @param D 磁铁直径 (mm)
         * @param L 磁铁长度 (mm)
         * @param Br 剩磁Br(Gauss)magnet
         * @return 返回高斯
         */
       //double a = [Managet calcylinderByBr:1 :2 :2 :11900];
        //NSLog(@"%f",a);
        double D = [[((UITextField*)[textArray objectAtIndex:1]) text] floatValue];
        double L = [[((UITextField*)[textArray objectAtIndex:2]) text] floatValue];
        double Br = [[((UITextField*)[textArray objectAtIndex:0]) text] floatValue];
        double a = [Managet calcylinderByBr:1 :D :L :Br];
        double b = [Managet getMaxCylinderByBr:1 :D :L :Br];
        [((UITextField*)[commonArray objectAtIndex:0]) setText: [NSString stringWithFormat:@"%.3f",a]];
        [((UITextField*)[commonArray objectAtIndex:1]) setText: [NSString stringWithFormat:@"%.3f",b]];
}
}

-(UIPickerView*)getPickView{
    UIPickerView *pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-160, 320, 200)];
    pick.backgroundColor = [UIColor darkGrayColor];
    pick.delegate = self;
    return pick;
}
#pragma mark -- pickview delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == materialPicker) {
        return 3;
    }
    else {
        NSString *mati = matiBtn.titleLabel.text;
        if ([mati isEqualToString:@"钕铁硼"]) {
            return 8;
        }
        else if([mati isEqualToString:@"铁氧体"]){
            return 3;
        }
        else
            return 4;
    }
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
    v.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
    label.textColor = MAINCOLOR;
    if (pickerView ==materialPicker) {
            label.text = [materialArray objectAtIndex:row];
        }
    else{
        if ([matiBtn.titleLabel.text isEqualToString:@"钕铁硼"]) {
            label.text =[nvtiepengArray objectAtIndex:row] ;
        }
        else if ([matiBtn.titleLabel.text isEqualToString:@"铁氧体"]){
            label.text =[feArray objectAtIndex:row] ;
        }
        else{
            label.text =[shanArray objectAtIndex:row] ;
        }
    }
    label.textAlignment = NSTextAlignmentCenter;
    [v addSubview:label];
    return v;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 60;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == materialPicker) {
      //  matiBtn.titleLabel.text = [materialArray objectAtIndex:row];
        [matiBtn setTitle:[materialArray objectAtIndex:row] forState:UIControlStateNormal];
        if ([matiBtn.titleLabel.text isEqualToString:@"钕铁硼"]) {
            [detaiBtn setTitle:@"N35" forState:UIControlStateNormal];
        }
        else if ([matiBtn.titleLabel.text isEqualToString:@"铁氧体"]){
             [detaiBtn setTitle:@"Y25" forState:UIControlStateNormal];
        }
        else{
            [detaiBtn setTitle:@"26" forState:UIControlStateNormal];
        }
    }
    else {
        if ([matiBtn.titleLabel.text isEqualToString:@"钕铁硼"]) {
            [detaiBtn setTitle:[nvtiepengArray objectAtIndex:row] forState:UIControlStateNormal];
        }
        else if ([matiBtn.titleLabel.text isEqualToString:@"铁氧体"]){
            [detaiBtn setTitle:[feArray objectAtIndex:row] forState:UIControlStateNormal];
        }
        else{
            [detaiBtn setTitle:[shanArray objectAtIndex:row] forState:UIControlStateNormal];
        }
    }
    [detailPicker reloadAllComponents];
    //[materialPicker reloadAllComponents];
    NSString *key = [NSString stringWithFormat:@"%@%@",matiBtn.titleLabel.text,detaiBtn.titleLabel.text];
    UITextField *tf = [textArray objectAtIndex:0];
    tf.text = [coefficient valueForKey:key];
}
#pragma mark -- btn event
-(void)showDetail:(UIButton*)sender{
    materialPicker.hidden = YES;
    if (detailPicker == nil) {
       // detailPicker = [self getPickView];
        detailPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height+60, sender.frame.size.width, 60)];
        detailPicker.delegate = self;
        detailPicker.backgroundColor =[UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1];
        detailPicker.layer.borderWidth = 1.0f;
        detailPicker.layer.borderColor = [UIColor lightGrayColor].CGColor;
        detailPicker.layer.cornerRadius = 5.0f;
        [self.view addSubview:detailPicker];
        return;
    }
    detailPicker.hidden = !detailPicker.hidden;
}
-(void)showMaterial:(UIButton*)sender{
    detailPicker.hidden = YES;
    if (materialPicker == nil) {
        //materialPicker = [self getPickView];
        materialPicker =  [[UIPickerView alloc] initWithFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height+60, sender.frame.size.width, 30)];
        materialPicker.delegate = self;
        materialPicker.backgroundColor =[UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1];
        materialPicker.layer.borderWidth = 1.0f;
        materialPicker.layer.borderColor = [UIColor lightGrayColor].CGColor;
        materialPicker.layer.cornerRadius = 5.0f;
        [self.view addSubview:materialPicker];
        return;
    }
    materialPicker.hidden = !materialPicker.hidden;
    
}
@end
