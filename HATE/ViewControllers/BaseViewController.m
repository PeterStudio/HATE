//
//  BaseViewController.m
//  MirLiDoctor
//
//  Created by duwen on 15/1/16.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:UIColorFromRGB(0xebebeb)];
    
    //设置导航栏字体颜色
    UILabel * myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1, 44)];
    myTitleLabel.textAlignment = NSTextAlignmentCenter;
    [myTitleLabel setBackgroundColor:[UIColor clearColor]];
    myTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    myTitleLabel.textColor = [UIColor blackColor];
    myTitleLabel.text = self.title;
    self.navigationItem.titleView = myTitleLabel;

    
    // IOS6将导航栏背景设置成白色
    if (CURRENT_VERSION < 7.0) {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    
    
    self.navigationController.navigationBar.tintColor = RGB(3, 163, 263);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    backItem.title = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
