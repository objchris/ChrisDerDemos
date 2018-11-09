//
//  SignatureActor.h
//  PKIDemo
//
//  Created by ezfen on 16/4/7.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignatureActor : NSObject

- (NSString *)generateSignatureUsingPlainText:(NSString *)plainText withPrivateKey:(SecKeyRef)privateKey;
- (BOOL)verifySignature:(NSString *)signature withPlainText:(NSString *)plainText withPublicKey:(SecKeyRef)publicKey;

@end
