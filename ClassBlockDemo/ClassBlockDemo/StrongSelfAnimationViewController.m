//
//  StrongSelfAnimationViewController.m
//  ClassBlockDemo
//
//  Created by Chris Cheung on 2017/10/20.
//  Copyright © 2017年 Chris Cheung. All rights reserved.
//

#import "StrongSelfAnimationViewController.h"

@interface StrongSelfAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *animationView;
@property (nonatomic) CGRect initFrame;
@end

@implementation StrongSelfAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.initFrame = self.animationView.frame;
    [self startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAnimation {
    [UIView animateWithDuration:3.5 animations:^{
        CGRect frame = self.initFrame;
        frame.origin.y += 2 * self.initFrame.size.height;
        self.animationView.frame = frame;
    } completion:^(BOOL finished) {
        self.animationView.frame = self.initFrame;
        [self startAnimation];        // 递归调用，再次执行此函数
    }];
}

@end
