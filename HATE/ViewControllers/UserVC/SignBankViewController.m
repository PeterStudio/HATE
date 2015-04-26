//
//  SignBankViewController.m
//  HATE
//
//  Created by duwen on 15/4/23.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "SignBankViewController.h"
#import "UserSystemService.h"

@interface SignBankViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UIWebViewDelegate>{
    int typeIndex;
}
@property (nonatomic, strong) NSArray * typeArray;
@property (nonatomic, strong) UIPickerView * selectPicker;
@property (nonatomic, strong) UserSystemService * service;
@end

@implementation SignBankViewController

- (void)resign{
    [self.view endEditing:YES];
    self.selectPicker.frame = CGRectMake(0, UIScreenHeight, UIScreenWidth, 216);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _typeArray = [[NSArray alloc] initWithObjects:@"身份证",@"军人证",@"警官证",@"通行证",@"护照",@"其他",@"边境证", nil];
    typeIndex = 0;
    _certLab.text = @"";
    
    self.selectPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, UIScreenHeight, UIScreenWidth, 216)];
    //    _departmentTF.text = self.compentArr2[0];
    self.selectPicker.delegate = self;
    self.selectPicker.dataSource = self;
    [self.selectPicker setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.selectPicker];
    
    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resign)];
    [self.mainScrollView.superview addGestureRecognizer:pan];
    
    _service = [[UserSystemService alloc] init];
}


- (IBAction)typeSegment:(id)sender {
    UISegmentedControl * seg = (UISegmentedControl *)sender;
    NSLog(@"index=%d",seg.selectedSegmentIndex);
    if (seg.selectedSegmentIndex == 0) {
        _view1.hidden = YES;
        _view2.hidden = YES;
        typeIndex = 0;
    }else{
        _view1.hidden = NO;
        _view2.hidden = NO;
        typeIndex = 1;
    }
}

- (IBAction)certTypeBtnClick:(id)sender {
    [self.view endEditing:YES];
    self.selectPicker.frame = CGRectMake(0, UIScreenHeight - 216, UIScreenWidth, 216);
}

- (IBAction)signBtnClick:(id)sender {
    [self.view endEditing:YES];
    
    
    NSString * checkStr = [_nameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (checkStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入户名"];
        return;
    }
    
    NSString * str1 = [_certNumTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (typeIndex == 1) {
        if (_certLab.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请选择证件类型"];
            return;
        }
        if (str1.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入证件号码"];
            return;
        }
    }
    
    NSString * certNum = nil;
//    @"身份证",@"军人证",@"警官证",@"通行证",@"护照",@"其他",@"边境证"
    
    if ([@"身份证" isEqualToString:_certLab.text]) {
        certNum = @"15";
    }else if ([@"军人证" isEqualToString:_certLab.text]){
        certNum = @"17";
    }else if ([@"警官证" isEqualToString:_certLab.text]){
        certNum = @"18";
    }else if ([@"通行证" isEqualToString:_certLab.text]){
        certNum = @"19";
    }else if ([@"护照" isEqualToString:_certLab.text]){
        certNum = @"20";
    }else if ([@"其他" isEqualToString:_certLab.text]){
        certNum = @"21";
    }else if ([@"边境证" isEqualToString:_certLab.text]){
        certNum = @"24";
    }else{
        typeIndex = 0;
    }
    
    // test
//    self.uId = @"6";
//    checkStr = @"姚礼飞";
//    typeIndex = 0;
//    certNum = @"15";
//    str1 = @"320123198807160613";
    //
    
    
    [SVProgressHUD showWithStatus:@"签约中" maskType:SVProgressHUDMaskTypeClear];
    [_service request_Sign_Http_userId:self.uId bankType:@"comm" accName:checkStr onekeyTranType:[NSString stringWithFormat:@"%d",typeIndex] certType:certNum certNo:str1 success:^(id responseObject) {
//        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
//        NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//        NSString*pageSource = [[NSString alloc] initWithData:responseObject encoding:gbkEncoding];
        
        
        UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, UIScreenWidth, UIScreenHeight - 64)];
        [webView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:webView];
        [self.view bringSubviewToFront:webView];
        webView.delegate = self;
        [webView loadData:responseObject MIMEType:nil textEncodingName:nil baseURL:nil];

//        [self performSelector:@selector(popRoot) withObject:nil afterDelay:3.5];
        
//        BaseModel * demoModel = (BaseModel *)responseObject;
//        if ([RETURN_CODE_SUCCESS isEqualToString:demoModel.retcode]) {
//            [SVProgressHUD showSuccessWithStatus:demoModel.retinfo];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }else{
//            [SVProgressHUD showErrorWithStatus:demoModel.retinfo];
//        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];

}

- (void)popRoot{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{

}
// 网页加载完成的时候调用

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
//    [self performSelector:@selector(popRoot) withObject:nil afterDelay:2.5];
}
// 网页加载出错的时候调用

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
    NSLog(@"error=%@",error);
//    [self performSelector:@selector(popRoot) withObject:nil afterDelay:2.5];
}


#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _typeArray.count;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.typeArray objectAtIndex:row];
}

//监听轮子的移动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *seletedRow = [self.typeArray objectAtIndex:row];
    _certLab.text = seletedRow;
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
