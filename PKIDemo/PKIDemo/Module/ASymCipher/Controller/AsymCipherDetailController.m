//
//  AsymCipherDetailController.m
//  PKIDemo
//
//  Created by ezfen on 16/4/19.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "AsymCipherDetailController.h"
#import "KeyPairGenerator.h"
#import "RSACipherActor.h"

@interface AsymCipherDetailController() <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *plainTextView;
@property (weak, nonatomic) IBOutlet UITextView *cipherTextView;

@property (strong, nonatomic) KeyPairGenerator *keyPairGenerator;
@end

@implementation AsymCipherDetailController

- (void)viewDidLoad {
    UIGestureRecognizer *tapGusture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagTheBackground)];
    [self.view addGestureRecognizer:tapGusture];
    self.plainTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.plainTextView.layer.borderWidth = 1;
    self.plainTextView.layer.cornerRadius = 5;
    self.plainTextView.delegate = self;
    self.cipherTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.cipherTextView.layer.borderWidth = 1;
    self.cipherTextView.layer.cornerRadius = 5;
    self.cipherTextView.delegate = self;
}

- (KeyPairGenerator *)keyPairGenerator {
    if (!_keyPairGenerator) {
        _keyPairGenerator = [KeyPairGenerator new];
    }
    return _keyPairGenerator;
}

- (IBAction)encrypt:(id)sender {
    if ([self canDoCrypt:self.plainTextView]) {
        RSACipherActor *rsaCipherActor = [[RSACipherActor alloc] init];
        SecKeyRef publicKey = [self.keyPairGenerator getPublicKeyFromKeyChain];
        NSString *plainString = self.plainTextView.text;
        NSString *cipherString = [rsaCipherActor encrypt:plainString withPublicKey:publicKey];
        self.cipherTextView.text = cipherString;
    }
}

- (IBAction)decrypt:(id)sender {
    if ([self canDoCrypt:self.cipherTextView]) {
        RSACipherActor *rsaCipherActor = [[RSACipherActor alloc] init];
        SecKeyRef privateKey = [self.keyPairGenerator getPrivateKeyFromKeyChain];
        NSString *cipherString = self.cipherTextView.text;
        NSString *plainString = [rsaCipherActor decrypt:cipherString withPrivateKey:privateKey];
        self.plainTextView.text = plainString;
    }
}

- (void)tagTheBackground {
    [self.plainTextView resignFirstResponder];
    [self.cipherTextView resignFirstResponder];
}

- (void)rsaTest {
    RSACipherActor *rsaCipherActor = [[RSACipherActor alloc] init];
    NSString *plainString = @"testteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestteestssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasadasdqwdqwfqwascasdaksjflkajglkjdlkasghiejrdlkwfnl";
    SecKeyRef publicKey = [self.keyPairGenerator getPublicKeyFromKeyChain];
    NSString *cipherString = [rsaCipherActor encrypt:plainString withPublicKey:publicKey];
    NSLog(@"cipherText: %@", cipherString);
    SecKeyRef privateKey = [self.keyPairGenerator getPrivateKeyFromKeyChain];
    plainString = [rsaCipherActor decrypt:cipherString withPrivateKey:privateKey];
    NSLog(@"plainText: %@", plainString);
}
@end
