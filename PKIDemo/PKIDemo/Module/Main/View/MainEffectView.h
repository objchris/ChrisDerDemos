//
//  MainEffectView.h
//  PKIDemo
//
//  Created by ezfen on 16/4/18.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainEffectView;
@protocol MainEffectViewDelegate <NSObject>
- (void)clickButtonTag:(NSInteger)tag inView:(MainEffectView *)view;
@end

@interface MainEffectView : UIView

@property (weak, nonatomic) id<MainEffectViewDelegate> delegate;

@end
