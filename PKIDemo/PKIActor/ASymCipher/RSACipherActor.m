//
//  AsymCipherDemo.m
//  RSACryptor
//
//  Created by ezfen on 16/4/6.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "RSACipherActor.h"
#import <Security/Security.h>
#import "GTMBase64.h"

@interface RSACipherActor()

@end

@implementation RSACipherActor

- (NSString *)encrypt:(NSString *)stringToEncrypt withPublicKey:(SecKeyRef)publicKey{
    
    OSStatus status = noErr;
    
    size_t cipherBufferSize;
    uint8_t *cipherBuffer;
    
    uint8_t *dataToEncrypt = (uint8_t *)[stringToEncrypt cStringUsingEncoding:NSUTF8StringEncoding];
    size_t dataLength = stringToEncrypt.length;
    NSLog(@"dataLength: %zu", dataLength);
    
    cipherBufferSize = SecKeyGetBlockSize(publicKey);
    cipherBuffer = malloc(cipherBufferSize);
    size_t totalBufferSize = 0;
    NSMutableData *data = [[NSMutableData alloc] init];
    
    //使用kSecPaddingPKCS1作为加密的padding
    if ((cipherBufferSize - 11) < dataLength) {
        //若需要加密的数据长度过长，需要分块加密
        size_t toEncryptDataLength = dataLength;
        while ((cipherBufferSize - 11) < toEncryptDataLength) {
            status = SecKeyEncrypt(publicKey,
                                   kSecPaddingPKCS1,
                                   dataToEncrypt + (dataLength - toEncryptDataLength),
                                   cipherBufferSize - 11,
                                   cipherBuffer,
                                   &cipherBufferSize);
            toEncryptDataLength = toEncryptDataLength - (cipherBufferSize - 11);
            //CipherBuffer是通过malloc创建，没有对内存空间进行初始化，有很多其他数据
            //转储成NSData，确保对正确长度的cipherBuffer的获取
            [data appendData:[NSData dataWithBytes:cipherBuffer length:cipherBufferSize]];
            totalBufferSize += cipherBufferSize;
        }
        //对剩余的数据进行加密
        status = SecKeyEncrypt(publicKey,
                               kSecPaddingPKCS1,
                               dataToEncrypt + (dataLength - toEncryptDataLength),
                               toEncryptDataLength,
                               cipherBuffer,
                               &cipherBufferSize);
        [data appendData:[NSData dataWithBytes:cipherBuffer length:cipherBufferSize]];
        totalBufferSize += cipherBufferSize;
    } else {
        //需要加密的数据长度小于SecKeyGetBlockSize(publicKey)－11，直接加密
        status = SecKeyEncrypt(publicKey, kSecPaddingPKCS1, dataToEncrypt, dataLength, cipherBuffer, &cipherBufferSize);
        [data appendData:[NSData dataWithBytes:cipherBuffer length:cipherBufferSize]];
    }
    if (publicKey) {
        CFRelease(publicKey);
    }
    NSString *encryptedString = [GTMBase64 stringByEncodingData:[data copy]];
    free(cipherBuffer);
    return encryptedString;
}

- (NSString *)decrypt: (NSString *)stringToDecrypt withPrivateKey:(SecKeyRef)privateKey {
    NSData *dataToDecrypt = [GTMBase64 decodeString:stringToDecrypt];
    OSStatus status = noErr;
    
    size_t cipherBufferSize = [dataToDecrypt length];
    uint8_t *cipherBuffer = (uint8_t *)[dataToDecrypt bytes];

    size_t plainBufferSize;
    uint8_t *plainBuffer;
    
    plainBufferSize = SecKeyGetBlockSize(privateKey);
    plainBuffer = malloc(plainBufferSize);
    NSMutableData *data = [[NSMutableData alloc] init];
    size_t decryptLengthPer = SecKeyGetBlockSize(privateKey);
    
    if (decryptLengthPer < cipherBufferSize) {
        size_t toDecryptDataLength = cipherBufferSize;
        size_t totalBufferSize = 0;
        while (decryptLengthPer < toDecryptDataLength) {
            status = SecKeyDecrypt(privateKey,
                                   kSecPaddingPKCS1,
                                   cipherBuffer + (cipherBufferSize - toDecryptDataLength),
                                   decryptLengthPer,
                                   plainBuffer,
                                   &plainBufferSize);
            toDecryptDataLength = toDecryptDataLength - decryptLengthPer;
            if (status == noErr) {
                [data appendData:[NSData dataWithBytes:plainBuffer length:plainBufferSize]];
            }
            totalBufferSize += plainBufferSize;
        }
        status = SecKeyDecrypt(privateKey,
                               kSecPaddingPKCS1,
                               cipherBuffer + (cipherBufferSize - toDecryptDataLength),
                               decryptLengthPer,
                               plainBuffer,
                               &plainBufferSize);
        if (status == noErr) {
            [data appendData:[NSData dataWithBytes:plainBuffer length:plainBufferSize]];
        }
        totalBufferSize += plainBufferSize;
    } else {
        status = SecKeyDecrypt(privateKey, kSecPaddingPKCS1, cipherBuffer, cipherBufferSize, plainBuffer, &plainBufferSize);
        if (status == noErr) {
            [data appendData:[NSData dataWithBytes:plainBuffer length:plainBufferSize]];
        }
    }
    
    if (privateKey) {
        CFRelease(privateKey);
    }
    NSString *decryptedString = [[NSString alloc] initWithData:[data copy] encoding:NSUTF8StringEncoding];
    free(plainBuffer);
    return decryptedString;
}

@end
