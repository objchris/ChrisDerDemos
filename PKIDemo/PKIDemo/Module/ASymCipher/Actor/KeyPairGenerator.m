//
//  KeyPairGenerator.m
//  PKIDemo
//
//  Created by 阿澤🍀 on 16/4/17.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "KeyPairGenerator.h"

@implementation KeyPairGenerator

- (void)generateKeyPair {
    
    SecKeyRef privateKey = NULL;
    SecKeyRef publicKey = NULL;
    
    OSStatus status = noErr;
    NSMutableDictionary *privateKeyAttr = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *publicKeyAttr = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *keyPairAttr = [[NSMutableDictionary alloc] init];
    
    NSData *publicTag = [NSData dataWithBytes:publicKeyIdentifier length:strlen((const char *)publicKeyIdentifier)];
    NSData *privateTag = [NSData dataWithBytes:privateKeyIdentifier length:strlen((const char *)privateKeyIdentifier)];
    
    [keyPairAttr setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [keyPairAttr setObject:@(1024) forKeyedSubscript:(__bridge id)kSecAttrKeySizeInBits];
    
    [privateKeyAttr setObject:@(YES) forKey:(__bridge id)kSecAttrIsPermanent];
    [privateKeyAttr setObject:privateTag forKey:(__bridge id)kSecAttrApplicationTag];
    
    [publicKeyAttr setObject:@(YES) forKey:(__bridge id)kSecAttrIsPermanent];
    [publicKeyAttr setObject:publicTag forKey:(__bridge id)kSecAttrApplicationTag];
    
    [keyPairAttr setObject:privateKeyAttr forKey:(__bridge id)kSecPrivateKeyAttrs];
    [keyPairAttr setObject:publicKeyAttr forKey:(__bridge id)kSecPublicKeyAttrs];
    
    status = SecKeyGeneratePair((__bridge CFDictionaryRef)keyPairAttr, &publicKey, &privateKey);
    
    if (status == noErr && publicKey != NULL && privateKey != NULL) {
        NSLog(@"Generate KeyPair Successfully");
    }
    
    if (publicKey) {
        CFRelease(publicKey);
    }
    if (privateKey) {
        CFRelease(privateKey);
    }
    
}


- (SecKeyRef)getPrivateKeyFromKeyChain {
    SecKeyRef privateKey;
    
    NSData *privateTag = [NSData dataWithBytes:privateKeyIdentifier length:strlen((const char *)privateKeyIdentifier)];
    
    NSMutableDictionary *queryPrivate = [[NSMutableDictionary alloc] init];
    [queryPrivate setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [queryPrivate setObject:privateTag forKey:(__bridge id)kSecAttrApplicationTag];
    [queryPrivate setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [queryPrivate setObject:@(YES) forKey:(__bridge id)kSecReturnRef];
    
    OSStatus status = noErr;
    status = SecItemCopyMatching((__bridge CFDictionaryRef) queryPrivate, (CFTypeRef *)&privateKey);

    if (status != noErr) {
        NSLog(@"can not find the private Key");
        return nil;
    }
    
    return privateKey;
}

- (SecKeyRef)getPublicKeyFromKeyChain {
    SecKeyRef publicKey;
    
    NSData *publicTag = [NSData dataWithBytes:publicKeyIdentifier length:strlen((const char *)publicKeyIdentifier)];
    
    NSMutableDictionary *queryPublic = [[NSMutableDictionary alloc] init];
    [queryPublic setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [queryPublic setObject:publicTag forKey:(__bridge id)kSecAttrApplicationTag];
    [queryPublic setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [queryPublic setObject:@(YES) forKey:(__bridge id)kSecReturnRef];
    
    OSStatus status = noErr;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)queryPublic, (CFTypeRef *)&publicKey);
    
    if (status != noErr) {
        NSLog(@"can not find the public Key");
        return NULL;
    }
    
    return publicKey;
}


@end
