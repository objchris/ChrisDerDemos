//
//  SuperViewController.h
//  PKIDemo
//
//  Created by Netca on 16/4/22.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperViewController : UIViewController
- (BOOL)canDoCrypt:(UITextView *)textView;
- (BOOL)canDoCrypt:(UITextView *)textView textField:(UITextField *)textField;
@end
