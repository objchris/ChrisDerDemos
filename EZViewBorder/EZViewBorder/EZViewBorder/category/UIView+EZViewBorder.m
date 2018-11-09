//
//  UIView+EZViewBorder.m
//  EZViewBorder
//
//  Created by Chris Cheung on 2017/3/1.
//  Copyright © 2017年 Chris Cheung. All rights reserved.
//

#import "UIView+EZViewBorder.h"
#import <objc/runtime.h>

@implementation UIView (EZViewBorder)

static void *const ShapeLayerKey = "ShapeLayerKey";
static void *const BorderStyle = "BorderStyle";
static void *const BorderPosition = "BorderPosition";

#pragma mark - Public Method
- (void)setBorder:(ViewBorderStyle)style {
    [self setBorder:style AtPosition:ViewBorderPositionDefault];
}
- (void)setBorder:(ViewBorderStyle)style AtPosition:(ViewBorderPosition)position {
    
    if (style == ViewBorderStyleSolid && position == ViewBorderPositionDefault) {
        //默认设置borderColor和borderWidth就可以实现，因此直接Return;
        return;
    }
    
    CAShapeLayer *shapeLayer = [self shapeLayer:position];
    objc_setAssociatedObject(self.layer, ShapeLayerKey, shapeLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self.layer, BorderStyle, @(style), OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self.layer, BorderPosition, @(position), OBJC_ASSOCIATION_ASSIGN);
    [self usingStyle:style];
    self.layer.mask = shapeLayer;
    
    [self.layer addObserver:self forKeyPath:@"borderColor" options:NSKeyValueObservingOptionNew context:nil];
    [self.layer addObserver:self forKeyPath:@"borderWidth" options:NSKeyValueObservingOptionNew context:nil];
    [self.layer addObserver:self forKeyPath:@"cornerRadius" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeBorder {
    objc_setAssociatedObject(self.layer, ShapeLayerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self.layer, BorderStyle, nil, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self.layer, BorderPosition, nil, OBJC_ASSOCIATION_ASSIGN);
    [self.layer removeObserver:self forKeyPath:@"borderColor"];
    [self.layer removeObserver:self forKeyPath:@"borderWidth"];
    [self.layer removeObserver:self forKeyPath:@"cornerRadius"];
    self.layer.mask = nil;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 0;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"borderColor"]) {
        [self borderColorChanged:(__bridge CGColorRef)([change valueForKey:NSKeyValueChangeNewKey])];
    } else if ([keyPath isEqualToString:@"borderWidth"]) {
        [self borderWidthChanged:(NSNumber *)[change valueForKey:NSKeyValueChangeNewKey]];
    } else if ([keyPath isEqualToString:@"cornerRadius"]) {
        [self cornerRediusChanged];
    } else [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}
- (void)borderWidthChanged:(NSNumber *)newValue {
    CAShapeLayer *layer = objc_getAssociatedObject(self.layer, ShapeLayerKey);
    NSNumber *style = objc_getAssociatedObject(self.layer, BorderStyle);
    NSNumber *position = objc_getAssociatedObject(self.layer, BorderPosition);
    [self resetLineDashPattern:style.unsignedIntegerValue byWidth:[newValue floatValue]];
    layer.path = [self layerPath:position.unsignedIntegerValue].CGPath;
    layer.lineWidth = [newValue floatValue];
}
- (void)borderColorChanged:(CGColorRef)newValue {
    CAShapeLayer *layer = objc_getAssociatedObject(self.layer, ShapeLayerKey);
    layer.strokeColor = newValue;
}
- (void)cornerRediusChanged {
    CAShapeLayer *layer = objc_getAssociatedObject(self.layer, ShapeLayerKey);
    NSNumber *position = objc_getAssociatedObject(self.layer, BorderPosition);
    layer.path = [self layerPath:position.unsignedIntegerValue].CGPath;
    layer.lineDashPattern = [self computeLinePattern];
}


#pragma mark - create shapeLayer
- (CAShapeLayer *)shapeLayer:(ViewBorderPosition)position {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = [self layerPath:position].CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    return layer;
}

- (UIBezierPath *)layerPath:(ViewBorderPosition)position {
    if (position == ViewBorderPositionDefault) return [self rectangleBezierPath];
    else return [self irregularBezierPath:position];
}

- (UIBezierPath *)rectangleBezierPath {
    CGRect bounds = self.bounds;
    CGFloat borderWidth = self.layer.borderWidth;
    bounds.size.width -= borderWidth;
    bounds.size.height -= borderWidth;
    bounds.origin.x += borderWidth / 2.0;
    bounds.origin.y += borderWidth / 2.0;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:self.layer.cornerRadius];
    return bezierPath;
}

