//
//  ForgetPSWViewController.m
//  Card58
//
//  Created by duwen on 15/4/10.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "ForgetPSWViewController.h"
#import "UserSystemService.h"

@interface ForgetPSWViewController ()
@property (nonatomic, strong) UserSystemService * service;
@end

@implementation ForgetPSWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_submitButton setCustomBackGroundOnSomeState];
    _service = [[UserSystemService alloc] init];
}

- (IBAction)submitNewPswBtnClick:(id)sender {
    [self.view endEditing:YES];
    
    NSString * checkStr = [_checkCodeTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (checkStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    if (checkStr.length > 10) {
        [SVProgressHUD showErrorWithStatus:@"请输入10位以内的验证码"];
        return;
    }
    
    if(![_nPswTF.text isMatchedByRegex:PSW_REGULAR_EXPRESSION])
    {
        // 密码不对
        [SVProgressHUD showErrorWithStatus:@"密码是6-20位数字字母下划线"];
        return;
    }
    
    if (![_nPswTF.text isEqualToString:_checkPswTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"确认密码与密码不一致！"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"修改密码中" maskType:SVProgressHUDMaskTypeClear];
    [_service request_ForgetPsw_Http_phone:_phoneNum msg:_checkCodeTF.text psw:_nPswTF.text success:^(id responseObject) {
        BaseModel * demoModel = (BaseModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:demoModel.retcode]) {
            [SVProgressHUD showSuccessWithStatus:demoModel.retinfo];
            [[UserInfoDataManager sharedManager] saveUserName:_phoneNum password:_nPswTF.text];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_FORGOTRESET object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:demoModel.retinfo];
        }
    } failure:^(NSError *error) {
       [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE]; 
    }];
    
    
}

- (IBAction)touchSelfSuperView:(id)sender {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_checkCodeTF == textField) {
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
