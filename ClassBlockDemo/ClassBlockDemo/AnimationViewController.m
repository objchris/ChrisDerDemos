//
//  AnimationViewController.m
//  ClassBlockDemo
//
//  Created by Chris Cheung on 2017/10/20.
//  Copyright © 2017年 Chris Cheung. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *animationView;
@property (nonatomic) CGRect initFrame;
@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.initFrame = self.animationView.frame;
    [self startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAnimation {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:3.5 animations:^{
        CGRect frame = weakSelf.initFrame;
        frame.origin.y += 2 * weakSelf.initFrame.size.height;
        weakSelf.animationView.frame = frame;
    } completion:^(BOOL finished) {
        weakSelf.animationView.frame = weakSelf.initFrame;
        [weakSelf startAnimation];        // 递归调用，再次执行此函数
    }];
}

@end
