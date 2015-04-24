//
//  RegistViewController.h
//  Card58
//
//  Created by duwen on 15/4/10.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseViewController.h"

@interface RegistViewController : BaseViewController
@property (nonatomic, copy) dispatch_block_t callBlock;

@property (strong, nonatomic) IBOutlet UIButton *registButton;
@property (strong, nonatomic) IBOutlet UIButton *checkCodeBtn;

@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *checkCodeTF;
@property (strong, nonatomic) IBOutlet UITextField *pswTF;
@property (strong, nonatomic) IBOutlet UITextField *checkPswTF;
@property (strong, nonatomic) IBOutlet UIButton *checkBtn;

@end
