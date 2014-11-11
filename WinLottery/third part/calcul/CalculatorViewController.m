//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Yingyu on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

@synthesize display;
@synthesize showFoperator;
@synthesize showSpecial;
@synthesize sqrXButton;
@synthesize radsigXButton;
@synthesize expButton;
@synthesize tensqrButton;
@synthesize fracButton;
@synthesize msubButton;
@synthesize clrtvmButton;
@synthesize clrcfButton;


// 初始化计算器
- (void)viewDidLoad 
{
   // [self.navigationController setNavigationBarHidden:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;

	display.text = @"";
	showFoperator.text = @"";
	showSpecial.text = @"";
	operator = @"=";
	fstOperand = 0;
	sumOperand = 0;
	tvN = 0; tvIy = 0; tvPv = 0; tvPmt = 0; tvFv = 0;
	bBegin = YES;
	cptOpen = NO;
	secOpen = NO;
}

// 按键事件处理
-(IBAction)buttonClicked:(id)sender 
{
	UIButton *btn = (UIButton *)sender;
	int tag = btn.tag;
	
	switch (tag) 
	{
		// 初始化清屏
		case clearBtn:	// C    1
			[self clearDisplay];
			break;
		
		// 退格
		case backBtn:	// ←    2
			[self backSpace];
			break;

		// 双操作数运算符
		case plusBtn:	// +    3
		case subBtn:	// -    4
		case mulBtn:	// x    5
		case divBtn:	// ÷    6
		case sqrXBtn:	// yⁿ   7
		case radsigXBtn:// ⁿ√y  8
		case equalBtn:	// =    9
			[self inputDoubleOperator:btn.titleLabel.text];
			break;
			
		// 增加小数点
		case dotBtn:	// .    10
			[self addDot];
			break;
			
		// 增加正负号
		case signBtn:	// +/-  11
			[self addSign];
			break;
			
		// 单操作数运算符
		case sqr2Btn:	// x²   12
		case radsig2Btn:	// √x	13
		case logeBtn:	// ln	14
		case log10Btn:	// log	15
		case expBtn:		// eⁿ	16
		case tensqrBtn:	// 10ⁿ	17
		case percBtn:	// %	18
		case fracBtn:	// 1/x	19
			[self inputSingleOperator:btn.titleLabel.text];
			break;
		
		// 求金融运算值
		case cptBtn:	// CPT  20
			[self cptOperator];
			break;
			
		// tv金融运算符	
		case nBtn:		// N    21
		case iyBtn:		// I/Y  22
		case pvBtn:		// PV   23
		case pmtBtn:	// PMT  24
		case fvBtn:		// FV   25
			[self inputTimeValueOperator:btn.titleLabel.text];
			break;
			
		// 操作数保留
		case mrBtn:		// mr   33
		case mplusBtn:	// m+   34
		case msubBtn:	// m-   35
			[self numberMemory:btn.titleLabel.text];
			break;
			
		// 2nd切换按键
		case secBtn:	// 2nd	36
			[self secKey];
			break;
			
		// 清空tvm变量
		case clrtvmBtn:	// CLR TVM  37
			[self clearTvm];
			break;
			
		// 清空tvm变量
		case clrcfBtn:	// CLR CF   38
			[self clearCf];
			break;

		// 数字分支
		default:
			[self inputNumber:btn.titleLabel.text];
			break;
	}
}

// C方法
- (void)clearDisplay
{
	display.text = @"";
	showFoperator.text = @"C";
	operator = @"=";
	fstOperand = 0;
	sumOperand = 0;
	bBegin = YES;
	cptOpen = NO;
}

// ←方法
- (void)backSpace
{
	showFoperator.text = @"←";
	
	if (backOpen) 
	{
		if (display.text.length == 1)
		{
			display.text = @"";
		}
		else if (![display.text isEqualToString:@""])
		{
			display.text = [display.text substringToIndex:display.text.length -1];
		}
	}
}

