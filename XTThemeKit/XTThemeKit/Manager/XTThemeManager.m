//
//  XTThemeManager.m
//  XTThemeKit
//
//  Created by Tong on 2018/8/20.
//  Copyright © 2018年 Tong. All rights reserved.
//

#import "XTThemeManager.h"

NSString * const XTThemeDidChangeNotification =  @"XTThemeDidChangeNotification";

NSString * const kXTThemeManagerThemeDay = @"daytime";
NSString * const kXTThemeManagerThemeNight = @"nighttime";

@interface XTThemeManager ()

@property (nonatomic,strong) NSString *currentThemeFolderName;  // 当前主题文件夹名称

@property (nonatomic,strong) NSString *currentThemeBasePath;    // 当前主题包基本路径

@property (nonatomic,strong) NSDictionary *themeKeysInfo;       // 当前主题包相关Key

@property (nonatomic,strong) NSString *themeRootFolder; // 主题包根文件夹

@property (nonatomic,strong) NSArray *themeFolderNames; // 主题包根文件夹

@end

@implementation XTThemeManager


#pragma mark - - - - - - - - - - - - - - - - - Init And Dealloc - - - - - - - - - - - - - - - - -

- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _openTestLog = NO;
    }
    return self;
}

+ (XTThemeManager *)sharedManager
{
    static XTThemeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XTThemeManager alloc] init];
    });
    return manager;
}


#pragma mark - - - - - - - - - - - - - - - - - Public Events - - - - - - - - - - - - - - - - -

/**
 配置主题包必要信息
 
 @param rootFolderName          主题文件根目录
 @param themeFolderNames        主题文件名集合
 @param currentThemeFolderName  当前主题文件名
 */
- (void)configureThemePackageRootFolderName:(NSString *)rootFolderName themeFolderNames:(NSArray *)themeFolderNames currentThemeFolderName:(NSString *)currentThemeFolderName
{
    self.themeRootFolder = rootFolderName;
    self.themeFolderNames = themeFolderNames;
    self.currentThemeFolderName = currentThemeFolderName;
    
    [self reloadThemeInfo];
}

/**
 改变当前主题文件夹名称
 */
- (void)changeCurrentThemeToFolderName:(NSString *)themeFolderName
{
    if (self.currentThemeFolderName &&
        [self.currentThemeFolderName isEqualToString:themeFolderName]) {
        return;
    }
    
    NSString *changeValue = nil;
    for (NSString *themeFolder in self.themeFolderNames) {
        
        if ([themeFolder isEqualToString:themeFolderName]) {
            changeValue = themeFolder;
        }
    }
    
    if (changeValue) {
        
        self.currentThemeFolderName= changeValue;
        
        [self reloadThemeInfo];
        
        // 发送改变主题通知
        [[NSNotificationCenter defaultCenter]postNotificationName:XTThemeDidChangeNotification object:nil];
        
    } else {
        NSLog(@"warning：no theme %@",themeFolderName);
    }
}

/**
 获取当前主题文件夹名称
 */
- (NSString *)getCurrentThemeFolderName
{
    return self.currentThemeFolderName;
}

/**
 获取主题颜色
 */
+ (UIColor *)getThemeColorWithKey:(NSString *)colorKey
{
    return [[XTThemeManager sharedManager] getThemeColorWithKey:colorKey];
}


/**
 获取主题图片 - 图片在 Resource里面
 */
+ (UIImage *)getThemeImageWithKey:(NSString *)imageKey
{
    return [[XTThemeManager sharedManager] getThemeImageWithKey:imageKey];
}

/**
 获取主题图片 - 图片在 Assets 里面
 */
+ (UIImage *)getThemeAssetsImageWithKey:(NSString *)imageKey
{
    return [[XTThemeManager sharedManager] getThemeAssetsImageWithKey:imageKey];
}

/**
 检测是否是夜间模式
 */
+ (BOOL)checkIsNightTime
{
    return [[XTThemeManager sharedManager].currentThemeFolderName isEqualToString:kXTThemeManagerThemeNight];
}

/**
 设置夜间模式不透明度
 */
