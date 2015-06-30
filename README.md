# GFPageSlider

### 概述

这是一个简易的页面滑动切换的模块，使用简单，耦合度低。  
菜单栏高度、屏幕可见Menu数量、指示器颜色、Menu文字这4个属性可外部配置，较灵活。

### 截图
![](http://7xjlak.com1.z0.glb.clouddn.com/pageslider1.png)
![](http://7xjlak.com1.z0.glb.clouddn.com/pageslider2.png)
![](http://7xjlak.com1.z0.glb.clouddn.com/pageslider3.png)

### 使用

1、引入头文件

	#import "GFPageSlider.h"
	
2、初始化该PageSlider对象，并将其添加为当前View的子View

	GFPageSlider *pageSlider = [[GFPageSlider alloc] initWithFrame:CGRectMake(0, 0, kSelfViewWidth, kSelfViewHeight - 64) withNumberOfPage:7]; // 此处的传入的参数只是示例，可修改
	[self.view addSubview:pageSlider];

3、初始化各个页面的ViewController，并传给PageSlider对象

	[pageSlider setupViewControllors:viewControllers]; // viewControllers是一个NSMutableArray对象，里面存了已经初始化的ViewController


4、设置PageSlider属性（可选，如果不设置则使用默认值）

	pageSlider.menuHeight = 40.0f;
    pageSlider.menuNumberPerPage = 5;
	pageSlider.indicatorLineColor = [UIColor blueColor];
    pageSlider.titles = [NSArray arrayWithObjects:@"头条", @"娱乐", @"热点", @"体育", @"汽车", @"科技", @"财经", nil];