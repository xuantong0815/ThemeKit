//
//  UIView+XTTheme.h
//  XTThemeKit
//
//  Created by Tong on 2018/8/20.
//  Copyright © 2018年 Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 主题属性配置Block
 
 @param sender 必须通过sender设置主题属性，不可用self，避免循环引用问题
 */
typedef void(^XTThemeBlock)(id sender);

@interface UIView (XTTheme)


/**
 主题属性配置Block
 */
@property (nonatomic, copy) XTThemeBlock themeConfigureBlock;


/**
 主题切换通知
 */
- (void)didThemeChangeNotification;

@end
