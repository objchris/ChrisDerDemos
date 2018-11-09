//
//  RollingImageScrollView.m
//  LibrarySeats
//
//  Created by 阿澤🍀 on 15/12/8.
//  Copyright © 2015年 阿澤. All rights reserved.
//

#import "EZRecycleImageView.h"

@interface EZRecycleImageView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UIImageView *centerImageView;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

@property (strong, nonatomic) NSArray<NSString *> *contents; //每张图片所对应的内容(NSString)
@property (strong, nonatomic) NSMutableArray *labelArray; //of contentLabels

@property (nonatomic) NSInteger imageCount;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation EZRecycleImageView

#pragma mark - init
- (instancetype)init {
    //默认size：（[UIScreen mainScreen].bounds.size.width, 180）
    return [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

#pragma mark - setter & getter
- (void)setImageInfo:(NSMutableDictionary *)imageInfo {
    _imageInfo = imageInfo;
    _imageCount = _imageInfo.count;
    _imageNames = [_imageInfo allKeys];
    if (_imageCount == 0) return ;
    if (_imageCount == 1) self.contentSize = CGSizeMake(self.frame.size.width , self.frame.size.height);
    [self loadImage];
    _contents = [_imageInfo allValues];
    [self addContentLabel];
}

- (void)setImageNames:(NSArray *)imageNames {
    _imageNames = imageNames;
    _imageCount = _imageNames.count;
    if (_imageCount == 0) return ;
    if (_imageCount == 1) self.contentSize = CGSizeMake(self.frame.size.width , self.frame.size.height);
    [self loadImage];
}

- (NSMutableArray *)labelArray {
    if (!_labelArray) {
        _labelArray = [[NSMutableArray alloc] init];
    }
    return _labelArray;
}

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheImage)];
    }
    return _tapGesture;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    }
    return _timer;
}

#pragma mark - Private Function
- (void)layoutUI {
    CGFloat viewWidth = self.frame.size.width, viewHeight = self.frame.size.height;
    self.delegate = self;
    self.contentSize = CGSizeMake(3*viewWidth , viewHeight);
    self.pagingEnabled = YES;
    [self setContentOffset:CGPointMake(viewWidth, 0) animated:NO];
    self.showsHorizontalScrollIndicator = NO;
    
    //添加ImageViews
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_leftImageView];
    _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(viewWidth, 0, viewWidth, viewHeight)];
    _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _centerImageView.userInteractionEnabled = YES;
    [_centerImageView addGestureRecognizer:self.tapGesture];
    [self addSubview:_centerImageView];
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * viewWidth, 0, viewWidth, viewHeight)];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_rightImageView];
}

- (void)loadImage {
    if (self.imageCount < 2) {
        [_leftImageView setImage:[UIImage imageNamed:self.imageNames[0]]];
        return ;
    }
    //设置默认图片
    _leftImageView.image = [UIImage imageNamed:self.imageNames[_imageCount - 1]];
    _centerImageView.image = [UIImage imageNamed:self.imageNames[0]];
    _rightImageView.image = [UIImage imageNamed:self.imageNames[1]];
    _currentImageIndex = 0;
    [self.timer fire];
}

- (void)changeImage {
    if (self.imageCount < 2) return ;
    NSInteger leftImageIndex, rightImageIndex;
    _currentImageIndex = (_currentImageIndex + 1) % _imageCount;
    _centerImageView.image = [UIImage imageNamed:self.imageNames[_currentImageIndex]];
    leftImageIndex = (_currentImageIndex + _imageCount - 1) % _imageCount;
    rightImageIndex = (_currentImageIndex + 1) % _imageCount;
    _leftImageView.image = [UIImage imageNamed:self.imageNames[leftImageIndex]];
    _rightImageView.image = [UIImage imageNamed:self.imageNames[rightImageIndex]];
    if (self.labelArray.count == _imageCount) {
        [_leftImageView addSubview:self.labelArray[leftImageIndex]];
        [_centerImageView addSubview:self.labelArray[_currentImageIndex]];
        [_rightImageView addSubview:self.labelArray[rightImageIndex]];
    }
    if ([_recycleImageDelegate respondsToSelector:@selector(rollDidEndDecelerating)]) {
        [_recycleImageDelegate rollDidEndDecelerating];
    }
}

- (void)addContentLabel {
    [_contents enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = CGRectMake(0, self.frame.size.height / 2.0, self.frame.size.width, self.frame.size.height / 2.0);
        UIView *view = [[UIView alloc] initWithFrame:rect];
        if (obj != [NSNull null]) {
            view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            NSString *content = (NSString *)obj;
            label.text = content;
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        } else {
            view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        }
        [self.labelArray addObject:view];
    }];
    if (self.imageCount < 2) {
        [_leftImageView addSubview:self.labelArray[0]];
        return ;
    }
    if (self.labelArray.count == _imageCount) {
        [_leftImageView addSubview:self.labelArray[_imageCount - 1]];
        [_centerImageView addSubview:self.labelArray[0]];
        [_rightImageView addSubview:self.labelArray[1]];
    }
}

- (void)tapTheImage {
    if ([_recycleImageDelegate respondsToSelector:@selector(tapImageView:)]) {
        [_recycleImageDelegate tapImageView:_currentImageIndex];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadImage];
    if ([_recycleImageDelegate respondsToSelector:@selector(rollDidEndDecelerating)]) {
        [_recycleImageDelegate rollDidEndDecelerating];
    }
}

- (void)reloadImage {
    if (self.imageCount < 2) return ;
    CGFloat viewWidth = self.frame.size.width;
    NSInteger leftImageIndex, rightImageIndex;
    CGPoint offset = [self contentOffset];
    if (offset.x > viewWidth) {
        //向右滑动
        _currentImageIndex = (_currentImageIndex + 1) % _imageCount;
    } else if (offset.x < viewWidth) {
        //向左滑动
        _currentImageIndex = (_currentImageIndex + _imageCount - 1) % _imageCount;
    }
    _centerImageView.image = [UIImage imageNamed:self.imageNames[_currentImageIndex]];
    leftImageIndex = (_currentImageIndex + _imageCount - 1) % _imageCount;
    rightImageIndex = (_currentImageIndex + 1) % _imageCount;
    _leftImageView.image = [UIImage imageNamed:self.imageNames[leftImageIndex]];
    _rightImageView.image = [UIImage imageNamed:self.imageNames[rightImageIndex]];
    if (self.labelArray.count == _imageCount) {
        [_leftImageView addSubview:self.labelArray[leftImageIndex]];
        [_centerImageView addSubview:self.labelArray[_currentImageIndex]];
        [_rightImageView addSubview:self.labelArray[rightImageIndex]];
    }
    
    [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}
@end
