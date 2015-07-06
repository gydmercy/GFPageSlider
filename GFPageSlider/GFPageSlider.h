//
//  GFPageSlider.h
//  GFPageSlider
//
//  Created by Mercy on 15/6/30.
//  Copyright (c) 2015年 Mercy. All rights reserved.
//
//  使用步骤：
//          1、初始化PageSlider,传入页面数量、各个页面的ViewController对象以及Titles
//          2、将其添加为当前View的子View
//          3、设置PageSlider属性(可选，不设置则使用默认值)
//

#import <UIKit/UIKit.h>

@interface GFPageSlider : UIView

/**
 * 以下三个属性均可外部配置：
 *
 * menuHeight 默认值为35.0f
 * menuNumberPerPage 默认值为4
 * indicatorLineColor 默认值为[UIColor redColor]
 */
@property (nonatomic) CGFloat menuHeight; // 菜单栏的高度
@property (nonatomic) int menuNumberPerPage; // 屏幕可见Menu数量
@property (nonatomic) UIColor *indicatorLineColor; // 下划线指示器的颜色


/**
 * PageSlider初始化函数
 *
 * @param   frame   想要设定的PageSlider控件的frame
 * @param   pageCount   滑动页的数目pageCount
 * @param   viewControllers   各个页面的ViewController
 * @param   titles   MenuButton的名称(titles参数可为nil，表示使用默认值)
 */
- (instancetype)initWithFrame:(CGRect)frame
                 numberOfPage:(int)pageCount
              viewControllers:(NSMutableArray *)viewControllers
             menuButtonTitles:(NSArray *)titles;

@end
