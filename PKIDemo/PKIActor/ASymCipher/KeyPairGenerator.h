//
//  KeyPairGenerator.h
//  PKIDemo
//
//  Created by 阿澤🍀 on 16/4/17.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <Foundation/Foundation.h>

static const UInt8 publicKeyIdentifier[] = "net.netca.sample.publicKey";
static const UInt8 privateKeyIdentifier[] = "net.netca.sample.privateKey";

@interface KeyPairGenerator : NSObject

- (void)generateKeyPair;
- (SecKeyRef)getPrivateKeyFromKeyChain;
- (SecKeyRef)getPublicKeyFromKeyChain;

@end
