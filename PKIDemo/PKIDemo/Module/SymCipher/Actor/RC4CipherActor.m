//
//  RC4CipherActor.m
//  PKIDemo
//
//  Created by 阿澤🍀 on 16/4/17.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "RC4CipherActor.h"

@implementation RC4CipherActor

- (NSString *)encrypt:(NSString *)plainText key:(NSString *)key {
    NSData *plainData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [self symCrypt:kCCEncrypt processData:plainData UsingAlgorithm:kCCAlgorithmRC4 key:keyData initalizationVector:nil options:0];
    return [GTMBase64 stringByEncodingData:result];
}

- (NSString *)decrypt:(NSString *)cipherText key:(NSString *)key{
    NSData *cipherData = [GTMBase64 decodeString:cipherText];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [self symCrypt:kCCDecrypt processData:cipherData UsingAlgorithm:kCCAlgorithmRC4 key:keyData
                initalizationVector:nil options:0];
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

@end
