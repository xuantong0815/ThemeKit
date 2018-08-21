//
//  ViewController.m
//  NightThemeDemo
//
//  Created by Tong on 2018/8/20.
//  Copyright © 2018年 Tong. All rights reserved.
//

#import "ViewController.h"

#import <XTThemeKit/XTThemeKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 颜色的切换
    self.view.themeConfigureBlock = ^(XTView *sender) {
        sender.backgroundColor = [XTThemeManager getThemeColorWithKey:@"255_255_255"];
    };
    
    // 视图颜色切换
    XTButton *button = [XTButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 64);
    [button setTitle:@"修改主题" forState:UIControlStateNormal];
    
    button.themeConfigureBlock = ^(XTButton *sender) {
        sender.backgroundColor = [XTThemeManager getThemeColorWithKey:@"82_180_255"];
        [sender setTitleColor:[XTThemeManager getThemeColorWithKey:@"255_255_255"] forState:UIControlStateNormal];
    };
    
    [button addTarget:self action:@selector(themeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
     // 图片的切换
    
    // 图片在Assert里面
    XTImageView *assetImageView = [[XTImageView alloc] initWithFrame:CGRectMake(100, 180, 24, 24)];
    
    assetImageView.themeConfigureBlock = ^(XTImageView *sender) {
        sender.image = [XTThemeManager getThemeAssetsImageWithKey:@"test_assert_image"];
    };
    
    [self.view addSubview:assetImageView];
    
    // 图片在主题文件根里面
    XTImageView *noFolderImageView = [[XTImageView alloc] initWithFrame:CGRectMake(100, 210, 24, 24)];
    
    noFolderImageView.themeConfigureBlock = ^(XTImageView *sender) {
        sender.image = [XTThemeManager getThemeImageWithKey:@"test_noFolder_image"];
    };
    
    [self.view addSubview:noFolderImageView];
    
    // 图片在主题文件子文件里面
    XTImageView *folderImageView = [[XTImageView alloc] initWithFrame:CGRectMake(150, 210, 24, 24)];
    
    folderImageView.themeConfigureBlock = ^(XTImageView *sender) {
        sender.image = [XTThemeManager getThemeImageWithKey:@"test_folder_image"];
    };
    
    [self.view addSubview:folderImageView];
    
}


/**
 修改主题
 */
- (void)themeButtonAction
{
    [XTThemeManager changeAPPTheme];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end



