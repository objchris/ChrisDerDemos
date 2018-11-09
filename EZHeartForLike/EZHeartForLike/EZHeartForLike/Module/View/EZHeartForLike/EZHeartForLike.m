//
//  EZHeartForLikeView.m
//  EZHeartForLike
//
//  Created by Netca on 16/5/6.
//  Copyright © 2016年 阿澤. All rights reserved.
//

#import "EZHeartForLike.h"

@interface EZHeartForLike()
@property (strong, nonatomic) UIImage *likeImage;       // 大小桃心的Image
@property (strong, nonatomic) UIImage *unlikeImage;     // 小桃心的Image
@property (strong, nonatomic) UIImageView *BigHeart;    // 显示在特定View上的大桃心
@property (nonatomic, getter=isLiked) BOOL liked;       // 标识符
@property (nonatomic, getter=canDoNextAnimation) BOOL nextAnimation;
@end

@implementation EZHeartForLike

#pragma mark - initial
- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 24, 24)];
}
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame DisplayBigHeartOnView:nil];
}
- (instancetype)initWithFrame:(CGRect)frame DisplayBigHeartOnView:(UIView *)displayView {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"unlike"];
        self.nextAnimation = YES;
        // 为小桃心添加单击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheSmallHeart:)];
        [self addGestureRecognizer:tap];
        // 将DisplayView保存起来，并为DisplayView添加双击事件
        if (displayView) {
            self.displayView = displayView;
            [self.displayView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
            doubleTap.numberOfTapsRequired = 2;
            [self.displayView addGestureRecognizer:doubleTap];
        }
    }
    return self;
}

# pragma mark - setImage
- (void)setLikeImage:(UIImage *)likeImage unLikeImage:(UIImage *)unlikeImage {
    self.unlikeImage = unlikeImage;
    self.likeImage = likeImage;
    self.image = unlikeImage;
}

# pragma mark - UITapGestureRecognizer
- (void)tapTheSmallHeart:(UIGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self transferOrRollOver];
    }
}
- (void)doubleTap:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self transferOrRollOver];
    }
}

# pragma mark - achieve function
- (void)transferOrRollOver {
    if (self.canDoNextAnimation) {
        self.nextAnimation = NO;
        if (!self.isLiked) {
            self.liked = YES;
            if (self.displayView) {
                // 指定了显示大桃心的View，显示大桃心
                [self displayBigHeartAndMove];
            } else {
                // 没有指定显示大桃心的View，直接翻转
                [self rollOver];
            }
        } else {
            // 取消like，直接翻转
            [self rollOver];
            self.liked = NO;
        }
    }
}

