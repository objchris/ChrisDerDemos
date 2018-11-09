//
//  SuperViewController.m
//  PKIDemo
//
//  Created by Netca on 16/4/22.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController () <UITextViewDelegate, UITextFieldDelegate>

@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)canDoCrypt:(UITextView *)textView {
    return [self canDoCrypt:textView textField:nil];
}

- (BOOL)canDoCrypt:(UITextView *)textView textField:(UITextField *)textField {
    if (textView.text == nil || [textView.text isEqualToString:@""]) {
        [textView becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"明文或密文内容为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if (textField != nil) {
        if (textField.text == nil || [textField.text isEqualToString:@""]){
            [textField becomeFirstResponder];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密钥为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

#pragma mark - TextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    CGFloat offset = self.view.frame.size.height - (textView.frame.origin.y + textView.frame.size.height + 216 + 50);
    if (offset <= 0) {
        [UIView animateWithDuration:.3f animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [UIView animateWithDuration:.3f animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
}

#pragma mark - TextFieldDelagate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height + 216 + 50);
    if (offset <= 0) {
        [UIView animateWithDuration:.3f animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:.3f animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
