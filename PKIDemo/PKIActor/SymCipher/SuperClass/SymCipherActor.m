//
//  SymCipherDemo.m
//  RSACryptor
//
//  Created by ezfen on 16/4/6.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "SymCipherActor.h"

@implementation SymCipherActor

# pragma mark - Public Function
- (NSData *)symCrypt:(CCOperation)operation
         processData:(NSData *)data
      UsingAlgorithm:(CCAlgorithm)algorithm
                 key:(NSData *)key
 initalizationVector:(NSData *)iv
             options:(CCOptions)options
{
    NSData *result = nil;
    NSMutableData *cKey = [key mutableCopy], *cIV = [iv mutableCopy];
    //根据加解密算法检查Key和iv的长度是否符合要求
    [self fixKeyLengthsByAlgorithm:algorithm keyData:cKey ivData:cIV];
    //加密后的数据总小于等于数据长度加上block的大小
    size_t bufferSize = [data length] + [self blockSizeByAlgorithm:algorithm];
    void *buffer = malloc(bufferSize);
    size_t encryptedSize = 0;
    CCStatus status = CCCrypt(operation, algorithm, options, [cKey bytes], [cKey length], [cIV bytes], [data bytes], [data length], buffer, bufferSize, &encryptedSize);
    if (status == kCCSuccess) {
        result = [NSData dataWithBytes:buffer length:encryptedSize];
    } else {
        NSLog(@"[ERROR] failed to encrypt|CCCryptoStatus: %d", status);
    }
    free(buffer);
    return result;
}

# pragma mark - Private Function
- (void)fixKeyLengthsByAlgorithm:(CCAlgorithm)algorithm
                         keyData:(NSMutableData *)keyData
                          ivData:(NSMutableData *)ivData
{
    NSUInteger keyLength = [keyData length];
    switch (algorithm) {
        case kCCAlgorithmAES:
        {
            if (keyLength < kCCKeySizeAES128) {
                keyData.length = kCCKeySizeAES128;
            } else if (keyLength <= kCCKeySizeAES192) {
                keyData.length = kCCKeySizeAES192;
            } else {
                keyData.length = kCCKeySizeAES256;
            }
            break;
        }
        case kCCAlgorithmDES:
        {
            keyData.length = kCCKeySizeDES;
            break;
        }
        case kCCAlgorithm3DES:
        {
            keyData.length = kCCKeySize3DES;
            break;
        }
        case kCCAlgorithmRC4:
        {
            if (keyData.length > kCCKeySizeMaxRC4) {
                keyData.length = kCCKeySizeMaxRC4;
            }
            break;
        }
        default:
            break;
    }
    ivData.length = keyData.length;
}

- (size_t)blockSizeByAlgorithm:(CCAlgorithm)algorithm {
    switch (algorithm) {
        case kCCAlgorithmAES:
            return kCCBlockSizeAES128;
        case kCCAlgorithmDES:
        case kCCAlgorithm3DES:
        case kCCAlgorithmRC4:
            return kCCBlockSizeDES;
        default:
            return 0;
    }
}


@end
