//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Yingyu on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <math.h>

#define clearBtn	1	// C
#define backBtn		2	// ←

#define plusBtn     3	// +
#define subBtn      4	// -
#define mulBtn      5	// x
#define divBtn      6	// ÷
#define sqrXBtn		7	// xⁿ
#define radsigXBtn	8	// ⁿ√x
#define equalBtn    9	// =

#define dotBtn      10	// .
#define signBtn     11	// +/-

#define sqr2Btn		12	// x²
#define radsig2Btn	13	// √x
#define logeBtn		14	// ln
#define log10Btn	15	// log
#define expBtn		16	// eⁿ
#define tensqrBtn	17	// 10ⁿ
#define percBtn		18	// %
#define fracBtn		19	// 1/x

#define cptBtn      20	// CPT
#define nBtn        21	// N
#define iyBtn       22	// I/Y
#define pvBtn       23	// PV
#define pmtBtn      24	// PMT
#define fvBtn       25	// FV

#define cfBtn       26	// CF
#define npvBtn      27	// NPV
#define irrBtn      28	// IRR
#define amortBtn	29	// AMORT
#define enterBtn    30	// ENTER
#define upBtn		31	// ↑
#define	downBtn		32	// ↓

#define mrBtn		33	// mr
#define mplusBtn	34	// m+
#define msubBtn		35	// m-
#define secBtn		36	// 2nd

#define clrtvmBtn	37	// CLR TVM
#define clrcfBtn	38	// CLR CF

@interface CalculatorViewController : UIViewController {
	
	UITextField *display;
	UILabel *showFoperator;
	UILabel *showSpecial;
	UIButton *sqrXButton;
	UIButton *radsigXButton;
	UIButton *expButton;
	UIButton *tensqrButton;
	UIButton *fracButton;
	UIButton *msubButton;
	UIButton *clrtvmButton;
	UIButton *clrcfButton;
	
	BOOL bBegin;
	BOOL backOpen;
	BOOL cptOpen;
	BOOL secOpen;
	
	double fstOperand;
	double sumOperand;
	double tvmOperand;
	double mrOperand;
	
	double tvN,tvIy,tvPv,tvPmt,tvFv;
	
	NSString *operator;
}

@property (nonatomic, retain) IBOutlet UITextField *display;
@property (nonatomic, retain) IBOutlet UILabel *showFoperator;
@property (nonatomic, retain) IBOutlet UILabel *showSpecial;
@property (nonatomic, retain) IBOutlet UIButton	*sqrXButton;
@property (nonatomic, retain) IBOutlet UIButton	*radsigXButton;
@property (nonatomic, retain) IBOutlet UIButton	*expButton;
@property (nonatomic, retain) IBOutlet UIButton	*tensqrButton;
@property (nonatomic, retain) IBOutlet UIButton	*fracButton;
@property (nonatomic, retain) IBOutlet UIButton	*msubButton;
@property (nonatomic, retain) IBOutlet UIButton *clrtvmButton;
@property (nonatomic, retain) IBOutlet UIButton *clrcfButton;

- (void)clearDisplay;								// 初始化清屏方法声明
- (void)backSpace;									// 退格方法声明

- (void)inputDoubleOperator: (NSString *)dbopt;		// 双操作数运算方法声明

- (void)addDot;										// 增加.方法声明
- (void)addSign;									// 增加+/-方法声明

- (void)inputSingleOperator: (NSString *)sgopt;		// 单操作数运算方法声明

- (void)cptOperator;								// CPT求值方法声明
- (void)inputTimeValueOperator: (NSString *)tvopt;	// tv金融运算方法声明

- (void)numberMemory: (NSString *)nmopt;			// 操作数保留方法声明

- (void)secKey;										// 2nd切换按键方法声明

- (void)clearTvm;									// 清空tvm变量方法声明
- (void)clearCf;									// 清空cf变量方法声明

- (void)inputNumber: (NSString *)nbstr;				// 数字输入方法声明

- (IBAction)buttonClicked:(id)sender;				// 按键管理事件声明

@property (retain, nonatomic) IBOutlet UIButton *CPTBtn;
@property (retain, nonatomic) IBOutlet UIButton *upBtn_;
@property (retain, nonatomic) IBOutlet UIButton *downBtn_;
@property (retain, nonatomic) IBOutlet UIButton *leftBtn_;
@property (retain, nonatomic) IBOutlet UIButton *sqartBtn_;
@property (retain, nonatomic) IBOutlet UIButton *percentBtn_;
@property (retain, nonatomic) IBOutlet UIButton *mPlusBtn_;
@property (retain, nonatomic) IBOutlet UIButton *pingfangBtn_;
@property (retain, nonatomic) IBOutlet UIButton *lnBtn_;
@property (retain, nonatomic) IBOutlet UIButton *logBtn_;
@end

