//
//  TweetTableViewCell.m
//  EZHeartForLike
//
//  Created by 阿澤🍀 on 16/5/4.
//  Copyright © 2016年 阿澤. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "EZHeartForLike.h"

@interface TweetTableViewCell() <EZHeartForLikeDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *tweetImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *avatorImageView;
@property (weak, nonatomic) IBOutlet UIView *messageContainerView;
@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    self.containerView.layer.cornerRadius = 10;
    self.containerView.clipsToBounds = YES;
    self.avatorImageView.layer.cornerRadius = CGRectGetWidth(self.avatorImageView.bounds) / 2.0 + 1;
    self.avatorImageView.clipsToBounds = YES;
    CGPoint center = self.avatorImageView.center;
    center.x = center.x + 280;
    EZHeartForLike *heart = [[EZHeartForLike alloc] initWithFrame:CGRectMake(0, 0, 24, 24) DisplayBigHeartOnView:self.tweetImageView];
    [heart setLikeImage:[UIImage imageNamed:@"liked"] unLikeImage:[UIImage imageNamed:@"unlike"]];
    heart.center = center;
    heart.delegate = self;
    [self.messageContainerView addSubview:heart];
}

- (void)setTweetImageName:(NSString *)tweetImageName {
    _tweetImageName = tweetImageName;
    self.tweetImageView.image = [UIImage imageNamed:self.tweetImageName];
}

- (void)tapUnlike {
    NSLog(@"unlike");
}
- (void)tapLike {
    NSLog(@"like");
}

@end
