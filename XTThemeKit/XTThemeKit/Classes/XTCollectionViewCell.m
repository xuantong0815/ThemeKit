//
//  XTCollectionViewCell.m
//  XTThemeKit
//
//  Created by Tong on 2018/8/20.
//  Copyright © 2018年 Tong. All rights reserved.
//

#import "XTCollectionViewCell.h"

#import "XTThemeManager.h"
#import "UIView+XTTheme.h"

@implementation XTCollectionViewCell

- (void)dealloc
{
    if ([self respondsToSelector:@selector(setThemeConfigureBlock:)]) {
        [self setThemeConfigureBlock:nil];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:XTThemeDidChangeNotification object:nil];
}

@end
