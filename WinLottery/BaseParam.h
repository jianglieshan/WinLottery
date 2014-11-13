//
//  BaseParam.h
//  WinLottery
//
//  Created by jz on 14-11-12.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseParam : NSObject{
    id cbtarget;
    SEL cbselecor;
    SEL requestselector;
    NSString *retname;
    NSMutableArray *paramsArray;
    __weak Class desClass;
}
@property  (nonatomic,strong) NSString* retname;
@property  (nonatomic) SEL cbselecor;
@property  (nonatomic) SEL requestselector;
@property  (nonatomic,strong) id cbtarget;
@property  (nonatomic,strong) NSMutableArray *paramsArray;
@property  (nonatomic,weak) Class desClass;

-(id)initWithTarget:(id)target Cbselector:(SEL)selename Requestclass:(NSString*)classname Requestselector:(NSString *)reselector Rename:(NSString *)rename Params:(NSMutableDictionary *)param;
-(id)initWithTarget:(id)target Cbselector:(SEL)selename Classname:(NSString*)classname Requestname:(NSString*)request Params:(NSMutableArray *)param;
@end
