//
//  ForgetPSWViewController.h
//  Card58
//
//  Created by duwen on 15/4/10.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseViewController.h"

@interface ForgetPSWViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@property (strong, nonatomic) NSString * phoneNum;
@property (strong, nonatomic) IBOutlet UITextField *checkCodeTF;
@property (strong, nonatomic) IBOutlet UITextField *nPswTF;
@property (strong, nonatomic) IBOutlet UITextField *checkPswTF;
@end
