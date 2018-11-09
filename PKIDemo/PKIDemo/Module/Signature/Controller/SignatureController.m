//
//  SignatureController.m
//  PKIDemo
//
//  Created by Netca on 16/4/22.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "SignatureController.h"
#import "SignatureActor.h"
#import "KeyPairGenerator.h"

@interface SignatureController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *plainTextView;
@property (weak, nonatomic) IBOutlet UITextView *signatureTextView;
@end

@implementation SignatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGestureRecognizer *tapGusture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagTheBackground)];
    [self.view addGestureRecognizer:tapGusture];
    self.plainTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.plainTextView.layer.borderWidth = 1;
    self.plainTextView.layer.cornerRadius = 5;
    self.plainTextView.delegate = self;
    self.signatureTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.signatureTextView.layer.borderWidth = 1;
    self.signatureTextView.layer.cornerRadius = 5;
    self.signatureTextView.delegate = self;
}

- (IBAction)generateSignature:(id)sender {
    if ([self canDoCrypt:self.plainTextView]) {
        KeyPairGenerator *keyPairGenerator = [KeyPairGenerator new];
        SignatureActor *signatureActor = [SignatureActor new];
        NSString *stringToSig = self.plainTextView.text;
        SecKeyRef privateKey = [keyPairGenerator getPrivateKeyFromKeyChain];
        NSString *signature = [signatureActor generateSignatureUsingPlainText:stringToSig withPrivateKey:privateKey];
        self.signatureTextView.text = signature;
    }
}

- (void)tagTheBackground {
    [self.plainTextView resignFirstResponder];
    [self.signatureTextView resignFirstResponder];
}

- (void)signatureTest {
    SignatureActor *signatureActor = [SignatureActor new];
    NSString *stringToSig = @"test Signature";
    KeyPairGenerator *keyPairGenerator;
    //签名
    SecKeyRef privateKey = [keyPairGenerator getPrivateKeyFromKeyChain];
    NSString *signature = [signatureActor generateSignatureUsingPlainText:stringToSig withPrivateKey:privateKey];
    NSLog(@"result: %@", signature);
    //验证签名
    SecKeyRef publicKey = [keyPairGenerator getPublicKeyFromKeyChain];
    BOOL verifyResult = [signatureActor verifySignature:signature withPlainText:stringToSig withPublicKey:publicKey];
    NSLog(@"verifyResult: %@",verifyResult?@"YES":@"NO");
}
@end