# pragma mark - withDisplayView
- (void)displayBigHeartAndMove {
    self.BigHeart = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.BigHeart.image = self.likeImage ? self.likeImage : [UIImage imageNamed:@"liked"];
    self.BigHeart.backgroundColor = [UIColor clearColor];
    self.BigHeart.center = self.displayView.center;
    [self.displayView addSubview:self.BigHeart];
    // 动态在displayView上展示大桃心
    CGFloat displayViewWidth = self.displayView.bounds.size.width, displayViewHeight = self.displayView.bounds.size.height;
    CGFloat scaleMultiples = MIN(displayViewWidth, displayViewHeight) * .6;     // 计算大桃心的最大时的Size
    __weak EZHeartForLike *weakSelf = self;
    [UIView animateWithDuration:.2 animations:^{
        CGAffineTransform transform = CGAffineTransformScale(weakSelf.BigHeart.transform, scaleMultiples, scaleMultiples);
        weakSelf.BigHeart.transform = transform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:.6 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.BigHeart.transform = CGAffineTransformScale(weakSelf.BigHeart.transform, 0.8, 0.8);
        } completion:^(BOOL finished) {
            [weakSelf MoveToSmallHeart];
        }];
    }];
}
- (void)MoveToSmallHeart {
    // 获得共同的SuperView
    UIView * mutualSuperView = [self findTheMutualSuperView];
    
    // 然后映射两个Heart的坐标。
    // 首先是小桃心(self)
    UIView *view1 = self;
    CGPoint smallHeartPoint = CGPointZero;
    while (view1 != mutualSuperView) {
        smallHeartPoint.x += view1.frame.origin.x;
        smallHeartPoint.y += view1.frame.origin.y;
        view1 = view1.superview;
    }
    // 其次是大桃心(self.BigHeart)
    UIView *view2 = self.BigHeart;
    CGPoint bigHeartPoint = CGPointZero;
    while (view2 != mutualSuperView) {
        bigHeartPoint.x += view2.frame.origin.x;
        bigHeartPoint.y += view2.frame.origin.y;
        view2 = view2.superview;
    }
    
    // 在SuperView上完成Transform Animation
    self.BigHeart.hidden = YES;
    CGRect rect = self.BigHeart.frame;
    rect.origin.x = bigHeartPoint.x;
    rect.origin.y = bigHeartPoint.y;
    __block UIImageView *tempBigHeart = [[UIImageView alloc] initWithFrame:rect];
    tempBigHeart.image = self.likeImage ? self.likeImage : [UIImage imageNamed:@"liked"];
    [mutualSuperView addSubview:tempBigHeart];
    __weak EZHeartForLike *weakSelf = self;
    [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect rect = tempBigHeart.frame;
        CGFloat offsets = rect.size.width * 0.5;
        if (bigHeartPoint.x < smallHeartPoint.x) rect.origin.x -= offsets;
        else rect.origin.x += offsets;
        if (bigHeartPoint.y < smallHeartPoint.y) rect.origin.y -= offsets;
        else rect.origin.y += offsets;
        tempBigHeart.frame = rect;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:.6 initialSpringVelocity:12.0 options:UIViewAnimationOptionCurveEaseInOut
        animations:^{
            CGRect rect = weakSelf.frame;
            rect.origin.x = smallHeartPoint.x;
            rect.origin.y = smallHeartPoint.y;
            tempBigHeart.frame = rect;
        } completion:^(BOOL finished) {
            [tempBigHeart removeFromSuperview];
            tempBigHeart = nil;
            weakSelf.image = self.likeImage ? self.likeImage : [UIImage imageNamed:@"liked"];
            if ([weakSelf.delegate respondsToSelector:@selector(tapLike)]) [weakSelf.delegate tapLike];
            weakSelf.nextAnimation = YES;
        }];
    }];
    [self.BigHeart removeFromSuperview];
    self.BigHeart = nil;
}
- (UIView *)findTheMutualSuperView {
    // 找出小桃心（self）和大桃心（self.BigHeart）的共同的SuperView
    // 计算self到UIWindow的距离（以中间View的层数为距离计量）
    UIView *view1 = self;
    NSInteger smallViewSuperViewCount = 0;
    while (![view1 isKindOfClass:[UIWindow class]]) {
        smallViewSuperViewCount ++;
        view1 = view1.superview;
    }
    // 计算self.BigHeart到UIWindow的距离（以中间View的层数为距离计量）
    UIView *view2 = self.BigHeart;
    NSInteger bigViewSuperViewCount = 0;
    while (![view2 isKindOfClass:[UIWindow class]]) {
        bigViewSuperViewCount ++;
        view2 = view2.superview;
    }
    // 共同的SuperView之后的View肯定是一致的，因此小桃心和大桃心到UIWindow的距离之间的差
    // 实在共同的SuperView之前就存在的。所以，判断二者到UIWindow的距离大小，并利用两者之间
    // 的差距就可以找到共同的SuperView
    NSInteger mutualViewCount = labs(smallViewSuperViewCount - bigViewSuperViewCount);
    view1 = self;
    view2 = self.BigHeart;
    if (smallViewSuperViewCount > bigViewSuperViewCount) {
        for (int i = 0; i < mutualViewCount; ++ i) {
            view1 = view1.superview;
        }
    } else {
        for (int i = 0; i < mutualViewCount; ++ i) {
            view2 = view2.superview;
        }
    }
    while (view1 != view2) {
        view1 = view1.superview;
        view2 = view2.superview;
    }
    return view1;
}

#pragma mark - withoutDisplayView
- (void)rollOver {
    __weak EZHeartForLike *weakSelf = self;
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // 当前状态为"Liked"，翻转回"Unlike"
         weakSelf.transform = CGAffineTransformScale(weakSelf.transform, -1, 1);
        weakSelf.image = self.unlikeImage ? self.unlikeImage : [UIImage imageNamed:@"unlike"];
    } completion:^(BOOL finished) {
        weakSelf.nextAnimation = YES;
        if ([weakSelf.delegate respondsToSelector:@selector(tapUnlike)]) [weakSelf.delegate tapUnlike];
    }];
}
@end
