//
//  XTTableViewCell.m
//  XTThemeKit
//
//  Created by Tong on 2018/8/20.
//  Copyright © 2018年 Tong. All rights reserved.
//

#import "XTTableViewCell.h"

#import "XTThemeManager.h"
#import "UIView+XTTheme.h"

@implementation XTTableViewCell

- (void)dealloc
{
    if ([self respondsToSelector:@selector(setThemeConfigureBlock:)]) {
        [self setThemeConfigureBlock:nil];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:XTThemeDidChangeNotification object:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
