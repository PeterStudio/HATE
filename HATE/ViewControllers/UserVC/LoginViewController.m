//
//  LoginViewController.m
//  Card58
//
//  Created by duwen on 15/4/10.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "CheckCodeViewController.h"
#import "UserSystemService.h"
#import "UIDevice+IdentifierAddition.h"

#import "BingBankViewController.h"
#import "SignBankViewController.h"
#import "FinishLoginViewController.h"
@interface LoginViewController ()
@property (nonatomic, strong) UserSystemService * service;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)config{
    self.accountTF.text = [[UserInfoDataManager sharedManager] username];
    self.passwordTF.text = [[UserInfoDataManager sharedManager] password];
    if (self.passwordTF.text.length != 0) {
        [self loginIsAuto:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_loginButton setCustomBackGroundOnSomeState];
    
    _service = [[UserSystemService alloc] init];
    [self config];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(config) name:KNOTIFICATION_FORGOTRESET object:nil];
}


- (IBAction)registBtnClick:(id)sender {
    [self.view endEditing:YES];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"UserSystemSB" bundle:nil];
    RegistViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"RegistSBID"];
    vc.title = @"注册";
    __weak typeof(LoginViewController*) bself = self;
    vc.callBlock = ^(){
        bself.accountTF.text = [[UserInfoDataManager sharedManager] username];
        bself.passwordTF.text = [[UserInfoDataManager sharedManager] password];
        [bself loginIsAuto:YES];
    };
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)forgetPSWVC:(id)sender {
    [self.view endEditing:YES];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"UserSystemSB" bundle:nil];
    CheckCodeViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"CheckCodeSBID"];
    vc.title = @"找回密码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginBtnClick:(id)sender {
    [self.view endEditing:YES];
    [self loginIsAuto:NO];
    
//    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"UserSystemSB" bundle:nil];
//    SignBankViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"SignBankSBID"];
//    vc.title = @"找回密码";
//    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)remenberMeBtnClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if (btn.isSelected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
}


- (void)loginIsAuto:(BOOL)isAuto{
    if (!isAuto) {
        if (![_accountTF.text isMatchedByRegex:MOBILE_REGULAR_EXPRESSION]) {
            // 未输入账号
            [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
            return;
        }
        
        if(![_passwordTF.text isMatchedByRegex:PSW_REGULAR_EXPRESSION])
        {
            // 密码不对
            [SVProgressHUD showErrorWithStatus:@"密码是6-20位数字字母下划线"];
            return;
        }
    }
    
    //版本号
    NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!curVersion) {
        curVersion=@"1.0";
    }
    //设备号
    NSString *imeiStr = [[UIDevice currentDevice] myGlobalDeviceId];
    
    [SVProgressHUD showWithStatus:@"登录中" maskType:SVProgressHUDMaskTypeClear];
    [_service request_Login_Http_phone:_accountTF.text psw:_passwordTF.text system:@"1" version:curVersion imei:imeiStr success:^(id responseObject) {
        UserModel * userModel = (UserModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:userModel.retcode]) {
            if (!isAuto) {
                [SVProgressHUD showErrorWithStatus:userModel.retinfo];
            }else{
                [SVProgressHUD dismiss];
            }
            UserInfoModel * userInfoModel = (UserInfoModel *)userModel.doc;
            [[UserInfoDataManager sharedManager] saveUserDataWithUserInfoModel:userInfoModel];
            [[UserInfoDataManager sharedManager] saveUserName:_accountTF.text password:_passwordTF.text];
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
            
            
            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"UserSystemSB" bundle:nil];
            FinishLoginViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"FinishLoginSBID"];
            vc.title = @"登录成功";
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else{
            if (!isAuto) {
                [SVProgressHUD showErrorWithStatus:userModel.retinfo];
            }else{
                [SVProgressHUD showErrorWithStatus:@"自动登录失败"];
            }
        }
    } failure:^(NSError *error) {
        if (!isAuto) {
            [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
        }else{
            [SVProgressHUD showErrorWithStatus:@"自动登录失败"];
        }
    }];
    
}

- (IBAction)touchSelfSuperView:(id)sender {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_passwordTF == textField) {
        [textField resignFirstResponder];
        return YES;
    }else{
        [_passwordTF becomeFirstResponder];
        return NO;
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