// 双操作数运算方法 
- (void)inputDoubleOperator: (NSString *)dbopt
{
	showFoperator.text = dbopt;
	backOpen = NO;
	
	if(![display.text isEqualToString:@""])
	{
		fstOperand = [display.text doubleValue];
		
		if(bBegin)
		{
			operator = dbopt;
		}
		else
		{           
			if([operator isEqualToString:@"="])
			{
				sumOperand = fstOperand;
			}
			else if([operator isEqualToString:@"+"])
			{
				sumOperand += fstOperand;
				display.text = [NSString stringWithFormat:@"%g",sumOperand];
			}
			else if([operator isEqualToString:@"-"])
			{
				sumOperand -= fstOperand;
				display.text = [NSString stringWithFormat:@"%g",sumOperand];
			}
			else if([operator isEqualToString:@"x"])
			{
				sumOperand *= fstOperand;
				display.text = [NSString stringWithFormat:@"%g",sumOperand];
			}
			else if([operator isEqualToString:@"÷"])
			{
				if(fstOperand!= 0)
				{
					sumOperand /= fstOperand;
					display.text = [NSString stringWithFormat:@"%g",sumOperand];
				}
				else
				{
					display.text = @"nan";
					operator= @"=";
				}
			}
			else if ([operator isEqualToString:@"xⁿ"])
			{
				sumOperand = pow(sumOperand, fstOperand);
				display.text = [NSString stringWithFormat:@"%g",sumOperand];
			}
			else if ([operator isEqualToString:@"ⁿ√x"])
			{
				sumOperand = pow(sumOperand, 1/fstOperand);
				display.text = [NSString stringWithFormat:@"%g",sumOperand];
			}
			
			bBegin= YES;
			operator= dbopt;
		}
	}
}

// 增加.方法
- (void)addDot
{
	showFoperator.text = @".";
	
	if(![display.text isEqualToString:@""] && ![display.text isEqualToString:@"-"])
	{
		NSString *currentStr = display.text;
		BOOL notDot = ([display.text rangeOfString:@"."].location == NSNotFound);
		if (notDot) 
		{
			currentStr= [currentStr stringByAppendingString:@"."];
			display.text= currentStr;
		}
	}
}

// 增加+/-方法
- (void)addSign
{
	showFoperator.text = @"+/-";
	
	if(![display.text isEqualToString:@""] && ![display.text isEqualToString:@"0"] && ![display.text isEqualToString:@"-"])
	{
		double number = [display.text doubleValue];
		number = number*(-1);
		display.text= [NSString stringWithFormat:@"%g",number];
		
		if(bBegin)
		{
			sumOperand = number;
		}
	}    
}

// 单操作数运算方法
- (void)inputSingleOperator: (NSString *)sgopt
{
	showFoperator.text = sgopt;
	backOpen = NO;
	
	if(![display.text isEqualToString:@""])
	{
		operator = sgopt;
		fstOperand = [display.text doubleValue];
		
		if([operator isEqualToString:@"x²"])
		{
			sumOperand = pow(fstOperand , 2);
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"√x"])
		{
			sumOperand = sqrt(fstOperand);
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"ln"])
		{
			sumOperand = log(fstOperand);
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"log"])
		{
			sumOperand = log10(fstOperand);
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"eⁿ"])
		{
			sumOperand = exp(fstOperand);
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"10ⁿ"])
		{
			sumOperand = pow(10 , fstOperand);
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"%"])
		{
			sumOperand = fstOperand / 100;
			display.text= [NSString stringWithFormat:@"%g",sumOperand];
		}
		else if([operator isEqualToString:@"1/x"])
		{
			if (fstOperand!= 0)
			{
				sumOperand = 1 / fstOperand;
				display.text= [NSString stringWithFormat:@"%g",sumOperand];
			}
			else 
			{
				display.text = @"nan";
			}
		}
		bBegin = YES;
	}
}

// cpt求值方法
- (void)cptOperator
{
	showFoperator.text = @"CPT";
	cptOpen = YES;
}

//金融运算方法
- (void)inputTimeValueOperator: (NSString *)tvopt
{
	showFoperator.text = tvopt;
	showFoperator.text = [showFoperator.text stringByAppendingString:@"="];
	operator = tvopt;
	backOpen = NO;

	if (cptOpen) 
	{
		if([operator isEqualToString:@"N"])
		{
			tvmOperand = (log(((tvFv * tvIy - tvPmt) / ((- tvPv * tvIy) - tvPmt)))) / (log(1 + tvIy));
		}
		else if([operator isEqualToString:@"I/Y"])
		{
			
		}
		else if([operator isEqualToString:@"PMT"])
		{
			tvmOperand = (-tvPv - tvFv/pow(1 + tvIy/100, tvN))/((1 - 1/pow(1 + tvIy/100, tvN))/(tvIy/100));
		}
		else if([operator isEqualToString:@"PV"])
		{
			tvmOperand = -(tvFv/pow(1 + tvIy/100, tvN) + (1 - 1/pow(1 + tvIy/100, tvN))/(tvIy/100) * tvPmt);
		}
		else if([operator isEqualToString:@"FV"])
		{
			tvmOperand = (-tvPv - (1 - 1/pow(1 + tvIy/100, tvN))/(tvIy/100) * tvPmt) * pow(1 + tvIy/100, tvN);
		}
		
		display.text= [NSString stringWithFormat:@"%g",tvmOperand]; 
		cptOpen = NO;
	}
	else 
	{
		if(![display.text isEqualToString:@""])
		{
			if([operator isEqualToString:@"N"])
			{
				if (fstOperand >= 0) 
				{
					tvN = [display.text doubleValue];
				}
				else
				{
					display.text = @"nan";
				}
			}
			else if([operator isEqualToString:@"I/Y"])
			{
				tvIy = [display.text doubleValue];
			}
			else if([operator isEqualToString:@"PMT"])
			{
				tvPmt = [display.text doubleValue];
			}
			else if([operator isEqualToString:@"PV"])
			{
				tvPv = [display.text doubleValue];
			}
			else if([operator isEqualToString:@"FV"])
			{
				tvFv = [display.text doubleValue];
			}
		}		
	}
	bBegin = YES;
}