- (UIBezierPath *)irregularBezierPath:(ViewBorderPosition)position {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGFloat borderWidth = self.layer.borderWidth;
    CGFloat cornerRadius = self.layer.cornerRadius;
    if ((position & ViewBorderPositionTop) != 0) {
        CGPoint startPoint = CGPointMake(borderWidth / 2.0 + cornerRadius, borderWidth / 2.0);
        CGPoint endPoint = CGPointMake(self.bounds.size.width - borderWidth / 2.0 - cornerRadius, borderWidth / 2.0);
        [bezierPath moveToPoint:startPoint];
        [bezierPath addLineToPoint:endPoint];
    }
    if ((position & ViewBorderPositionBottom) != 0) {
        CGPoint startPoint = CGPointMake(borderWidth / 2.0 + cornerRadius, self.bounds.size.height - borderWidth / 2.0);
        CGPoint endPoint = CGPointMake(self.bounds.size.width - borderWidth / 2.0 - cornerRadius, self.bounds.size.height -borderWidth / 2.0);
        [bezierPath moveToPoint:startPoint];
        [bezierPath addLineToPoint:endPoint];
    }
    if ((position & ViewBorderPositionLeft) != 0) {
        CGPoint startPoint = CGPointMake(borderWidth / 2.0, borderWidth / 2.0 + cornerRadius);
        CGPoint endPoint = CGPointMake(borderWidth / 2.0, self.bounds.size.height - borderWidth / 2.0 - cornerRadius);
        [bezierPath moveToPoint:startPoint];
        [bezierPath addLineToPoint:endPoint];
    }
    if ((position & ViewBorderPositionRight) != 0) {
        CGPoint startPoint = CGPointMake(self.bounds.size.width - borderWidth / 2.0, borderWidth / 2.0 + cornerRadius);
        CGPoint endPoint = CGPointMake(self.bounds.size.width - borderWidth / 2.0, self.bounds.size.height - borderWidth / 2.0 - cornerRadius);
        [bezierPath moveToPoint:startPoint];
        [bezierPath addLineToPoint:endPoint];
    }
    if ((position & ViewBorderPositionTopLeft) != 0) {
        if (cornerRadius == 0) {
            CGPoint middlePoint = CGPointMake(borderWidth / 2.0, borderWidth / 2.0);
            [bezierPath moveToPoint:middlePoint];
            if ((position & ViewBorderPositionTop) == 0) {
                [bezierPath addLineToPoint:CGPointMake(borderWidth / 2.0 + self.bounds.size.width / 4.0, borderWidth / 2.0)];
                [bezierPath moveToPoint:middlePoint];
            }
            if ((position & ViewBorderPositionLeft) == 0) {
                [bezierPath addLineToPoint:CGPointMake(borderWidth / 2.0, borderWidth / 2.0 + self.bounds.size.height / 4.0)];
            }
        } else {
            [bezierPath addArcWithCenter:CGPointMake(borderWidth / 2.0 + cornerRadius, borderWidth / 2.0 + cornerRadius) radius:cornerRadius startAngle:M_PI endAngle:(M_PI_2 * 3) clockwise:YES];
        }
    }
    if ((position & ViewBorderPositionTopRight) != 0) {
        if (cornerRadius == 0) {
            CGPoint middlePoint = CGPointMake(self.bounds.size.width - borderWidth / 2.0, borderWidth / 2.0);
            [bezierPath moveToPoint:middlePoint];
            if ((position & ViewBorderPositionTop) == 0) {
                [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width - borderWidth / 2.0 - self.bounds.size.width / 4.0, borderWidth / 2.0)];
                [bezierPath moveToPoint:middlePoint];
            }
            if ((position & ViewBorderPositionRight) == 0) {
                [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width - borderWidth / 2.0, borderWidth / 2.0 + self.bounds.size.height / 4.0)];
            }
        } else {
            [bezierPath addArcWithCenter:CGPointMake(self.bounds.size.width - borderWidth / 2.0 - cornerRadius, borderWidth / 2.0 + cornerRadius) radius:cornerRadius startAngle:0 endAngle:(3 * M_PI_2) clockwise:NO];
        }
    }
    if ((position & ViewBorderPositionBottomRight) != 0) {
        if (cornerRadius == 0) {
            CGPoint middlePoint = CGPointMake(self.bounds.size.width - borderWidth / 2.0, self.bounds.size.height - borderWidth / 2.0);
            [bezierPath moveToPoint:middlePoint];
            if ((position & ViewBorderPositionBottom) == 0) {
                [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width - borderWidth / 2.0 - self.bounds.size.width / 4.0, self.bounds.size.height - borderWidth / 2.0)];
                [bezierPath moveToPoint:middlePoint];
            }
            if ((position & ViewBorderPositionRight) == 0) {
                [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width - borderWidth / 2.0, self.bounds.size.height - borderWidth / 2.0 - self.bounds.size.height / 4.0)];
            }
        } else {
            [bezierPath addArcWithCenter:CGPointMake(self.bounds.size.width - borderWidth / 2.0 - cornerRadius, self.bounds.size.height - borderWidth / 2.0 - cornerRadius) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        }
    }
    if ((position & ViewBorderPositionBottomLeft) != 0) {
        if (cornerRadius == 0) {
            CGPoint middlePoint = CGPointMake(borderWidth / 2.0, self.bounds.size.height - borderWidth / 2.0);
            [bezierPath moveToPoint:middlePoint];
            if ((position & ViewBorderPositionBottom) == 0) {
                [bezierPath addLineToPoint:CGPointMake(borderWidth / 2.0 + self.bounds.size.width / 4.0, self.bounds.size.height - borderWidth / 2.0)];
                [bezierPath moveToPoint:middlePoint];
            }
            if ((position & ViewBorderPositionLeft) == 0) {
                [bezierPath addLineToPoint:CGPointMake(borderWidth / 2.0, self.bounds.size.height - borderWidth / 2.0 - self.bounds.size.height / 4.0)];
            }
        } else {
            [bezierPath addArcWithCenter:CGPointMake(borderWidth / 2.0 + cornerRadius, self.bounds.size.height - borderWidth / 2.0 - cornerRadius) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        }
    }
    return bezierPath;
}

