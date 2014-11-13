//
//  CommonNetRequest.h
//  WinLottery
//
//  Created by jz on 14-11-12.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "uapp.h"
#import "BaseParam.h"
@interface CommonNetClient : NSObject
{
    NSOperationQueue *netRequestQueue;
}
@property (nonatomic,strong)UserBean *user;
+(instancetype)shareNetClient;
-(void)addSelector:(SEL)selector WithParam:(BaseParam*)param;
-(void)commonDataRequest:(BaseParam *)param;
@end

