# GFPageSlider

### 概述

这是一个简易的页面滑动切换的模块，使用简单，耦合度低。  
菜单栏高度、屏幕可见Menu数量、指示器颜色这3个属性可外部配置，较灵活。

### 截图
![](http://7xjlak.com1.z0.glb.clouddn.com/pageslider1.png)
![](http://7xjlak.com1.z0.glb.clouddn.com/pageslider2.png)
![](http://7xjlak.com1.z0.glb.clouddn.com/pageslider3.png)

### 使用

1、引入头文件

	#import "GFPageSlider.h"
	
2、初始化PageSlider,传入页面数量、各个页面的ViewController对象以及Titles

	GFPageSlider *pageSlider = [[GFPageSlider alloc] initWithFrame:CGRectMake(0, 0, kSelfViewWidth, kSelfViewHeight - 64)
                                                   andNumberOfPage:7
                                                andViewControllers:_viewControllers
                                               andMenuButtonTitles:[NSArray arrayWithObjects:@"头条", @"娱乐", @"热点", @"体育", @"汽车", @"科技", @"财经", nil]];

3、将其添加为当前View的子View

	[self.view addSubview:pageSlider];

4、设置PageSlider属性（可选，如果不设置则使用默认值）

	pageSlider.menuHeight = 40.0f;
    pageSlider.menuNumberPerPage = 5;
	pageSlider.indicatorLineColor = [UIColor blueColor];
    