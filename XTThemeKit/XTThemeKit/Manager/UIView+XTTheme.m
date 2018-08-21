//
//  UIView+XTTheme.m
//  XTThemeKit
//
//  Created by Tong on 2018/8/20.
//  Copyright © 2018年 Tong. All rights reserved.
//

#import "UIView+XTTheme.h"

#import <objc/runtime.h>

#import "XTThemeManager.h"

static const void *UtilityKey = &UtilityKey;

@implementation UIView (XTTheme)

- (XTThemeBlock)themeConfigureBlock
{
    return objc_getAssociatedObject(self, UtilityKey);
}

- (void)setThemeConfigureBlock:(XTThemeBlock)themeConfigureBlock
{
    objc_setAssociatedObject(self, UtilityKey, themeConfigureBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:XTThemeDidChangeNotification object:nil];
    
    if (themeConfigureBlock) {
        
        if ([self respondsToSelector:@selector(didThemeChangeNotification)]) {
            
            [self didThemeChangeNotification];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didThemeChangeNotification) name:XTThemeDidChangeNotification object:nil];
        }
    }
}


- (void)didThemeChangeNotification
{
    if (self.themeConfigureBlock) {
        
        __block id sender = self;
        self.themeConfigureBlock(sender);
    }
}

@end
