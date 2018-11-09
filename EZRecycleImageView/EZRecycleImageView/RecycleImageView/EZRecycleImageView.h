//
//  RollingImageScrollView.h
//
//  Created by 阿澤🍀 on 15/12/8.
//  Copyright © 2015年 阿澤. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EZRecycleImageViewDelegate <NSObject>
@optional
//当滑动图片结束时调用，可配合pageControl使用
- (void)rollDidEndDecelerating;
//点击ImageView时出触发（when click the ImageView）
- (void)tapImageView:(NSInteger)imageIndex;
@end


@interface EZRecycleImageView : UIScrollView

@property (nonatomic) NSInteger currentImageIndex; //当前处于第几张图片
@property (strong, nonatomic) NSDictionary *imageInfo; //所有图片的信息
@property (strong, nonatomic) NSArray *imageNames; //所有图片的名称
@property (nonatomic) id<EZRecycleImageViewDelegate> recycleImageDelegate; //delagate

- (void)changeImage; //提供更换图片的方法，可用于设置定时器

@end
