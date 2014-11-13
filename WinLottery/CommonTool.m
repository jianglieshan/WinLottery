//
//  CommonTool.m
//  WinLottery
//
//  Created by jz on 14-11-12.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import "CommonTool.h"
#import <CommonCrypto/CommonDigest.h>
@implementation CommonTool

//md5 32位 加密 （小写）
/*  这个加密有问题
+ (NSString *)md532:(NSString *)str {
    
    
    
    const char *cStr = [str UTF8String];
    
    
    
    unsigned char result[32];
    
    
    
    CC_MD5( cStr, strlen(cStr), result );
    
    
    
    return [NSString stringWithFormat:
            
            
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15],
            
            result[16], result[17],result[18], result[19],
            
            result[20], result[21],result[22], result[23],
            
            result[24], result[25],result[26], result[27],
            
            result[28], result[29],result[30], result[31]];
    
}
*/
//md5 16位加密 （大写）
+ (NSString *)md516:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}
@end
