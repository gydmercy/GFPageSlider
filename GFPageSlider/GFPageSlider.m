//
//  GFPageSlider.m
//  GFPageSlider
//
//  Created by Mercy on 15/6/30.
//  Copyright (c) 2015年 Mercy. All rights reserved.
//

#import "GFPageSlider.h"


@interface GFPageSlider() <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *menuScrollView; //!< 菜单栏
@property (strong, nonatomic) UIScrollView *contentScrollView; //!< 滑动页部分
@property (strong, nonatomic) UIView *partitionLine; //!< 分隔线
@property (strong, nonatomic) UIView *indicatorLine; //!< 下划线指示器
@property (strong, nonatomic) UIButton *formerButton; //!< 前一次选择的MenuButton
@property (nonatomic) int pageCount; //!< 页面数量
@property (nonatomic) NSInteger currentPage; //!< 当前页

@end

#define kSelfViewWidth self.frame.size.width
#define kSelfViewHeight self.frame.size.height

static const CGFloat kIndicatorLineHeight = 2.2f; // 下划线指示器的高度
static const CGFloat kPartitionLineHeight = 0.3f; // 分隔线高度


@implementation GFPageSlider


#pragma mark -

- (instancetype)initWithFrame:(CGRect)frame
                 numberOfPage:(int)pageCount
              viewControllers:(NSMutableArray *)viewControllers
             menuButtonTitles:(NSArray *)titles {
    
    self = [super initWithFrame:frame];
    if (self) {
        _pageCount = pageCount;
        _currentPage = 0; // 初始为第一页
        
        _menuHeight = 35.0f; // 默认Menu高度为35.0f
        _menuNumberPerPage = 4; // 默认屏幕可见Menu为4个
        _indicatorLineColor = [UIColor redColor]; // 默认IndicatorLine颜色为红色
        
        
        [self initFirstSubView];
        
        [self initMenuScrollView];
        [self initPartitionLine];
        [self initIndicatorLine];
        [self initContentScrollView];
        
        
        [self setupViewControllors:viewControllers withFormerPageCount:0];
        [self setupMenuButtonsWithFormerPageCount:0];
        // 如果初始化的时候定义了MenuButton的Title，则设置，否则使用默认值[NSString stringWithFormat:@"第%d页",i + 1]
        if (titles) {
            [self setupTitles:titles withFormerPageCount:0];
        }
    }
    
    return self;
}

- (void)addPagesWithPageCount:(int)pageCount
              viewControllers:(NSMutableArray *)viewControllers
             menuButtonTitles:(NSArray *)titles {
    
    _pageCount += pageCount;
    
    [self adjustMenuScrollViewAndContentScrollViewContentSize];
    
    [self setupViewControllors:viewControllers withFormerPageCount:(_pageCount - pageCount)];
    [self setupMenuButtonsWithFormerPageCount:(_pageCount - pageCount)];
    if (titles) {
        [self setupTitles:titles withFormerPageCount:(_pageCount - pageCount)];
    }
    
}


#pragma mark - Initialization

- (void)initFirstSubView {
    // 添加这个view，使得 MenuScrollView 不是第一个子视图，这样就可以解决iOS7之后 automaticallyAdjustsScrollViewInsets 引发的问题。
    UIView *firstSubView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kSelfViewWidth, 0.1)];
    [self addSubview:firstSubView];
}

- (void)initMenuScrollView {
    _menuScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSelfViewWidth, _menuHeight)];
    _menuScrollView.contentSize = CGSizeMake(kSelfViewWidth / _menuNumberPerPage * _pageCount, _menuHeight);
    _menuScrollView.backgroundColor = [UIColor whiteColor];
    _menuScrollView.bounces = YES;
    _menuScrollView.alwaysBounceHorizontal = YES;
    _menuScrollView.showsHorizontalScrollIndicator = NO;
    _menuScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_menuScrollView];
}

- (void)initPartitionLine {
    _partitionLine = [[UIView alloc] initWithFrame:CGRectMake(0, _menuHeight - kPartitionLineHeight, kSelfViewWidth / _menuNumberPerPage * _pageCount, kPartitionLineHeight)];
    _partitionLine.backgroundColor = [UIColor colorWithRed:218.0f / 255.0 green:218.0f / 255.0 blue:218.0f / 255.0 alpha:1];
    [_menuScrollView addSubview:_partitionLine];
}

- (void)initIndicatorLine {
    _indicatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, _menuHeight - kIndicatorLineHeight, kSelfViewWidth / _menuNumberPerPage, kIndicatorLineHeight)];
    _indicatorLine.backgroundColor = _indicatorLineColor;
    [_menuScrollView addSubview:_indicatorLine];
}

