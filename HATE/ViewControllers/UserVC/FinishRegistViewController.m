//
//  FinishRegistViewController.m
//  HATE
//
//  Created by duwen on 15/4/21.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "FinishRegistViewController.h"
#import "BingBankViewController.h"

@interface FinishRegistViewController ()

@end

@implementation FinishRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)finishRegistBtnClick:(id)sender {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"UserSystemSB" bundle:nil];
    BingBankViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"BingBankSBID"];
    vc.title = @"绑定银行";
    vc.userid = self.uId;
    [self.navigationController pushViewController:vc animated:YES];
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
