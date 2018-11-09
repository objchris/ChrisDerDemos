//
//  PwdCipherController.m
//  PKIDemo
//
//  Created by Netca on 16/4/20.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "PwdCipherController.h"
#import "PwdCipherActor.h"

@interface PwdCipherController () <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *plainTextView;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextView *cipherTextView;
@end

@implementation PwdCipherController

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
    self.pwdTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)encrypt:(id)sender {
    if ([self canDoCrypt:self.plainTextView textField:self.pwdTextField]) {
        PwdCipherActor *pwdCipherActor = [PwdCipherActor new];
        NSString *plainText = self.plainTextView.text;
        static const char gSalt[] =
        {
            (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA,
            (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA
        };
        NSData *salt = [NSData dataWithBytes:gSalt length:sizeof(gSalt)/sizeof(gSalt[0])];
        NSData *key = [pwdCipherActor generateKeyWithPassword:self.pwdTextField.text andSalt:salt andIterating:16];
        NSString *cipherText = [pwdCipherActor DESEncrypt:plainText withPwdKey:key];
        self.cipherTextView.text = cipherText;
    }
}

- (IBAction)decrypt:(id)sender {
    if ([self canDoCrypt:self.cipherTextView textField:self.pwdTextField]) {
        PwdCipherActor *pwdCipherActor = [PwdCipherActor new];
        NSString *cipherText = self.cipherTextView.text;
        static const char gSalt[] =
        {
            (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA,
            (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA
        };
        NSData *salt = [NSData dataWithBytes:gSalt length:sizeof(gSalt)/sizeof(gSalt[0])];
        NSData *key = [pwdCipherActor generateKeyWithPassword:self.pwdTextField.text andSalt:salt andIterating:16];
        NSString *plainText = [pwdCipherActor DESDecrypt:cipherText withPwdKey:key];
        self.plainTextView.text = plainText;
    }
}

- (void)tagTheBackground {
    [self.plainTextView resignFirstResponder];
    [self.cipherTextView resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}

- (void)pwdCipherTest {
    PwdCipherActor *pwdCipherActor = [PwdCipherActor new];
    NSString *plainText = @"test Pwd";
    static const char gSalt[] =
    {
        (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA,
        (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA, (unsigned char)0xAA
    };
    NSData *salt = [NSData dataWithBytes:gSalt length:sizeof(gSalt)/sizeof(gSalt[0])];
    NSData *key = [pwdCipherActor generateKeyWithPassword:@"12345678" andSalt:salt andIterating:16];
    
    NSString *cipherText = [pwdCipherActor DESEncrypt:plainText withPwdKey:key];
    NSLog(@"cipherText: %@", cipherText);
    
    plainText = [pwdCipherActor DESDecrypt:cipherText withPwdKey:key];
    NSLog(@"%@", plainText);
}


@end
