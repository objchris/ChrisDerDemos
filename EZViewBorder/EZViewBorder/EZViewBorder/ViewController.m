//
//  ViewController.m
//  EZViewBorder
//
//  Created by Chris Cheung on 2017/2/28.
//  Copyright © 2017年 Chris Cheung. All rights reserved.
//

#import "ViewController.h"
#import "UIView+EZViewBorder.h"

@interface ViewController ()
@property (strong, nonatomic) UIView *view1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _view1.layer.borderColor = [UIColor redColor].CGColor;
    _view1.layer.borderWidth = 1;
    _view1.layer.cornerRadius = 50;
    [_view1 setBorder:ViewBorderStyleSolid AtPosition:ViewBorderPositionBottomLeft|ViewBorderPositionTopRight];
    [self.view addSubview:_view1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"aaa" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 400, 100, 50);
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
     
}

- (void)buttonTap:(id)sender {
    _view1.layer.borderColor = [UIColor blackColor].CGColor;
    _view1.layer.cornerRadius = 10;
    _view1.layer.borderWidth = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
