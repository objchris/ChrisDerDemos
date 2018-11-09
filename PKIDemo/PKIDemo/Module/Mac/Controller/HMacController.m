//
//  HMacViewController.m
//  PKIDemo
//
//  Created by Netca on 16/4/22.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "HMacController.h"
#import "HMacActor.h"

@interface HMacController () <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *plainTextView;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@end

@implementation HMacController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGestureRecognizer *tapGusture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagTheBackground)];
    [self.view addGestureRecognizer:tapGusture];
    self.plainTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.plainTextView.layer.borderWidth = 1;
    self.plainTextView.layer.cornerRadius = 5;
    self.plainTextView.delegate = self;
    self.resultTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.resultTextView.layer.borderWidth = 1;
    self.resultTextView.layer.cornerRadius = 5;
    self.resultTextView.delegate = self;
    self.keyTextField.delegate = self;
}

- (void)tagTheBackground {
    [self.plainTextView resignFirstResponder];
    [self.resultTextView resignFirstResponder];
    [self.keyTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)generateHMacResult:(id)sender {
    if ([self canDoCrypt:self.plainTextView textField:self.keyTextField]) {
        HMacActor *hmacActor = [HMacActor new];
        NSString *result = [hmacActor HMacSHA1WithKey:self.keyTextField.text data:self.plainTextView.text];
        self.resultTextView.text = result;
    }
}
@end
