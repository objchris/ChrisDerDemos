//
//  SignatureActor.m
//  PKIDemo
//
//  Created by ezfen on 16/4/7.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <Security/Security.h>
#import "SignatureActor.h"
#import "KeyPairGenerator.h"
#import "DigestActor.h"
#import "GTMBase64.h"

@interface SignatureActor()
@property (strong, nonatomic) DigestActor *digestActor;
@property (strong, nonatomic) KeyPairGenerator *keyPairGenerator;
@end

@implementation SignatureActor

- (DigestActor *)digestActor {
    if (!_digestActor) {
        _digestActor = [DigestActor new];
    }
    return _digestActor;
}

- (KeyPairGenerator *)keyPairGenerator {
    if (!_keyPairGenerator) {
        _keyPairGenerator = [[KeyPairGenerator alloc] init];
    }
    return _keyPairGenerator;
}

- (NSString *)generateSignatureUsingPlainText:(NSString *)plainText withPrivateKey:(SecKeyRef)privateKey{
    NSData *data = [self.digestActor dataBySHA1Digest:plainText];
    if (!data){
        return nil;
    }
    size_t signatureLength = SecKeyGetBlockSize(privateKey);
    uint8_t *signatureBuffer = malloc(signatureLength);
    OSStatus status = noErr;
    status = SecKeyRawSign(privateKey, kSecPaddingPKCS1SHA1, [data bytes], [data length], signatureBuffer, &signatureLength);
    if (status != noErr) {
        NSLog(@"can not generate signature.");
        return nil;
    }
    NSData *resultData = [NSData dataWithBytes:signatureBuffer length:signatureLength];
    free(signatureBuffer);
    return [GTMBase64 stringByEncodingData:resultData];
}

- (BOOL)verifySignature:(NSString *)signature withPlainText:(NSString *)plainText withPublicKey:(SecKeyRef)publicKey {
    NSData *data = [self.digestActor dataBySHA1Digest:plainText];
    NSData *signatureData = [GTMBase64 decodeString:signature];
    if (!data) {
        return NO;
    }
    OSStatus status = noErr;
    status = SecKeyRawVerify(publicKey, kSecPaddingPKCS1SHA1, [data bytes], [data length], [signatureData bytes], [signatureData length]);
    if (status == noErr) return YES;
    else return NO;
}


@end
