//
//  BingBankViewController.m
//  HATE
//
//  Created by duwen on 15/4/21.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BingBankViewController.h"
#import "SignBankViewController.h"
@interface BingBankViewController ()

@end

@implementation BingBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)jiaoTongBankBtnClick:(id)sender {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"UserSystemSB" bundle:nil];
    SignBankViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"SignBankSBID"];
    vc.title = @"签约";
    vc.uId = self.userid;
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
