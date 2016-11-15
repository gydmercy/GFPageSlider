//
//  FirstViewController.m
//  GFPageSliderDemo
//
//  Created by Mercy on 15/6/30.
//  Copyright (c) 2015年 Mercy. All rights reserved.
//

#import "FirstViewController.h"
#import "ViewController.h"
#import "PushedViewController.h"

@interface FirstViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

#define kSelfViewWidth self.view.frame.size.width
#define kSelfViewHeight self.view.frame.size.height


@implementation FirstViewController

static NSString *cellIdentifier = @"cellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSelfViewWidth, kSelfViewHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    // 自动调整自身高度和宽度，保证与superView上下左右的距离不变
    // 之所以加上这个属性是因为，第一次该ViewController初始化的时候，self.view.frame就是屏幕大小
    // 但当该ViewController传入PageSlider之后其frame为发生改变以填充contentScrollView
    // 当该ViewController子类的frame是以该ViewController为参照时，该子类的frame也要跟着改变才符合要求
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
   
    [self.view addSubview:self.tableView];
}



#pragma - mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    return cell;
}

#pragma - mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    PushedViewController *pdvc = [[PushedViewController alloc] init];
    [self.navigationController pushViewController:pdvc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
