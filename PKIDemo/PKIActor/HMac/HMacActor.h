//
//  HMacActor.h
//  PKIDemo
//
//  Created by Netca on 16/4/22.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMacActor : NSObject

- (NSString *)HMacSHA1WithKey:(NSString *)key data:(NSString *)data;
- (NSString *)HMacMD5WithKey:(NSString *)key data:(NSString *)data;

@end
