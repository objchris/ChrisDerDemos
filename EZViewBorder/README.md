# EZViewBorder
![](https://img.shields.io/badge/platform-iOS-red.svg?style=flat)![](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)

A category of border for UIView.

## How to use

使用前先导入EZViewBorder/category中的两个文件，代码中引用。

```objective-c
#import "UIView+EZViewBorder.h"
```

一行代码为View加上Border。

```objective-c
[_view setBorder:ViewBorderStyleDashed AtPosition:ViewBorderPositionDefault];
```

说一行代码貌似也有点过分了，毕竟线条宽度，颜色，还有View是否圆角还需要另外定义，但是使用原来的定义方法就可以了；

```objective-c
_view.layer.borderColor = [UIColor redColor].CGColor;
_view.layer.borderWidth = 1;
_view.layer.cornerRadius = 10;
```

对于cornerRadius，有必要说明一下：当前只能处理cornerRadius <= MIN(View.bounds.size.width, View.bounds.size.height)的情况，因为我还不能很好地理解cornerRadius是怎么被计算出来的。

因为加了KVO，所以上述方法的调用不分先后，且在之后的代码中可以随意修改Color、Width、CornerRadius，且多亏了Core Animation，修改这三者伴有动画效果产生。

## Explain the enum

可以选择所要添加的位置，例如：Top，TopLeft，TopCorner（Top + TopLeft）…也可以选择线条样式：solid，dashed，dotted。

这二者所对应的enum为：

```objective-c
// 边框位置，上下左右左上右下等等。
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
```

```objective-c
// 线条形式：点、虚线、实线。
typedef NS_ENUM(NSUInteger, ViewBorderStyle) {
    ViewBorderStyleDotted,
    ViewBorderStyleDashed,
    ViewBorderStyleSolid
};
```



