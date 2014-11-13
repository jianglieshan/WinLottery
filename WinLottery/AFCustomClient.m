//
//  AFCustomClient.m
//
//
//  Created by jiangzheng on 14-7-15.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//
#import "TSocketClient.h"
#import "TBinaryProtocol.h"
#import "uapp.h"
#import "AFCustomClient.h"
@implementation AFCustomClient
+ (AFCustomClient *)sharedClient {
    static AFCustomClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFCustomClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    return _sharedClient;
}
-(void)newsCountbyId:(NSString *)newsId Type:(NSString *)type{
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:UUID,@"deviceId",type,@"type",newsId,@"id", @"",@"imsi",nil];
    [self postPath:MAKEPATH(@"Hits.jsp") parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",[responseObject objectFromJSONData]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)testThrift{
    TSocketClient *transport = [[TSocketClient alloc] initWithHostname:@"www.510cai.com" port:9090];
    TBinaryProtocol *protocol = [[TBinaryProtocol alloc] initWithTransport:transport strictRead:YES strictWrite:YES];
    UappServiceClient *client= [[UappServiceClient alloc] initWithProtocol:protocol];
    VerifyCodeRespBean*result = [client getVerifyCode:UUID];
    NSLog(@"%@",result.result.msg);
    
}
@end
