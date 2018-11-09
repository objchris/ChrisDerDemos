//
//  PwdCipherActor.m
//  PKIDemo
//
//  Created by ezfen on 16/4/12.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "PwdCipherActor.h"
#import "GTMBase64.h"

@implementation PwdCipherActor

- (NSData *)generateKeyWithPassword:(NSString *)password andSalt:(NSData *)salt andIterating:(int)numIterations {
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    memset(md5, 0, CC_MD5_DIGEST_LENGTH);
    NSData* passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    
    CC_MD5_CTX ctx;
    CC_MD5_Init(&ctx);
    CC_MD5_Update(&ctx, [passwordData bytes], [passwordData length]);
    CC_MD5_Update(&ctx, [salt bytes], [salt length]);
    CC_MD5_Final(md5, &ctx);
    
    for (int i=1; i<numIterations; i++) {
        CC_MD5(md5, CC_MD5_DIGEST_LENGTH, md5);
    }
    
    return [NSData dataWithBytes:md5 length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)DESEncrypt:(NSString *)plainText withPwdKey:(NSData *)pwdKey{
    NSData *plainData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [self symCrypt:kCCEncrypt processData:plainData UsingAlgorithm:kCCAlgorithmDES key:pwdKey initalizationVector:nil options:kCCOptionPKCS7Padding | kCCOptionECBMode];
    return [GTMBase64 stringByEncodingData:result];
}

- (NSString *)DESDecrypt:(NSString *)cipherText withPwdKey:(NSData *)pwdKey {
    NSData *cipherData = [GTMBase64 decodeString:cipherText];
    NSData *result = [self symCrypt:kCCDecrypt processData:cipherData UsingAlgorithm:kCCAlgorithmDES key:pwdKey
                initalizationVector:nil options:kCCOptionPKCS7Padding | kCCOptionECBMode];
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

@end
