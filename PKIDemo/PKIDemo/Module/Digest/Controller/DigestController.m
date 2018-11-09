//
//  DigestController.m
//  PKIDemo
//
//  Created by Netca on 16/4/22.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "DigestController.h"
#import "DigestActor.h"

@interface DigestController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *plainTextView;
@property (weak, nonatomic) IBOutlet UITextView *digestTextView;
@end

@implementation DigestController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGestureRecognizer *tapGusture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagTheBackground)];
    [self.view addGestureRecognizer:tapGusture];
    self.plainTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.plainTextView.layer.borderWidth = 1;
    self.plainTextView.layer.cornerRadius = 5;
    self.plainTextView.delegate = self;
    self.digestTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.digestTextView.layer.borderWidth = 1;
    self.digestTextView.layer.cornerRadius = 5;
    self.digestTextView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)generateDigest:(id)sender {
    if ([self canDoCrypt:self.plainTextView]) {
        DigestActor *digestActor = [DigestActor new];
        NSString *stringToDigest = self.plainTextView.text;
        NSString *result = [digestActor stringByMD5Digest:stringToDigest];
        self.digestTextView.text = result;
    }
}

- (void)tagTheBackground {
    [self.plainTextView resignFirstResponder];
    [self.digestTextView resignFirstResponder];
}

- (void)digestTest {
    DigestActor *digestActor = [DigestActor new];
    NSString *stringToDigest = @"test Digest";
    NSString *result = [digestActor stringByMD5Digest:stringToDigest];
    NSLog(@"result: %@", result);
}
@end
