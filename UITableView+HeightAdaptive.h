//
//  UITableView+HeightAdaptive.h
//  UNODriver
//
//  Created by Dashing on 2017/7/31.
//  Copyright © 2017年 xiaojukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (HeightAdaptive)

/**
 @situation 要对tableView添加一个高度可以根据内容自动展开的tableHeaderView
 @problem 要对tableView的tableHeaderView上使用约束，会有奇怪的问题出现
 @solution 获取此view来addSubview 各种子view 然后设置好高度top及bottom约束，tableHeaderView的高度会根据子view的内容自适应
        此view的宽度约束跟tableView的相同
 @return view
 */
- (UIView *)ha_tableHeaderContainerView;

@end
