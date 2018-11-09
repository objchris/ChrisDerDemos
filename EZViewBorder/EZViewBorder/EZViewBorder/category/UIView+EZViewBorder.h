//
//  UIView+EZViewBorder.h
//  EZViewBorder
//
//  Created by Chris Cheung on 2017/3/1.
//  Copyright © 2017年 Chris Cheung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ViewBorderPosition) {
    ViewBorderPositionDefault = 0,
    ViewBorderPositionLeft = 1 << 0,
    ViewBorderPositionRight = 1 << 1,
    ViewBorderPositionTop = 1 << 2,
    ViewBorderPositionBottom = 1 << 3,
    ViewBorderPositionTopLeft = 1 << 4,
    ViewBorderPositionTopRight = 1 << 5,
    ViewBorderPositionBottomLeft = 1 << 6,
    ViewBorderPositionBottomRight = 1 << 7,
    ViewBorderPositionLeftCorner = ViewBorderPositionLeft | ViewBorderPositionBottomLeft | ViewBorderPositionTopLeft,
    ViewBorderPositionRightCorner = ViewBorderPositionRight | ViewBorderPositionBottomRight | ViewBorderPositionTopRight,
    ViewBorderPositionTopCorner = ViewBorderPositionTop | ViewBorderPositionTopLeft | ViewBorderPositionTopRight,
    ViewBorderPositionBottomCorner = ViewBorderPositionBottom | ViewBorderPositionBottomLeft | ViewBorderPositionBottomRight
};

typedef NS_ENUM(NSUInteger, ViewBorderStyle) {
    ViewBorderStyleDotted,
    ViewBorderStyleDashed,
    ViewBorderStyleSolid
};

@interface UIView (EZViewBorder)

- (void)setBorder:(ViewBorderStyle)style;
- (void)setBorder:(ViewBorderStyle)style AtPosition:(ViewBorderPosition)position;
- (void)removeBorder;

@end
