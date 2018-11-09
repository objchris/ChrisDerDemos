//
//  HMacActor.m
//  PKIDemo
//
//  Created by Netca on 16/4/22.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "HMacActor.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation HMacActor

- (NSString *)HMacSHA1WithKey:(NSString *)key data:(NSString *)data {
    
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMac[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMac);
    
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
    for(int i = 0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X",cHMac[i]];
    }
    
    return [hash copy];
}

- (NSString *)HMacMD5WithKey:(NSString *)key data:(NSString *)data {
    
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMac[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, cKey, strlen(cKey), cData, strlen(cData), cHMac);
    
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X",cHMac[i]];
    }
    
    return [hash copy];
}

@end
