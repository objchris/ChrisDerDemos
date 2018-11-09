//
//  ViewController.m
//  EZRecycleImageView
//
//  Created by 阿澤🍀 on 16/2/22.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "ViewController.h"
#import "EZRecycleImageView.h"

@interface ViewController () <EZRecycleImageViewDelegate>
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) EZRecycleImageView *simpleRIV;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSDictionary *dic;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutUI {
    _simpleRIV = [[EZRecycleImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 180)];
    //simpleROSV.imageNames = @[@"0",@"1",@"2"];
    //NSDictionary *dic = @{@"1":[NSNull null]};
    self.dic = @{@"1":@"伦敦塔桥",@"2":@"某个落日的海边"};
    _simpleRIV.imageInfo = self.dic;
    _simpleRIV.recycleImageDelegate = self;
    [self.view addSubview:_simpleRIV];

    
    //添加PageControl
    _pageControl = [[UIPageControl alloc] init];
    CGSize size = [_pageControl sizeForNumberOfPages:self.dic.count];
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(270, 270);
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:193/255.0 green:219/255.0 blue:249/255.0 alpha:1];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    _pageControl.numberOfPages = self.dic.count;
    [self.view addSubview:_pageControl];
    
}

- (void)rollDidEndDecelerating {
    long index = _simpleRIV.currentImageIndex;
    _pageControl.currentPage = index;
}

- (void)tapImageView:(NSInteger)imageIndex {
    NSString *message = [self.dic objectForKey:[NSString stringWithFormat:@"%li",(long)imageIndex + 1]];
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"点击" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [view show];
}

@end
