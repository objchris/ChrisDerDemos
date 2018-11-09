//
//  MainEffectView.m
//  PKIDemo
//
//  Created by ezfen on 16/4/18.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "MainEffectView.h"

@implementation MainEffectView

- (void)drawRect:(CGRect)rect {
    //Background
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    imageView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height * .7);
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:imageView];
    //EffectView:磨砂效果
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = rect;
    [self addSubview:visualEffectView];
    //Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, rect.size.width, 30)];
    label.text = @"PKIDemo";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:24];
    label.textColor = [UIColor whiteColor];
    [visualEffectView.contentView addSubview:label];
    //添加六个Button
    CGFloat viewWidth = rect.size.width;
    CGFloat padding = viewWidth / 12.0;
    CGFloat buttonWidth = (viewWidth - 4 * padding) / 3.0;
    NSArray *buttonText = @[@"对称加密",@"非对称加密",@"报文认证",@"口令加密",@"数字摘要",@"数字签名"];
    for (int i = 0; i < 6; ++i) {
        CGRect frame = CGRectMake(padding + (i % 3) * (padding + buttonWidth), 150 + ((int)i / 3) * (buttonWidth + 2 * padding), buttonWidth, buttonWidth);
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = button.bounds.size.width / 2.0;
        [button setTag:i];
        [button setTitle:buttonText[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [visualEffectView.contentView addSubview:button];
    }
}

- (void)buttonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickButtonTag:inView:)]) {
        [self.delegate clickButtonTag:sender.tag inView:self];
    }
}

@end
