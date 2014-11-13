//
//  BaseParam.m
//  WinLottery
//
//  Created by jz on 14-11-12.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import "BaseParam.h"

@implementation BaseParam
@synthesize retname,cbselecor,cbtarget,paramsArray,requestselector,desClass=desClass;

-(id)initWithTarget:(id)target Cbselector:(SEL)selename Requestclass:(NSString*)classname Requestselector:(NSString *)reselector Rename:(NSString *)rename Params:(NSMutableArray *)param{
    
    self = [super init];
    if (self) {
        cbtarget = target;
        cbselecor = selename;
        requestselector = NSSelectorFromString(reselector);
        desClass = NSClassFromString(classname);
        retname = rename;
        paramsArray = param;
    }
    return self;
}
-(id)initWithTarget:(id)target Cbselector:(SEL)selename Classname:(NSString*)classname Requestname:(NSString*)request Params:(NSMutableArray *)param{
    self = [super init];
    if (self) {
        cbtarget = target;
        cbselecor = selename;
        desClass = NSClassFromString(classname);
        requestselector = NSSelectorFromString(request);
        //retname = [NSString stringWithFormat:@"%@Return",rootname];
        paramsArray = param;
    }
    return self;
}
@end
