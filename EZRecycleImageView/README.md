![](logo.png)
![](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)
![](https://img.shields.io/badge/CocoaPods-v0.0.2-green.svg?style=flat)
![](https://img.shields.io/badge/platform-iOS-red.svg?style=flat)
> EZRecycleImageView in Objective-C.
> EZRecycleImageView show Images as many as you want by using of three UIImageView.the > EZRecycleImageViewDelegate provide you the way to set the timer and the way to do something after the imageView changed.

![](autoRoll.gif)
![](click.gif)
![](gesture.gif)


## How To Get Started

### Installation

You can install EZRecycleImageView in a traditional way -- drag the **RecycleImageView folder** into your project. However, it is strongly recommended that you install via CocoaPods.


### Install with CocoaPods

CocoaPods is a dependency manager for Objective-C and Swift, which automates and simplifies the process of using 3rd-party libraries like EZRecycleImageView in your projects.

* Podfile

	```
	platform :ios, '7.0'           
	pod 'EZRecycleImageView', '~> 0.0.2'
	```
	

### Usage

#### Create a EZRecycleImageView

1. import the "EZRecycleImageView.h" to your controller
    
    ``` objc
    #import "EZRecycleImageView.h"
    ```
    
2. init the EZRecycleImageView into your controller and add the recycleImageDelegate to your controller.

    ```
    _simpleRIV = [[EZRecycleImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 180)];    
    _simpleRIV.recycleImageDelegate = self;
    ```

3. set the imageNames array or the imageInfo dictionary.

    ```
    simpleROSV.imageNames = @[@"0",@"1",@"2"];
    ```    
    
    or    
    
    ```
    NSDictionary *dic = @{@"1":@"第一张",@"2":@"第二张",@"3":@"第三张",@"4":@"第四张",@"5":@"第五张"};
    ```    
    
    the key is the name of the image and the value is the label text onto the alpha background. If you do not want to show the label of some of the image, just make the value as `[NSNull null]`    

4. add the EZRecycleImageView to your view;

    ```
    [self.view addSubview:_simpleRIV];
    ```
 
                                              
#### EZRecycleImageViewDelegate

* -(void)rollDidEndDecelerating

    You can set the PageControl and watch the imageIndex change and update the index of your pageControl.    
    
    ```
    - (void)rollDidEndDecelerating {    
        long index = _simpleRIV.currentImageIndex;    
        _pageControl.currentPage = index;
    }
    ```

* -(void)tapImageView:(NSInteger)imageIndex

    When you touch the imageView, EZRecycleImageView will tell you what image you are clicking and you can do something with the index.    
    
    ```
    - (void)tapImageView:(NSInteger)imageIndex {    
        NSString *message = [NSString stringWithFormat:@"%li",imageIndex];    
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"点击" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];    
        [view show];    
    }
    ```

## Issues, Bugs, Suggestions

Open an [issue](https://github.com/Ezfen/EZRecycleImageView/issues)

## License

EZRecycleImageView is available under the MIT license. See the LICENSE file for more info.