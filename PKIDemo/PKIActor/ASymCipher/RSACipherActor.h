//
//  AsymCipherDemo.h
//  RSACryptor
//
//  Created by ezfen on 16/4/6.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSACipherActor : NSObject

- (NSString *)encrypt:(NSString *)stringToEncrypt withPublicKey:(SecKeyRef)publicKey;
- (NSString *)decrypt:(NSString *)stringToDecrypt withPrivateKey:(SecKeyRef)privateKey;

@end
