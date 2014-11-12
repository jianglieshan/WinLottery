//
//  AFCustomClient.h
//  calculator
//
//  Created by jiangzheng on 14-7-15.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import "AFHTTPClient.h"
#import "JSONKit.h"
#import  "MBProgressHUD.h"
@interface AFCustomClient : AFHTTPClient
+ (AFCustomClient *)sharedClient;
-(void)newsCountbyId:(NSString*)newsId Type:(NSString*)type;
-(void)testThrift;
@end
