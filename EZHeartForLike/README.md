![](logo.png)
    
    
![](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)
![](https://img.shields.io/badge/CocoaPods-v1.0.1-green.svg?style=flat)
![](https://img.shields.io/badge/platform-iOS-red.svg?style=flat)
> EZHeartForLike in Objective-C.    
> EZHeartForLike show the animation between two different view. As you can see in the following Pics, the Heart is generated in the UIImageView, and finally move to the UIView under.   
> EZHeartForLike 是点赞动画的实现，但是值得注意的是动画的**执行位置**，从下图可以看出，大桃心和小桃心所在的View是不同的View。因此解决动画的跨View实现才是EZHeartForLike的真正目的。具体实现的方式请看我的[博文](http://ezfen.github.io/2016/05/21/EZHeartForLike/)    
> 而且这个动画也是萌萌哒，希望你喜欢，哈哈哈哈

![](single.gif)
![](double.gif)


## How To Get Started

### Installation

You can install EZHeartForLike in a traditional way -- drag the **EZHeartForLike/EZHeartForLike/Module/View/EZHeartForLike** and **EZHeartForLike/EZHeartForLike/Module/Resources** into your project. However, it is strongly recommended that you install via CocoaPods.    
    
你可以直接在 **EZHeartForLike/EZHeartForLike/Module/View/EZHeartForLike**文件夹中将EZHeartForLike的.h、.m和**EZHeartForLike/EZHeartForLike/Module/Resources**两张桃心图加入到项目中直接使用

### Install with CocoaPods

CocoaPods is a dependency manager for Objective-C and Swift, which automates and simplifies the process of using 3rd-party libraries like EZHeartForLike in your projects.

* Podfile

	```           
	pod 'EZHeartForLike', '~> 1.0.1'
	```
	

### Usage

#### Create a EZHeartForLike

1. Import the "EZHeartForLike.h" to your controller.
    
    ``` 
    #import "EZHeartForLike.h"
    ```
    
2. Init the EZHeartForLike into your controller.

    ```
    EZHeartForLike *heart = [[EZHeartForLike alloc] initWithFrame:CGRectMake(0, 0, 24, 24) DisplayBigHeartOnView:self.tweetImageView];    
    ```
   If you want to do something after invoking the EZHeartForLike, set up the delegate.    
   一般来说，需要在动画执行结束后完成相关操作，设置代理并实现相关方法。
    
    ```
    heart.delegate = self;
    ```
创建的EZHeartForLike是右下角的小桃心（见图1）    
指定的displayView是上图的ImageView，可实现双击（见图2）

3. If you want the EZHeartForLike to show your own image, just set the likeImage and the unlikeImage using follow function (nonessential):     
如果你想使用自己的图片，就使用此方法设置（非必须）：   
 
    ```
    [heart setLikeImage:[UIImage imageNamed:@"liked"] unLikeImage:[UIImage imageNamed:@"unlike"]];
    ```    


4. add the EZHeartForLike to your view;

    ```
    [self.view addSubview:heart];
    ```
    
5. enjoy.  :)

#### EZHeartForLikeDelegate

* -(void)tapLike;    
    You can do something anter the **like** animation done.    
    
    ```
    - (void)tapLike {    
        ....
    }
    ```

* -(void)tapUnlike;    
	As "tapLike" function, you can do something after the **unlike** animation done;
    
    ```
    - (void)tapUnlike {    
        ....
    }
    ```

## update

	1.0.1     修复快速点击会卡死的bug。

## Issues, Bugs, Suggestions

Open an [issue](https://github.com/Ezfen/EZHeartForLike/issues)

## License

EZHeartForLike is available under the MIT license. See the LICENSE file for more info.
