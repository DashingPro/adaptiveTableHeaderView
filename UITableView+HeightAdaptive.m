//
//  UITableView+HeightAdaptive.m
//  UNODriver
//
//  Created by Dashing on 2017/7/31.
//  Copyright © 2017年 xiaojukeji. All rights reserved.
//

#import "UITableView+HeightAdaptive.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

@interface HATableHeaderContainerView : UIView

- (instancetype)initWithHostTableView:(UITableView *)hostTableView;

@end

@implementation HATableHeaderContainerView {
    __weak UITableView *_hostTableView;
    CGRect _prevBounds;
}

- (instancetype)initWithHostTableView:(UITableView *)hostTableView {
    if (self = [super init]) {
        _hostTableView = hostTableView;
        self.autoresizesSubviews = NO;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.clipsToBounds = YES;
        _prevBounds = self.bounds;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_hostTableView) {
        if (!CGRectEqualToRect(_prevBounds, self.bounds)
            || !CGRectEqualToRect(_hostTableView.tableHeaderView.bounds, self.bounds) ) {
            _prevBounds = self.bounds;
            dispatch_async(dispatch_get_main_queue(), ^{
                _hostTableView.tableHeaderView.frame = self.bounds;
                _hostTableView.tableHeaderView = _hostTableView.tableHeaderView;
            });
        }
    }
}

@end

@implementation UITableView (HeightAdaptive)

- (UIView *)ha_tableHeaderContainerView {
    HATableHeaderContainerView *headerContainerView = objc_getAssociatedObject(self, _cmd);
    if (headerContainerView) {
        return headerContainerView;
    }
    UIView *tableHeaderView = [[UIView alloc] init];
    self.tableHeaderView = tableHeaderView;

    headerContainerView = [[HATableHeaderContainerView alloc] initWithHostTableView:self];
    [tableHeaderView addSubview:headerContainerView];
    [headerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(tableHeaderView);
        make.width.equalTo(self);
    }];
    
    objc_setAssociatedObject(self, _cmd, headerContainerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return headerContainerView;
}

@end
