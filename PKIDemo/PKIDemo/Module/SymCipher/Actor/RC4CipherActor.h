//
//  RC4CipherActor.h
//  PKIDemo
//
//  Created by 阿澤🍀 on 16/4/17.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "SymCipherActor.h"

@interface RC4CipherActor : SymCipherActor

- (NSString *)encrypt:(NSString *)plainText key:(NSString *)key;
- (NSString *)decrypt:(NSString *)cipherText key:(NSString *)key;

@end