- (void)initContentScrollView {
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _menuHeight, kSelfViewWidth, kSelfViewHeight - _menuHeight)];
    _contentScrollView.contentSize = CGSizeMake(_pageCount * kSelfViewWidth, kSelfViewHeight - _menuHeight);
    _contentScrollView.delegate = self;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.bounces = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_contentScrollView];
}


#pragma mark - Settings

// 设置菜单栏高度
- (void)setMenuHeight:(CGFloat)menuHeight {
    _menuHeight = menuHeight;
    
    _menuScrollView.frame = CGRectMake(0, 0, kSelfViewWidth, _menuHeight);
    _menuScrollView.contentSize = CGSizeMake(kSelfViewWidth / _menuNumberPerPage * _pageCount, _menuHeight);
    _partitionLine.frame = CGRectMake(0, _menuHeight - kPartitionLineHeight, kSelfViewWidth / _menuNumberPerPage * _pageCount, kPartitionLineHeight);
    _indicatorLine.frame = CGRectMake(0, _menuHeight - kIndicatorLineHeight, kSelfViewWidth / _menuNumberPerPage, kIndicatorLineHeight);
    _contentScrollView.frame = CGRectMake(0, _menuHeight, kSelfViewWidth, kSelfViewHeight - _menuHeight);
    _contentScrollView.contentSize = CGSizeMake(_pageCount * kSelfViewWidth, kSelfViewHeight - _menuHeight);
    for (int i = 0; i < _pageCount ; ++ i) {
        UIButton *button = (UIButton *)[self.menuScrollView viewWithTag:i + 1000];
        button.frame = CGRectMake(i * (kSelfViewWidth / _menuNumberPerPage), 0, kSelfViewWidth / _menuNumberPerPage, _menuHeight - kIndicatorLineHeight);
    }
}

// 设置屏幕可见Menu数量
- (void)setMenuNumberPerPage:(int)menuNumberPerPage {
    _menuNumberPerPage = menuNumberPerPage;
    
    _menuScrollView.contentSize = CGSizeMake(kSelfViewWidth / _menuNumberPerPage * _pageCount, _menuHeight);
    _partitionLine.frame = CGRectMake(0, _menuHeight - kPartitionLineHeight, kSelfViewWidth / _menuNumberPerPage * _pageCount, kPartitionLineHeight);
    _indicatorLine.frame = CGRectMake(0, _menuHeight - kIndicatorLineHeight, kSelfViewWidth / _menuNumberPerPage, kIndicatorLineHeight);
    for (int i = 0; i < _pageCount ; ++ i) {
        UIButton *button = (UIButton *)[self.menuScrollView viewWithTag:i + 1000];
        button.frame = CGRectMake(i * (kSelfViewWidth / _menuNumberPerPage), 0, kSelfViewWidth / _menuNumberPerPage, _menuHeight - kIndicatorLineHeight);
    }
}

// 设置指示器颜色
- (void)setIndicatorLineColor:(UIColor *)indicatorLineColor {
    _indicatorLineColor = indicatorLineColor;
    
    _indicatorLine.backgroundColor = indicatorLineColor;
    [_formerButton setTitleColor:_indicatorLineColor forState:UIControlStateNormal];
}


#pragma mark - Functions

- (void)adjustMenuScrollViewAndContentScrollViewContentSize {
    _menuScrollView.contentSize = CGSizeMake(kSelfViewWidth / _menuNumberPerPage * _pageCount, _menuHeight);
    _contentScrollView.contentSize = CGSizeMake(_pageCount * kSelfViewWidth, kSelfViewHeight - _menuHeight);
    
    _partitionLine.frame = CGRectMake(0, _menuHeight - kPartitionLineHeight, kSelfViewWidth / _menuNumberPerPage * _pageCount, kPartitionLineHeight);
}

// 设置传入的ViewController
- (void)setupViewControllors:(NSMutableArray *)viewControllers withFormerPageCount:(int)formerPageCount {
    
    for (int i = formerPageCount; i < _pageCount; ++ i) {
        UIViewController *vc = (UIViewController *)[viewControllers objectAtIndex:(i - formerPageCount)];
        if ([vc isKindOfClass:[UIViewController class]]) {
            // 填充contentScrollView
            vc.view.frame = CGRectMake(i * kSelfViewWidth, 0, kSelfViewWidth, _contentScrollView.frame.size.height);
            [_contentScrollView addSubview:vc.view];
        }
    }
    
}

