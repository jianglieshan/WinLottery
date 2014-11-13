//
//  CommonNetRequest.m
//  WinLottery
//
//  Created by jz on 14-11-12.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//
#import "CommonNetClient.h"
#import "TSocketClient.h"
#import "TBinaryProtocol.h"
@implementation CommonNetClient{
    NSString *access_token_;
}
@synthesize user;
+(instancetype)shareNetClient{
    static CommonNetClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CommonNetClient alloc] init];
        
    });
    return _sharedClient;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        netRequestQueue = [[NSOperationQueue alloc] init];
        netRequestQueue.maxConcurrentOperationCount = 2;
        
    }
    return  self;
}
-(UappServiceClient*)creatServiceClient{
    TSocketClient *transport = [[TSocketClient alloc] initWithHostname:@"www.510cai.com" port:9090];
    TBinaryProtocol *protocol = [[TBinaryProtocol alloc] initWithTransport:transport strictRead:YES strictWrite:YES];
    return  [[UappServiceClient alloc] initWithProtocol:protocol];
}

-(void)addSelector:(SEL)selector WithParam:(BaseParam*)param{
    NSInvocationOperation *opration = [[NSInvocationOperation alloc] initWithTarget:self selector:selector object:param];
    [netRequestQueue addOperation:opration];
    //[NSThread detachNewThreadSelector:selector toTarget:self withObject:param];
    
}
-(void)getVerifyCodeByDeviceId:(NSString*)deviceid{
    UappServiceClient *client = [self creatServiceClient];
    
    VerifyCodeRespBean*result = [client getVerifyCode:deviceid];
    NSLog(@"%@",result.result.msg);
    [self performSelectorOnMainThread:nil withObject:nil waitUntilDone:NO];
}


-(void)commonDataRequest:(BaseParam *)param{
    __unsafe_unretained id returnValue = nil;
    @try {
        UappServiceClient *client = [self creatServiceClient];
        //returnValue = [client getVerifyCode:@"12321"];
        
        //id request = [[NSClassFromString([param objectForKey:@"requestname"]) alloc] init];
        //id request = [[param.desClass alloc] init];

        //方法签名类，需要被调用消息所属的类AsynInvoke ,被调用的消息invokeMethod:
        
        NSMethodSignature *sig= [[client class] instanceMethodSignatureForSelector:param.requestselector];
        //根据方法签名创建一个NSInvocation
        NSInvocation *invocation=[NSInvocation invocationWithMethodSignature:sig];
        //设置调用者也就是AsynInvoked的实例对象，在这里我用self替代
        [invocation setTarget:client];
        //设置被调用的消息
        [invocation setSelector:param.requestselector];
        for (int i =2;i<param.paramsArray.count+2;i++) {
            id item = [param.paramsArray objectAtIndex:i-2];
            [invocation setArgument:&item atIndex:i];
        }
        //[invocation setArgument:&argument1 atIndex:2];//设置参数，第一个参数index为2
       // [invocation setArgument:&argument2 atIndex:3];
        [invocation retainArguments];//retain一遍参数
        [invocation invoke];//调用
       // [invocation getReturnValue:&retData];//得到返回值，此时不会再调用，只是返回值
        
        //获得返回值类型
        
        const char *returnType = sig.methodReturnType;
        
        //声明返回值变量
        
        //如果没有返回值，也就是消息声明为void，那么returnValue=nil
        if( !strcmp(returnType, @encode(void)) ){
            returnValue =  nil;
        }
        //如果返回值为对象，那么为变量赋值
        else if( !strcmp(returnType, @encode(id)) ){
            [invocation getReturnValue:&returnValue];
        }
        else{
            //如果返回值为普通类型NSInteger  BOOL
            //返回值长度
            NSUInteger length = [sig methodReturnLength];
            //根据长度申请内存
            void *buffer = (void *)malloc(length);
            //为变量赋值
            [invocation getReturnValue:buffer];
            if( !strcmp(returnType, @encode(BOOL)) ) {
                returnValue = [NSNumber numberWithBool:*((BOOL*)buffer)];
            }
            else if( !strcmp(returnType, @encode(NSInteger)) ){
                returnValue = [NSNumber numberWithInteger:*((NSInteger*)buffer)];
            }
            returnValue = [NSValue valueWithBytes:buffer objCType:returnType];
        }
    }
    @catch (NSException *exception) {
        returnValue=@"请求服务端连接失败，请稍后再试";
    }
    @finally {
        [param.cbtarget performSelectorOnMainThread:param.cbselecor withObject:returnValue waitUntilDone:NO];
    }
}
@end
