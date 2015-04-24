//
//  ResetPSWViewController.m
//  Card58
//
//  Created by duwen on 15/4/10.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "ResetPSWViewController.h"

@interface ResetPSWViewController ()

@end

@implementation ResetPSWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_submitButton setCustomBackGroundOnSomeState];
}


- (IBAction)submitResetPswBtnClick:(id)sender {
    [self.view endEditing:YES];
    
}

- (IBAction)touchSelfSuperView:(id)sender {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_oldPswTF == textField) {
        [_nPswTF becomeFirstResponder];
        return NO;
    }else if (_nPswTF == textField){
        [_checkPswTF becomeFirstResponder];
        return NO;
    }else{
        [_checkPswTF resignFirstResponder];
        return YES;
    }
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
