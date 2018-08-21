//
//  XTThemeManager.h
//  XTThemeKit
//
//  Created by Tong on 2018/8/20.
//  Copyright © 2018年 Tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString * const XTThemeDidChangeNotification;   // 主题切换通知
extern NSString * const kXTThemeManagerThemeDay;        // 白天主题名
extern NSString * const kXTThemeManagerThemeNight;      // 夜间主题名

@interface XTThemeManager : NSObject

+ (XTThemeManager *)sharedManager;

/** 打印调试信息，YES打印，默认为NO */
@property (nonatomic, assign) BOOL openTestLog;


/**
 配置主题包必要信息
 
 @param rootFolderName          主题文件根目录
 @param themeFolderNames        主题文件名集合
 @param currentThemeFolderName  当前主题文件名
 */
- (void)configureThemePackageRootFolderName:(NSString *)rootFolderName themeFolderNames:(NSArray *)themeFolderNames currentThemeFolderName:(NSString *)currentThemeFolderName;

/**
 改变当前主题文件夹名称
 */
- (void)changeCurrentThemeToFolderName:(NSString *)themeFolderName;

/**
 获取当前主题文件夹名称
 */
- (NSString *)getCurrentThemeFolderName;

/**
 获取主题颜色
 */
+ (UIColor *)getThemeColorWithKey:(NSString *)colorKey;

/**
 获取主题图片 - 图片在 Resource里面
 */
+ (UIImage *)getThemeImageWithKey:(NSString *)imageKey;

/**
 获取主题图片 - 图片在 Assets 里面
 */
+ (UIImage *)getThemeAssetsImageWithKey:(NSString *)imageKey;

/**
 检测是否是夜间模式
 */
+ (BOOL)checkIsNightTime;

/**
 设置夜间模式不透明度
 */
+ (CGFloat)getNightAlpha;

/**
 修改主题
 */
+ (void)changeAPPTheme;

@end
