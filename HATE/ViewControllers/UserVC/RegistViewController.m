//
//  RegistViewController.m
//  Card58
//
//  Created by duwen on 15/4/10.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "RegistViewController.h"
#import "UserSystemService.h"
#import "FinishRegistViewController.h"
@interface RegistViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField * tempTF;
@property (nonatomic, strong) UserSystemService * service;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_registButton setCustomBackGroundOnSomeState];
    [_checkBtn setCustomCheckCodeBackGroundOnSomeState];
    [_checkBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [_checkBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
    _service = [[UserSystemService alloc] init];
}

- (IBAction)checkBtnClick:(id)sender {
    [self.view endEditing:YES];
    if (![_phoneTF.text isMatchedByRegex:MOBILE_REGULAR_EXPRESSION]) {
        // 未输入账号
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"验证码发送中" maskType:SVProgressHUDMaskTypeClear];
    [_service request_GetCode_Http_phone:_phoneTF.text type:@"0" success:^(id responseObject) {
        BaseModel * demoModel = (BaseModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:demoModel.retcode]) {
            [SVProgressHUD showSuccessWithStatus:demoModel.retinfo];
        }else{
            [SVProgressHUD showErrorWithStatus:demoModel.retinfo];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
    
    [_checkBtn setSelected:YES];
    [_checkBtn setUserInteractionEnabled:NO];
    _checkBtn.titleLabel.font = [UIFont systemFontOfSize:8];
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_checkBtn setSelected:NO];
                [_checkBtn setUserInteractionEnabled:YES];
                [_checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _checkBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2ds后重新获取",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_checkBtn setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
        }  
    });  
    dispatch_resume(_timer);
}

- (IBAction)registBtnClick:(id)sender {
    [self.view endEditing:YES];
    if (![_phoneTF.text isMatchedByRegex:MOBILE_REGULAR_EXPRESSION]) {
        // 未输入账号
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        return;
    }
    
    NSString * checkStr = [_checkCodeTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (checkStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    if (checkStr.length > 10) {
        [SVProgressHUD showErrorWithStatus:@"请输入10位以内的验证码"];
        return;
    }
    
    if(![_pswTF.text isMatchedByRegex:PSW_REGULAR_EXPRESSION])
    {
        // 密码不对
        [SVProgressHUD showErrorWithStatus:@"密码是6-20位数字字母下划线"];
        return;
    }
    
    if (![_pswTF.text isEqualToString:_checkPswTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"确认密码与密码不一致！"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"注册中" maskType:SVProgressHUDMaskTypeClear];
    [_service request_Register_Http_phone:_phoneTF.text msg:checkStr psw:_pswTF.text success:^(id responseObject) {
        UserModel * demoModel = (UserModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:demoModel.retcode]) {
            [SVProgressHUD showSuccessWithStatus:demoModel.retinfo];
            [[UserInfoDataManager sharedManager] saveUserName:_phoneTF.text password:_pswTF.text];
            
//            if (self.callBlock) {
//                self.callBlock();
//            }
//            [self.navigationController popViewControllerAnimated:YES];
            UserInfoModel * userInfoModel = (UserInfoModel *)demoModel.doc;
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"UserSystemSB" bundle:nil];
            FinishRegistViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"FinishRegistSBID"];
            vc.title = @"完成注册";
            vc.uId = userInfoModel.userId;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            [SVProgressHUD showErrorWithStatus:demoModel.retinfo];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
}

- (IBAction)touchSelfSuperView:(id)sender {
    [self.tempTF resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.tempTF = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_phoneTF == textField) {
        [_checkCodeTF becomeFirstResponder];
        return NO;
    }else if (_checkCodeTF == textField){
        [_pswTF becomeFirstResponder];
        return NO;
    }else if (_pswTF == textField){
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