// 设置MenuButton
- (void)setupMenuButtonsWithFormerPageCount:(int)formerPageCount {
    for (int i = formerPageCount; i < _pageCount; ++ i) {
        UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(i * (kSelfViewWidth / _menuNumberPerPage), 0, kSelfViewWidth / _menuNumberPerPage, _menuHeight - kIndicatorLineHeight)];
        [self configButton:menuButton withTag:(i + 1000) text:[NSString stringWithFormat:@"第%d页",i + 1]];
        
        // 第一次设置MenuButton的时候第一个MenuButton特殊处理
        if (formerPageCount == 0) {
            if (i == 0) {
                [menuButton setTitleColor:_indicatorLineColor forState:UIControlStateNormal];
                _formerButton = menuButton; // 初始的formerButton为第一个menuButton
            }
        }
    }
}

// 设置菜单按钮名称
- (void)setupTitles:(NSArray *)titles withFormerPageCount:(int)formerPageCount {
    for (int i = formerPageCount; i < _pageCount ; ++ i) {
        UIButton *button = (UIButton *)[self.menuScrollView viewWithTag:i + 1000];
        [button setTitle:[titles objectAtIndex:(i - formerPageCount)] forState:UIControlStateNormal];
    }
}

// MenuButton属性设定
- (void)configButton:(UIButton *)menuButton withTag:(int)tag text:(NSString *)text {
    menuButton.tag = tag;
    [menuButton setTitle:text forState:UIControlStateNormal];
    [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    menuButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [menuButton addTarget:self action:@selector(clickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    [_menuScrollView addSubview:menuButton];
    
}


#pragma mark - Actions

// 点击MenuButton触发事件
- (void)clickMenuButton:(UIButton *)menuButton {
    [self moveIndicatorWithButton:menuButton];
    [self changePageWithSelectedButton:menuButton];
}

- (void)moveIndicatorWithButton:(UIButton *)menuButton {
    [UIView beginAnimations:nil context:nil]; // 开始动画
    
    if (_pageCount > _menuNumberPerPage) { // 只有当翻页的页面数比菜单栏名目可见菜单多的时候才需要在滑动过程中移动菜单栏
        
        // _pageCount - _menuNumberPerPage 表示总共的页面数与屏幕可见页面之差
        // 需要移动的最大距离也就是(_pageCount - _menuNumberPerPage)个MenuButton宽度
        // 从第二个MenuButton开始移动，被选中的MenuButton就移动到屏幕上第二个MenuButton的位置
        if (menuButton.tag >= 1001 && menuButton.tag <= (1001 + (_pageCount - _menuNumberPerPage)) ) {
            [_menuScrollView setContentOffset:CGPointMake((menuButton.tag - 1001) * (kSelfViewWidth / _menuNumberPerPage), 0) animated:YES];
        }
        // 而当菜单栏移动到底的时候，剩余每个MenuButton选中时的偏移距离都统一设置为(_pageCount - _menuNumberPerPage)个MenuButton宽度
        else if (menuButton.tag > (1001 + (_pageCount - _menuNumberPerPage))) {
            [_menuScrollView setContentOffset:CGPointMake((_pageCount - _menuNumberPerPage) * (kSelfViewWidth / _menuNumberPerPage), 0) animated:YES];
        }
        // 当页面滑到第一页的时候，菜单栏复位
        else if (menuButton.tag < 1001) {
            [_menuScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
    }
    
    if([menuButton isKindOfClass:[UIButton class]]) {
        [_formerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [menuButton setTitleColor:_indicatorLineColor forState:UIControlStateNormal];
        [_indicatorLine setFrame:CGRectMake(menuButton.frame.origin.x, _menuHeight - kIndicatorLineHeight, kSelfViewWidth / _menuNumberPerPage, kIndicatorLineHeight)];
    }
    
    [UIView commitAnimations]; // 结束动画
    
    _formerButton = menuButton; // 设置formerButton为当前button
}

- (void)changePageWithSelectedButton:(UIButton *)menuButton {
    _currentPage = menuButton.tag - 1000;
    [_contentScrollView setContentOffset:CGPointMake(_currentPage * kSelfViewWidth, 0) animated:YES];
}


#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = _contentScrollView.frame.size.width;
    
    // floor表示下取整
    // eg: 当前为第2页，假设屏幕宽度320
    // 则_contentScrollView.contentOffset.x = 320, pageWidth = 320
    // 所以_currentPage = floor((320 - 320/2) / 320) + 1 = 1,即表示第2页。
    _currentPage = floor((_contentScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    UIButton *menuButton = (UIButton *)[_menuScrollView viewWithTag:_currentPage + 1000];
    [self moveIndicatorWithButton:menuButton];
}

@end
