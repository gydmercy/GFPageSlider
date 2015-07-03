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
    
    
    
    // 初始化各个页面的ViewController
    [self initViewControllers];
    
    // GFPageSlider使用步骤：
    
    // 1、初始化PageSlider,传入页面数量、各个页面的ViewController对象以及Titles
    GFPageSlider *pageSlider = [[GFPageSlider alloc] initWithFrame:CGRectMake(0, 0, kSelfViewWidth, kSelfViewHeight - 64)
                                                   andNumberOfPage:7
                                                andViewControllers:_viewControllers
                                               andMenuButtonTitles:[NSArray arrayWithObjects:@"头条", @"娱乐", @"热点", @"体育", @"汽车", @"科技", @"财经", nil]];
    
    // 2、将其添加为当前View的子View
    [self.view addSubview:pageSlider];
    
    // 3、设置PageSlider属性(不设置则使用默认值)
//    pageSlider.menuHeight = 40.0f;
    pageSlider.menuNumberPerPage = 5;
//    pageSlider.indicatorLineColor = [UIColor blueColor];

    
}

- (void)initViewControllers {
    // 初始化各个页面的ViewController
    FirstViewController *fvc = [[FirstViewController alloc] init];
    SecondViewController *svc = [[SecondViewController alloc] init];
    ThirdViewController *tvc = [[ThirdViewController alloc] init];
    FourthViewController *fovc = [[FourthViewController alloc] init];
    FifthViewController *fivc = [[FifthViewController alloc] init];
    SixthViewController *sivc = [[SixthViewController alloc] init];
    SeventhViewController *sevc = [[SeventhViewController alloc] init];
    
    // 将这些ViewController对象加到数组中
    _viewControllers = [[NSMutableArray alloc] init];
    [_viewControllers addObject:fvc];
    [_viewControllers addObject:svc];
    [_viewControllers addObject:tvc];
    [_viewControllers addObject:fovc];
    [_viewControllers addObject:fivc];
    [_viewControllers addObject:sivc];
    [_viewControllers addObject:sevc];
}





@end