+ (CGFloat)getNightAlpha
{
    return 0.7;
}

/**
 修改主题
 */
+ (void)changeAPPTheme
{
    if ([XTThemeManager checkIsNightTime]) {
        [[XTThemeManager sharedManager] changeCurrentThemeToFolderName:kXTThemeManagerThemeDay];
    } else {
        [[XTThemeManager sharedManager] changeCurrentThemeToFolderName:kXTThemeManagerThemeNight];
    }
}


#pragma mark - - - - - - - - - - - - - - - - - Private Events - - - - - - - - - - - - - - - - -

/**
 重刷主题信息
 */
- (void)reloadThemeInfo
{
    // 基本路径
    self.currentThemeBasePath = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.themeRootFolder] stringByAppendingPathComponent:self.currentThemeFolderName];
    
    NSString *themePlistPath = [self.currentThemeBasePath stringByAppendingPathComponent:@"theme.plist"];
    
    // 重新读取主题数据
    self.themeKeysInfo = [NSDictionary dictionaryWithContentsOfFile:themePlistPath];
    
    
    if (self.openTestLog) {
        NSLog(@"----- 主题基本路径 -----\n%@\n-----",self.currentThemeBasePath);
        NSLog(@"----- 主题基Plist路径 -----\n%@\n-----",themePlistPath);
    }
}


/**
 获取主题颜色
 */
- (UIColor *)getThemeColorWithKey:(NSString *)colorKey
{
    if (!colorKey || colorKey.length == 0) {
        return nil;
    }
    
    UIColor *tmpColor = nil;
    
    NSDictionary *colors  = self.themeKeysInfo[@"colors"];
    
    if (colors) {
        
        // 根据plis文件里面的数据获取颜色
        NSString *colorValue = colors[colorKey];
        NSArray *arr = [colorValue componentsSeparatedByString:@"_"];
        
        if (arr) {
            
            if ([arr count]==3) {
                
                // 默认透明度 1.0
                tmpColor = [UIColor colorWithRed:[arr[0] floatValue]/255.0 green:[arr[1] floatValue]/255.0 blue:[arr[2] floatValue]/255.0 alpha:1.0];
                
            } else if([arr count] == 4) {
                
                // 设置透明度
                tmpColor = [UIColor colorWithRed:[arr[0] floatValue]/255.0 green:[arr[1] floatValue]/255.0 blue:[arr[2] floatValue]/255.0 alpha:[arr[3] floatValue]];
            }
        }
    }
    
    return tmpColor;
}


/**
 获取图片
 */
- (UIImage *)getThemeImageWithKey:(NSString *)imageKey
{
    if (!imageKey || imageKey.length == 0) {
        return nil;
    }
    
    UIImage *tmpeImage = nil;
    
    NSDictionary *images  = self.themeKeysInfo[@"images"];
    
    if (images) {
        
        NSDictionary *imageInfo = images[imageKey];
        
        NSString *folderName = imageInfo[@"folderName"];
        NSString *imageName = imageInfo[@"imageName"];
        
        CGFloat scale = [[UIScreen mainScreen] scale];
        
        if (scale >= 3) {
            imageName = [imageName stringByAppendingString:@"@3x"];
        } else if(scale >= 2){
            imageName = [imageName stringByAppendingString:@"@2x"];
        }
        
        
        NSString *imagePath = [[[self.currentThemeBasePath stringByAppendingPathComponent:folderName] stringByAppendingPathComponent:imageName]stringByAppendingPathExtension:@"png"];

        tmpeImage = [UIImage imageWithContentsOfFile:imagePath];
    }
    
    return tmpeImage;
}


/**
 获取图片 - 图片在 Assets
 */
- (UIImage *)getThemeAssetsImageWithKey:(NSString *)imageKey
{
    if (!imageKey || imageKey.length == 0) {
        return nil;
    }
    
    UIImage *tmpeImage = nil;
    
    NSDictionary *images  = self.themeKeysInfo[@"asserts"];
    
    if (images) {
        
        NSString *imageValue = images[imageKey];
        tmpeImage = [UIImage imageNamed:imageValue];
    }
    
    return tmpeImage;
}

@end
