//
//  PwdCipherActor.h
//  PKIDemo
//
//  Created by ezfen on 16/4/12.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SymCipherActor.h"

@interface PwdCipherActor : SymCipherActor

- (NSData *)generateKeyWithPassword:(NSString *)password andSalt:(NSData *)salt andIterating:(int)numIterations;
- (NSString *)DESEncrypt:(NSString *)plainText withPwdKey:(NSData *)pwdKey;
- (NSString *)DESDecrypt:(NSString *)cipherText withPwdKey:(NSData *)pwdKey;

@end
