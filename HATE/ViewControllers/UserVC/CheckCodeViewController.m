//
//  CheckCodeViewController.m
//  Card58
//
//  Created by duwen on 15/4/10.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "CheckCodeViewController.h"
#import "ForgetPSWViewController.h"
#import "UserSystemService.h"

@interface CheckCodeViewController ()
@property (nonatomic, strong) UserSystemService * service;
@end

@implementation CheckCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_checkButton setCustomBackGroundOnSomeState];
    _service = [[UserSystemService alloc] init];
}


- (IBAction)touchSelfSuperView:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)checkCodeBtnClick:(id)sender {
    [self.view endEditing:YES];
    
    if (![_phoneTF.text isMatchedByRegex:MOBILE_REGULAR_EXPRESSION]) {
        // 未输入账号
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"验证码发送中" maskType:SVProgressHUDMaskTypeClear];
    [_service request_GetCode_Http_phone:_phoneTF.text type:@"1" success:^(id responseObject) {
        BaseModel * demoModel = (BaseModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:demoModel.retcode]) {
            [SVProgressHUD showSuccessWithStatus:demoModel.retinfo];
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"UserSystemSB" bundle:nil];
            ForgetPSWViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"ForgetPSWSBID"];
            vc.title = @"找回密码";
            vc.phoneNum = _phoneTF.text;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:demoModel.retinfo];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
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
