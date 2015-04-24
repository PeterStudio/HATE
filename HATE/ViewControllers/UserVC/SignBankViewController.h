//
//  SignBankViewController.h
//  HATE
//
//  Created by duwen on 15/4/23.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseViewController.h"
#import "AutoScrollView.h"
@interface SignBankViewController : BaseViewController
@property (nonatomic, strong) NSString * uId;
@property (strong, nonatomic) IBOutlet AutoScrollView *mainScrollView;

@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UILabel *certLab;
@property (strong, nonatomic) IBOutlet UITextField *certNumTF;


@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;


@end
