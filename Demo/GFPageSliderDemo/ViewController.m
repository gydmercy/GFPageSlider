//
//  ViewController.m
//  GFPageSliderDemo
//
//  Created by Mercy on 15/6/30.
//  Copyright (c) 2015年 Mercy. All rights reserved.
//

#import "ViewController.h"
#import "GFPageSlider.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"
#import "SeventhViewController.h"


@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *viewControllers;

@end

#define kSelfViewWidth self.view.frame.size.width
#define kSelfViewHeight self.view.frame.size.height


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GFPageSliderDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone; // 内容不扩展
    
    
    
    // GFPageSlider使用步骤：
    
    // 1、初始化各个页面的视图控制器
    [self initViewControllers];
    
    // 2、将各个页面的视图控制器添加为当前控制器的子控制器
    [self addChildViewController:_viewControllers[0]];
    [self addChildViewController:_viewControllers[1]];
    [self addChildViewController:_viewControllers[2]];
    [self addChildViewController:_viewControllers[3]];
    
    // 3、初始化PageSlider,传入页面数量、各个页面的ViewController对象以及Titles
    GFPageSlider *pageSlider = [[GFPageSlider alloc] initWithFrame:CGRectMake(0, 0, kSelfViewWidth, kSelfViewHeight - 64)
                                                      numberOfPage:4
                                                   viewControllers:_viewControllers
                                                  menuButtonTitles:@[@"头条", @"娱乐", @"热点", @"体育"]];
    
    
    
    // 4、将PageSlider添加为当前控制器视图的子视图
    [self.view addSubview:pageSlider];
    
    // 5、设置PageSlider属性(不设置则使用默认值)
//    pageSlider.menuHeight = 40.0f;
    pageSlider.menuNumberPerPage = 5;
//    pageSlider.indicatorLineColor = [UIColor blueColor];
    
    
    
    // 6、若要添加更多页面，则先初始化要添加的试图控制器，然后将其添加为当前控制器的自控制器，再调用 addPagesWithPageCount:viewControllers:menuButtonTitles 方法进行添加
    
    [self initOhterViewControllers];
    
    [self addChildViewController:_viewControllers[0]];
    [self addChildViewController:_viewControllers[1]];
    [self addChildViewController:_viewControllers[2]];
    
    [pageSlider addPagesWithPageCount:3
                      viewControllers:_viewControllers
                     menuButtonTitles:@[@"汽车", @"科技", @"财经"]];
    
}

- (void)initViewControllers {
    // 初始化各个页面的ViewController
    FirstViewController *fvc = [[FirstViewController alloc] init];
    SecondViewController *svc = [[SecondViewController alloc] init];
    ThirdViewController *tvc = [[ThirdViewController alloc] init];
    FourthViewController *fovc = [[FourthViewController alloc] init];
    
    
    // 将这些ViewController对象加到数组中
    _viewControllers = [[NSMutableArray alloc] init];
    [_viewControllers addObject:fvc];
    [_viewControllers addObject:svc];
    [_viewControllers addObject:tvc];
    [_viewControllers addObject:fovc];
    
}

- (void)initOhterViewControllers {
    FifthViewController *fivc = [[FifthViewController alloc] init];
    SixthViewController *sivc = [[SixthViewController alloc] init];
    SeventhViewController *sevc = [[SeventhViewController alloc] init];
    
    // 先清空之前存储的控制器
    [_viewControllers removeAllObjects];
    [_viewControllers addObject:fivc];
    [_viewControllers addObject:sivc];
    [_viewControllers addObject:sevc];
}





@end
