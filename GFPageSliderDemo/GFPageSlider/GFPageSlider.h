//
//  GFPageSlider.h
//  GFPageSlider
//
//  Created by Mercy on 15/6/30.
//  Copyright (c) 2015年 Mercy. All rights reserved.
//
//  使用步骤：
//          1、初始化PageSlider,并将其添加为当前View的子View
//          2、初始化各个页面的ViewController，并传给PageSlider对象
//          3、设置PageSlider属性(不设置则使用默认值)
//

#import <UIKit/UIKit.h>

@interface GFPageSlider : UIView

/**
 * 以下四个属性均可外部配置：
 *
 * menuHeight 默认值为35.0f
 * menuNumberPerPage 默认值为4
 * indicatorLineColor 默认值为[UIColor redColor]
 * titles 默认值为[NSString stringWithFormat:@"第%d页",i + 1]
 *
 */
@property (nonatomic) CGFloat menuHeight; // 菜单栏的高度
@property (nonatomic) int menuNumberPerPage; // 屏幕可见Menu数量
@property (nonatomic) UIColor *indicatorLineColor; // 下划线指示器的颜色
@property (strong, nonatomic) NSArray *titles; // MenuButton的名称

/**
 * PageSlider初始化函数
 *
 * @param 1、想要设定的PageSlider控件的frame
 *        2、滑动页的数目pageCount
 *
 */
- (instancetype)initWithFrame:(CGRect)frame
             withNumberOfPage:(int)pageCount;

/**
 * 将ViewController添加到PageSlider上
 *
 * ViewController在外部初始化，存入NSMutableArray后传入
 * 传入的ViewController数量必须与pageCount大小一致
 *
 */
- (void)setupViewControllors:(NSMutableArray *)viewControllers;

@end
