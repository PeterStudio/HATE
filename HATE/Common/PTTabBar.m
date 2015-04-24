//
//  PTTabBar.m
//  Card58
//
//  Created by duwen on 15/4/8.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTTabBar.h"
@interface PTTabBar ()
/**
 *  设置之前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;
//@property (nonatomic, weak) NSMutableArray * item
@end

@implementation PTTabBar

- (void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    UIImage * bgI = [[UIImage imageNamed:@"footer_bg01_1"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    [btn setBackgroundImage:bgI forState:UIControlStateSelected];
    [self addSubview:btn];
    
    if (self.subviews.count == 1) {
        self.selectedBtn.selected = NO;
        btn.selected = YES;
        self.selectedBtn = btn;
    }
}

/**专门用来布局子视图, 别忘了调用super方法*/
- (void)layoutSubviews {
    [super layoutSubviews];
    
    int count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        //取得按钮
        UIButton *btn = self.subviews[i];
        
        btn.tag = i; //设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
        CGFloat x = i * self.bounds.size.width / count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = self.bounds.size.height;
        btn.frame = CGRectMake(x, y, width, height);
    }
}

- (void)tabSelectedWithTag:(NSUInteger)tag{
    self.selectedBtn.selected = NO;
    UIButton *btn = self.subviews[tag];
    btn.selected = YES;
    self.selectedBtn = btn;
}

@end
