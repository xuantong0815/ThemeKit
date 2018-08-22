# ThemeKit
夜间模式（主题切换）
### 使用详解

`XTThemeManager`：主题管理类。也是整个主题切换的工具类。主要是配置主题信息，获取对应模式下的图片和颜色。

* 首先我们在`Appdelegate`的`application:didFinishLaunchingWithOptions:`方法中配置主题的必要信息
    
```
    // 启动时配置主题模式
    [[XTThemeManager sharedManager] configureThemePackageRootFolderName:@"Skins"
                                                       themeFolderNames:@[kXTThemeManagerThemeDay, kXTThemeManagerThemeNight]
                                                 currentThemeFolderName:kXTThemeManagerThemeDay];
```

主要是主题文件的`文件根目录`、`文件名集合`和`当前主题文件名`。这个根据你自己的项目去设置。想我一般愿意把文件放在`bundle`文件中。

如果你是第一次添加，不知道自己路径设的是否正确，可以打开调试`[XTThemeManager sharedManager].openTestLog = YES;`查看路径是否正确。

* 完成启动配置之后，就是使用了。想要切换主题，所有视图都需要继承库里面对应的父类。除了控制器的视图除外。具体的使用，可以参考下面的代码，或查看Demo里面的写法

```
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
    
```

颜色设置没有什么好说的，按照格式去设置就好了。由于个人习惯，不习惯用`Assert`去设置颜色，所以本框架不支持通过`Assert`去设置颜色。如果有需要，可以自己在源码扩展。就是重写一个获取颜色方法，主要就是修改获取颜色的路径。具体可以参考获取图片的。

图片的获取有三种，一种是放在`Assert`里面，还有就是放在主题文件下和主题文件的子文件下。通过两种方法去调用

具体的调用方法这里也就不多说了。这三种情况`plist`文件的配置都在Demo中。看Demo就知道了。

[详细说明](https://blog.csdn.net/XuanTong520/article/details/81903103)

**如果您在使用过程中遇到什么问题，可以随时提Issue**

**或者发送问题到邮箱 1653584411@qq.com**

**如果您觉得还不错，麻烦您动动鼠标给我个Star，谢谢**


