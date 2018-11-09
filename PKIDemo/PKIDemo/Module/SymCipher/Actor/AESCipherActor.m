//
//  AES128CipherActor.m
//  PKIDemo
//
//  Created by 阿澤🍀 on 16/4/16.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "AESCipherActor.h"

@implementation AESCipherActor

- (NSString *)encryptInCBC:(NSString *)plainText key:(NSString *)key iv:(NSData *)iv {
    NSData *plainData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [self symCrypt:kCCEncrypt processData:plainData UsingAlgorithm:kCCAlgorithmAES key:keyData initalizationVector:iv options:kCCOptionPKCS7Padding];
    return [GTMBase64 stringByEncodingData:result];
}

- (NSString *)decryptInCBC:(NSString *)cipherText key:(NSString *)key iv:(NSData *)iv {
    NSData *cipherData = [GTMBase64 decodeString:cipherText];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [self symCrypt:kCCDecrypt processData:cipherData UsingAlgorithm:kCCAlgorithmAES key:keyData
                initalizationVector:iv options:kCCOptionPKCS7Padding];
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

- (NSString *)encryptInEBC:(NSString *)plainText key:(NSString *)key {
    NSData *plainData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [self symCrypt:kCCEncrypt processData:plainData UsingAlgorithm:kCCAlgorithmAES key:keyData initalizationVector:nil options:kCCOptionPKCS7Padding | kCCOptionECBMode];
    return [GTMBase64 stringByEncodingData:result];
}

- (NSString *)decryptInEBC:(NSString *)cipherText key:(NSString *)key{
    NSData *cipherData = [GTMBase64 decodeString:cipherText];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [self symCrypt:kCCDecrypt processData:cipherData UsingAlgorithm:kCCAlgorithmAES key:keyData
                initalizationVector:nil options:kCCOptionPKCS7Padding | kCCOptionECBMode];
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

@end