// 操作数保留方法
- (void)numberMemory: (NSString *)nmopt
{
	showFoperator.text = nmopt;
	operator = nmopt;
	
	if([operator isEqualToString:@"mr"])
	{
		[self inputNumber:[NSString stringWithFormat:@"%g",mrOperand]];
	}
	else if([operator isEqualToString:@"m+"])
	{
		mrOperand = [display.text doubleValue];
	}
	else if([operator isEqualToString:@"m-"])
	{
		mrOperand = 0;
	}
}

// 2nd切换方法
- (void)secKey
{
	if (secOpen) 
	{
		showSpecial.text = @"";
		secOpen = NO;
		sqrXButton.hidden = YES;
		radsigXButton.hidden = YES;
		expButton.hidden = YES;
		tensqrButton.hidden = YES;
		fracButton.hidden = YES;
		msubButton.hidden = YES;
		clrtvmButton.hidden = YES;
		clrcfButton.hidden = YES;
        
        _CPTBtn.hidden = NO;
        _upBtn_.hidden = NO;
        _downBtn_.hidden = NO;
        _leftBtn_.hidden = NO;
        _sqartBtn_.hidden = NO;
        _percentBtn_.hidden = NO;
        _mPlusBtn_.hidden = NO;
        _pingfangBtn_.hidden = NO;
        _lnBtn_.hidden = NO;
        _logBtn_.hidden = NO;
        
	}
	else
	{
		showSpecial.text = @"2nd";
		secOpen = YES;
		sqrXButton.hidden = NO;
		radsigXButton.hidden = NO;
		expButton.hidden = NO;
		tensqrButton.hidden = NO;
		fracButton.hidden = NO;
		msubButton.hidden = NO;
		clrtvmButton.hidden = NO;
		clrcfButton.hidden = NO;
        
        _CPTBtn.hidden = YES;
        _upBtn_.hidden = YES;
        _downBtn_.hidden = YES;
        _leftBtn_.hidden = YES;
        _sqartBtn_.hidden = YES;
        _percentBtn_.hidden = YES;
        _mPlusBtn_.hidden = YES;
        _pingfangBtn_.hidden = YES;
        _lnBtn_.hidden = YES;
        _logBtn_.hidden = YES;
	}
}

// 清空tvm变量方法
- (void)clearTvm
{
	showFoperator.text = @"CLR TVM";
	tvN = 0; tvIy = 0; tvPv = 0; tvPmt = 0; tvFv = 0;
}

// 清空cf变量方法
- (void)clearCf
{
	showFoperator.text = @"CLR CF";
}

// 数字输入方法
- (void)inputNumber: (NSString *)nbstr
{	
	backOpen = YES;
	cptOpen = NO;
	
	if(bBegin)
	{
		showFoperator.text = @"";
        if ([nbstr isEqualToString:@"π"]) {
            display.text = [NSString stringWithFormat:@"%6f",M_PI];
        }
        else
            display.text = nbstr;
	}
	else
	{
		display.text = [display.text stringByAppendingString:nbstr];
	}
	bBegin = NO;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.display = nil;
	self.showFoperator = nil;
	self.showSpecial = nil;
	self.sqrXButton = nil;
	self.radsigXButton = nil;
	self.expButton = nil;
	self.tensqrButton = nil;
	self.fracButton = nil;
	self.msubButton = nil;
	self.clrtvmButton = nil;
	self.clrcfButton = nil;
}


- (void)dealloc {
	[display release];
	[showFoperator release];
	[showSpecial release];
	[sqrXButton release];
	[radsigXButton release];
	[expButton release];
	[tensqrButton release];
	[fracButton release];
	[msubButton release];
	[clrtvmButton release];
	[clrcfButton release];
    [super dealloc];
}

@end
