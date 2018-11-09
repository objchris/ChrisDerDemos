//
//  DigestDemo.m
//  PKIDemo
//
//  Created by ezfen on 16/4/7.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "DigestActor.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation DigestActor

# pragma mark - MD5
- (NSData *)dataByMD5Digest:(NSString *)stringToDigest {
    NSData *dataToDigest = [stringToDigest dataUsingEncoding:NSUTF8StringEncoding];
    UInt8 hash[CC_MD5_DIGEST_LENGTH];
    CC_MD5([dataToDigest bytes], (CC_LONG)[dataToDigest length], hash);
    return [NSData dataWithBytes:hash length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)stringByMD5Digest:(NSString *)stringToDigest {
    NSData *dataToDigest = [stringToDigest dataUsingEncoding:NSUTF8StringEncoding];
    UInt8 hash[CC_MD5_DIGEST_LENGTH];
    CC_MD5([dataToDigest bytes], (CC_LONG)[dataToDigest length], hash);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",hash[i]];
    }
    return [ret copy];
}

# pragma mark - SHA1
- (NSData *)dataBySHA1Digest:(NSString *)stringToDigest {
    NSData *dataToDigest = [stringToDigest dataUsingEncoding:NSUTF8StringEncoding];
    UInt8 hash[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1([dataToDigest bytes], (CC_LONG)[dataToDigest length], hash);
    return [NSData dataWithBytes:hash length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)stringBySHA1Digest:(NSString *)stringToDigest {
    NSData *dataToDigest = [stringToDigest dataUsingEncoding:NSUTF8StringEncoding];
    UInt8 hash[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1([dataToDigest bytes], (CC_LONG)[dataToDigest length], hash);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
    for(int i = 0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",hash[i]];
    }
    return [ret copy];
}

# pragma mark - SHA1
- (NSData *)dataBySHA256Digest:(NSString *)stringToDigest {
    NSData *dataToDigest = [stringToDigest dataUsingEncoding:NSUTF8StringEncoding];
    UInt8 hash[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([dataToDigest bytes], (CC_LONG)[dataToDigest length], hash);
    return [NSData dataWithBytes:hash length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)stringBySHA256Digest:(NSString *)stringToDigest {
    NSData *dataToDigest = [stringToDigest dataUsingEncoding:NSUTF8StringEncoding];
    UInt8 hash[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([dataToDigest bytes], (CC_LONG)[dataToDigest length], hash);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",hash[i]];
    }
    return [ret copy];
}



@end
