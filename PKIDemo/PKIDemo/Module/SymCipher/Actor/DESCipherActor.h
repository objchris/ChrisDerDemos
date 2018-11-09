//
//  DESCipherActor.h
//  PKIDemo
//
//  Created by 阿澤🍀 on 16/4/16.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "SymCipherActor.h"

@interface DESCipherActor : SymCipherActor

- (NSString *)encryptInCBC:(NSString *)plainText key:(NSString *)key iv:(NSData *)iv;
- (NSString *)decryptInCBC:(NSString *)cipherText key:(NSString *)key iv:(NSData *)iv;
- (NSString *)encryptInEBC:(NSString *)plainText key:(NSString *)key;
- (NSString *)decryptInEBC:(NSString *)cipherText key:(NSString *)key;

@end
