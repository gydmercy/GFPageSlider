# GFPageSlider

It is a simple page slider module, easy to use and low coupling.    

It can be flexible to custom the height of the menubar, the visible number of menu in the menubar and the color of indicator.

## Screenshots
![](http://7xjlak.com1.z0.glb.clouddn.com/pageslider1.png)
![](http://7xjlak.com1.z0.glb.clouddn.com/pageslider2.png)
![](http://7xjlak.com1.z0.glb.clouddn.com/pageslider3.png)



## Installation

GFPageSlider is available on [CocoaPods](https://cocoapods.org/). Just add the following to your project Podfile:

	pod 'GFPageSlider'


## Usage

1、Import header file

	#import "GFPageSlider.h"
	
2、Initialize the page's controller and add them as current controller's child controller

	[self initViewControllers];
	
    [self addChildViewController:_viewControllers[0]];
    [self addChildViewController:_viewControllers[1]];
    [self addChildViewController:_viewControllers[2]];
    [self addChildViewController:_viewControllers[3]];


2、Initialize the PageSlider and input the parameters:its frame, number of page, view controllers and the titles of the menuButton

	GFPageSlider *pageSlider = [[GFPageSlider alloc] initWithFrame:CGRectMake(0, 0, kSelfViewWidth, kSelfViewHeight - 64)
                                                      numberOfPage:4
                                                   viewControllers:_viewControllers
                                                  menuButtonTitles:@[@"头条", @"娱乐", @"热点", @"体育"]];

3、Add pageSlider as the subview of current View

	[self.view addSubview:pageSlider];

4、Setting the properties of PageSlider (optional,if not set,use the default value)

	pageSlider.menuHeight = 40.0f;
    pageSlider.menuNumberPerPage = 5;
	pageSlider.indicatorLineColor = [UIColor blueColor];
    
5、If you want to add more pages, just prepare your page's controllers and then call this method

	[pageSlider addPagesWithPageCount:3
                      viewControllers:_viewControllers
                     menuButtonTitles:@[@"汽车", @"科技", @"财经"]];


## License

GFPageSlider is published under MIT License

	Copyright (c) 2015 Gu Gaofei (@gydmercy)

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.