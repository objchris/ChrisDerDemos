//
//  SymCipherDemo.h
//  RSACryptor
//
//  Created by ezfen on 16/4/6.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import "GTMBase64.h"

@interface SymCipherActor : NSObject

- (NSData *)symCrypt:(CCOperation)operation
         processData:(NSData *)data
      UsingAlgorithm:(CCAlgorithm)algorithm
                 key:(NSData *)key
 initalizationVector:(NSData *)iv
             options:(CCOptions)options;

@end
