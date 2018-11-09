//
//  KeyPairDispatchController.m
//  PKIDemo
//
//  Created by ezfen on 16/4/19.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "KeyPairDispatchController.h"
#import "KeyPairGenerator.h"

@interface KeyPairDispatchController()
@property (strong, nonatomic) KeyPairGenerator *keyPairGenerator;
@end

@implementation KeyPairDispatchController

- (void)viewDidLoad {
    
}

- (IBAction)generateKeyPair:(id)sender {
    self.keyPairGenerator = [KeyPairGenerator new];
    [self.keyPairGenerator generateKeyPair];
    [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
}

@end
