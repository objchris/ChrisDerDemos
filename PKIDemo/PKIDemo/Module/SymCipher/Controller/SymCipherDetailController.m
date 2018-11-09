//
//  SymCipherDetailController.m
//  PKIDemo
//
//  Created by ezfen on 16/4/18.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "SymCipherDetailController.h"
#import "DESCipherActor.h"
#import "AESCipherActor.h"
#import "RC4CipherActor.h"

@interface SymCipherDetailController() <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *plainTextView;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextView *cipherTextView;
@end

@implementation SymCipherDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.keyTextField.delegate = self;
}

- (IBAction)encrypt:(id)sender {
    if ([self canDoCrypt:self.plainTextView textField:self.keyTextField]) {
        switch (self.funClass) {
            case 0:
            {
                DESCipherActor *desCipherActor = [DESCipherActor new];
                NSString *plainText = self.plainTextView.text;
                NSString *key = self.keyTextField.text;
                NSString *EBCcipherText = [desCipherActor encryptInEBC:plainText key:key];
                self.cipherTextView.text = EBCcipherText;
            }
            break;
            case 1:
            {
                AESCipherActor *aesCipherActor = [AESCipherActor new];
                NSString *plainText = self.plainTextView.text;
                NSString *key = self.keyTextField.text;
                NSString *EBCcipherText = [aesCipherActor encryptInEBC:plainText key:key];
                self.cipherTextView.text = EBCcipherText;
            }
            break;
            case 2:
            {
                RC4CipherActor *rc4CipherActor = [RC4CipherActor new];
                NSString *plainText = self.plainTextView.text;
                NSString *key = self.keyTextField.text;
                NSString *cipherText = [rc4CipherActor encrypt:plainText key:key];
                self.cipherTextView.text = cipherText;
            }
            break;
            default:
                break;
        }
        
    }
}

- (IBAction)decrypt:(id)sender {
    if ([self canDoCrypt:self.cipherTextView textField:self.keyTextField]) {
        switch (self.funClass) {
            case 0:
            {
                DESCipherActor *desCipherActor = [DESCipherActor new];
                NSString *cipherText = self.cipherTextView.text;
                NSString *key = self.keyTextField.text;
                NSString *plainText = [desCipherActor decryptInEBC:cipherText key:key];
                self.plainTextView.text = plainText;
            }
                break;
            case 1:
            {
                AESCipherActor *aesCipherActor = [AESCipherActor new];
                NSString *cipherText = self.cipherTextView.text;
                NSString *key = self.keyTextField.text;
                NSString *plainText = [aesCipherActor decryptInEBC:cipherText key:key];
                self.plainTextView.text = plainText;
            }
                break;
            case 2:
            {
                RC4CipherActor *rc4CipherActor = [RC4CipherActor new];
                NSString *cipherText = self.cipherTextView.text;
                NSString *key = self.keyTextField.text;
                NSString *plainText = [rc4CipherActor decrypt:cipherText key:key];
                self.plainTextView.text = plainText;
            }
                break;
            default:
                break;
        }
    }
}

- (void)tagTheBackground {
    [self.plainTextView resignFirstResponder];
    [self.cipherTextView resignFirstResponder];
    [self.keyTextField resignFirstResponder];
}

- (void)desTest {
    DESCipherActor *desCipherActor = [DESCipherActor new];
    
    NSString *plainText = @"test SymCipher Demo";
    NSLog(@"plainText:%@",plainText);
    
    NSString *key = @"12345678";
    Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0xcd, 0xef};
    NSData *ivData = [NSData dataWithBytes:iv length:sizeof(iv)];
    
    NSString *CBCcipherText = [desCipherActor encryptInCBC:plainText key:key iv:ivData];
    NSLog(@"cipherText: %@", CBCcipherText);
    NSString *EBCcipherText = [desCipherActor encryptInEBC:plainText key:key];
    NSLog(@"cipherText: %@", EBCcipherText);
    
    plainText = [desCipherActor decryptInEBC:EBCcipherText key:key];
    NSLog(@"%@", plainText);
    plainText = [desCipherActor decryptInCBC:CBCcipherText key:key iv:ivData];
    NSLog(@"%@", plainText);
}

- (void)aesTest {
    NSString *plainText = @"test SymCipher Demo";
    NSLog(@"plainText:%@",plainText);
    NSString *key = @"1234567890123456";//128
    //key = @"123456789012345678901234";//192
    //key = @"12345678901234567890123456789012";//256
    NSLog(@"%lu",(unsigned long)key.length);
    AESCipherActor *aesCipherActor = [AESCipherActor new];
    NSString *EBCcipherText = [aesCipherActor encryptInEBC:plainText key:key];
    NSLog(@"cipherText: %@", EBCcipherText);
    NSString *CBCcipherText = [aesCipherActor encryptInCBC:plainText key:key iv:[key dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"cipherText: %@", CBCcipherText);
    plainText = [aesCipherActor decryptInEBC:EBCcipherText key:key];
    NSLog(@"%@", plainText);
    plainText = [aesCipherActor decryptInCBC:CBCcipherText key:key iv:[key dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@", plainText);
}

- (void)rc4Test {
    NSString *plainText = @"test SymCipher Demo";
    NSLog(@"plainText:%@",plainText);
    NSString *key = @"12345678901234567890";
    RC4CipherActor *rc4CipherActor = [RC4CipherActor new];
    NSString *cipherText = [rc4CipherActor encrypt:plainText key:key];
    NSLog(@"%@", cipherText);
    
    plainText = [rc4CipherActor decrypt:cipherText key:key];
    NSLog(@"%@", plainText);
}

@end
