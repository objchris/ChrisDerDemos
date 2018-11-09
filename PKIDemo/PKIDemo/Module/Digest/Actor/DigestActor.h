//
//  DigestDemo.h
//  PKIDemo
//
//  Created by ezfen on 16/4/7.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DigestActor : NSObject

- (NSString *)stringByMD5Digest:(NSString *)stringToDigest;
- (NSString *)stringBySHA1Digest:(NSString *)stringToDigest;
- (NSString *)stringBySHA256Digest:(NSString *)stringToDigest;

- (NSData *)dataByMD5Digest:(NSString *)stringToDigest;
- (NSData *)dataBySHA1Digest:(NSString *)stringToDigest;
- (NSData *)dataBySHA256Digest:(NSString *)stringToDigest;

@end
