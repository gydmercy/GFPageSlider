//
//  GFPageSlider.h
//  GFPageSlider
//
//  Created by Mercy on 15/6/30.
//  Copyright (c) 2015年 Mercy. All rights reserved.
//
//  使用步骤：
//          1、初始化各个页面的视图控制器
//          2、将各个页面的视图控制器添加为当前控制器的子控制器
//          3、初始化PageSlider,传入页面数量、各个页面的ViewController对象以及Titles
//          4、将PageSlider添加为当前控制器视图的子视图
//          5、设置PageSlider属性(不设置则使用默认值)
//          6、若要添加更多页面，则先初始化要添加的试图控制器，然后将其添加为当前控制器的自控制器，再调用
//             addPagesWithPageCount:viewControllers:menuButtonTitles 方法进行添加
//

#import <UIKit/UIKit.h>

@interface GFPageSlider : UIView

/**
 * 以下三个属性均可外部配置：
 *
 * menuHeight         默认值为35.0f
 * menuNumberPerPage  默认值为4
 * indicatorLineColor 默认值为[UIColor redColor]
 */
@property (nonatomic) CGFloat menuHeight; //!< 菜单栏的高度
@property (nonatomic) int menuNumberPerPage; //!< 屏幕可见Menu数量
@property (nonatomic) UIColor *indicatorLineColor; //!< 下划线指示器的颜色



/**
 *  PageSlider初始化函数
 *
 *  @param frame           想要设定的PageSlider控件的frame
 *  @param pageCount       滑动页的数目pageCount
 *  @param viewControllers 各个页面的ViewController
 *  @param titles          MenuButton的名称(titles参数可为nil，表示使用默认值)
 */
- (instancetype)initWithFrame:(CGRect)frame
                 numberOfPage:(int)pageCount
              viewControllers:(NSMutableArray *)viewControllers
             menuButtonTitles:(NSArray *)titles;

/**
 *  添加页面视图
 *
 *  @param pageCount       将要添加的滑动页的数目pageCount
 *  @param viewControllers 将要添加的各个页面的ViewController
 *  @param titles          将要添加的MenuButton的名称
 */
- (void)addPagesWithPageCount:(int)pageCount
              viewControllers:(NSMutableArray *)viewControllers
             menuButtonTitles:(NSArray *)titles;

@end
