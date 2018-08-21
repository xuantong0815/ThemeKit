//
//  XTSearchBar.m
//  XTThemeKit
//
//  Created by Tong on 2018/8/20.
//  Copyright © 2018年 Tong. All rights reserved.
//

#import "XTSearchBar.h"

#import "XTThemeManager.h"
#import "UIView+XTTheme.h"

@implementation XTSearchBar

- (void)dealloc
{
    if ([self respondsToSelector:@selector(setThemeConfigureBlock:)]) {
        [self setThemeConfigureBlock:nil];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:XTThemeDidChangeNotification object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