#pragma mark - set style 
- (void)usingStyle:(ViewBorderStyle)style {
    CAShapeLayer *layer = objc_getAssociatedObject(self.layer, ShapeLayerKey);
    layer.lineWidth = self.layer.borderWidth;
    layer.strokeColor = self.layer.borderColor;
    [self resetLineDashPattern:style byWidth:self.layer.borderWidth];
}

- (void)resetLineDashPattern:(NSUInteger)style byWidth:(CGFloat)borderWidth {
    CAShapeLayer *layer = objc_getAssociatedObject(self.layer, ShapeLayerKey);
    switch (style) {
        case ViewBorderStyleSolid:
            layer.lineDashPattern = nil;
            break;
        case ViewBorderStyleDashed:
            layer.lineDashPattern = [self computeLinePattern];
            break;
        case ViewBorderStyleDotted:
            layer.lineDashPattern = [self computeLinePattern];
            break;
    }
}

#pragma mark - assitant method
- (NSArray *)computeLinePattern {
    // 计算周长
    int perimeter = self.bounds.size.width * 2 + self.bounds.size.height * 2 - self.layer.cornerRadius * 8 + 2 * M_PI * self.layer.cornerRadius - self.layer.borderWidth * 2;
    NSNumber *style = objc_getAssociatedObject(self.layer, BorderStyle);
    switch (style.unsignedIntegerValue) {
        case ViewBorderStyleSolid:
            return nil;
        case ViewBorderStyleDashed:{
            CGFloat borderWidth = self.layer.borderWidth;
            int remainder = (int)perimeter % (int)(borderWidth * 6);
            int count = (int)perimeter / (int)(borderWidth * 6);
            return @[@(borderWidth*3),@(borderWidth* (3 + MAX((double)remainder / (double)count, 0.2)))];
        }
        case ViewBorderStyleDotted:{
            CGFloat borderWidth = self.layer.borderWidth;
            int remainder = (int)perimeter % (int)(borderWidth * 2);
            int count = (int)perimeter / (int)(borderWidth * 2);
            return @[@(borderWidth),@(borderWidth * (1 + (double)remainder / (double)count))];
        }
    }
    return nil;
}

@end
