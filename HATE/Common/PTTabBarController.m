//
//  PTTabBarController.m
//  Card58
//
//  Created by duwen on 15/4/8.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "PTTabBarController.h"
#import "PTTabBar.h"

@interface PTTabBarController ()
@property (nonatomic, strong) PTTabBar *myView;
@end

@implementation PTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //删除现有的tabBar
    CGRect rect = self.tabBar.bounds; //这里要用bounds来加, 否则会加到下面去.看不见
    //[self.tabBar removeFromSuperview];  //移除TabBarController自带的下部的条
    _myView = [[PTTabBar alloc] init]; //设置代理必须改掉前面的类型,不能用UIView
    UIImage * bgI = [[UIImage imageNamed:@"footer_bg01"] stretchableImageWithLeftCapWidth:1 topCapHeight:1];
    
    _myView.frame = rect;
    [self.tabBar addSubview:_myView]; //添加到系统自带的tabBar上, 这样可以用的的事件方法. 而不必自己去写
    self.tabBar.backgroundImage = bgI;
    
    //为控制器添加按钮
    for (int i=0; i< 4; i++) { //根据有多少个子视图控制器来进行添加按钮
        NSString *imageName = [NSString stringWithFormat:@"TabBar%d", i + 1];
        NSString *imageNameSel = [NSString stringWithFormat:@"TabBarSel%d", i + 1];
        
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        [_myView addButtonWithImage:image selectedImage:imageSel];
    }
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSUInteger indexP = [tabBar.items indexOfObject:item];
    [_myView tabSelectedWithTag:indexP];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
