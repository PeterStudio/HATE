//
//  UIButton+Custom.m
//  Card58
//
//  Created by duwen on 15/4/12.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "UIButton+PTCustom.h"

@implementation UIButton (Custom)

- (void)setCustomBackGroundOnSomeState{
    UIImage * nor = [[UIImage imageNamed:@"buttonNor"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    UIImage * sel = [[UIImage imageNamed:@"buttonSel"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [self setBackgroundImage:nor forState:UIControlStateNormal];
    [self setBackgroundImage:sel forState:UIControlStateHighlighted];
}

- (void)setCustomCheckCodeBackGroundOnSomeState{
    UIImage * nor = [[UIImage imageNamed:@"btn_reg"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    UIImage * sel = [[UIImage imageNamed:@"btn_reg"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [self setBackgroundImage:nor forState:UIControlStateNormal];
    [self setBackgroundImage:sel forState:UIControlStateHighlighted];
    [self setBackgroundImage:sel forState:UIControlStateSelected];
}

@end
