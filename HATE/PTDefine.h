//
//  PTDefine.h
//  MirLiDoctor
//
//  Created by duwen on 15/1/16.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#ifndef MirLiDoctor_PTDefine_h
#define MirLiDoctor_PTDefine_h


#endif




//正则表达式
#define EMAIL_REGULAR_EXPRESSION @"^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$"
#define USER_REGULAR_EXPRESSION @"^[0-9A-Za-z_]{6,20}$"
#define PSW_REGULAR_EXPRESSION @"^[A-Za-z0-9_]{6,20}$"
#define PSW_REGULAR_FORLOGIN  @"^[^ ]{6,20}$"
#define MOBILE_REGULAR_EXPRESSION @"^[0-9]{11}$"
#define ZIP_REGULAR_EXPRESSION @"^[0-9]{0,6}$"
#define AUTHCODE_REGULAR_EXPRESSION @"^[0-9]{1,10}$"
#define POSTCODE_REGULAR_EXPRESSION @"^[0-9]{6}$"
//正整数
#define POSITIVE_NUMBER_REGULAR_EXPRESSION   @"^[0-9]*[1-9][0-9]*$"
//非负浮点数
#define POSITIVE_FLOAT_REGULAR_EXPRESSION   @"^\\d+(\\.\\d+)?$"

#define IDNUMBER_REGULAR_EXPRESSION  @"[0-9]{17}([0-9]|[xX])"


#define MD5KEY  @"YD6hRfv42pGPeZ2DVuMCDnZ56ko7Y3qvBY"
#define UmengAppkey @"549967a5fd98c5b998000b0a"

#define RETURN_CODE_SUCCESS                  @"000000"     //成功
#define OTHER_ERROR_MESSAGE   @"请求失败，请稍后再试"
#define NONE_DATA_MESSAGE   @"很抱歉，暂无数据"


#define USER_NAME_KEY    @"com.peterstudio.ygb.username"
#define USER_PASSWORD_KEY    @"com.peterstudio.ygb.password"
#define USER_NAME_PASSWORD_KEY  @"com.peterstudio.ygb.usernamepassword"
#define USERINFO    @"MIRLIUSERINFO"
#define USERLOGINID @"USERLOGINID"
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
#define KNOTIFICATION_LOCTIONCHANGE @"KNOTIFICATION_LOCTIONCHANGE"
#define KNOTIFICATION_FORGOTRESET @"KNOTIFICATION_FORGOTRESET"

#define DB_VERSION_NUM 2
#define VERSION_NUM_FOR_GUIDE 1  //备注：如果需要显示新的引导页，该变量＋1

#define NUMBER_FOR_REQUEST @"10" //一次请求条数
#define DEFAULTPLACEHOLDIMAGE   @"showIcon"
#define USERIMAGEVIEWFILES       @"USERIMAGEVIEWFILES"

// Share
#define SettingShareUrl  @"小李医生,欢迎点击下载http://115.29.223.193/doct/appDown.html，邀请您体验"
#define SETTING_CONTENT_SHARE_URL  @"小李医生手机应用，邀请您体验，欢迎点击下载。"
#define SHARE_TITLE  @"小李医生"
#define ShopEventShareUrl  @"http://115.29.223.193/doct/appDown.html"
#define ShareSuccess  @"分享成功"
#define ShareError  @"取消分享"


//当前设备屏幕高度
#define UIScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define UIScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
#define RETINA4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//系统版本
#define CURRENT_VERSION [[UIDevice currentDevice].systemVersion floatValue]
// 医生OR患者
#define ISPATIENT  [[NSUserDefaults standardUserDefaults] boolForKey:@"ISPATIENT"] 
//颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]


/**************************接口**************************/

#define SERVER_URL  @"http://121.40.57.21/"

// 注册
#define HTTP_register_URL [NSString stringWithFormat:@"%@register", SERVER_URL]
// 通知服务器发送短信验证码
#define HTTP_getcode_URL    [NSString stringWithFormat:@"%@getcode", SERVER_URL]
// 忘记密码
#define HTTP_forgetPsw_URL  [NSString stringWithFormat:@"%@forgetPsw", SERVER_URL]
// 修改密码
#define HTTP_modifyPsw_URL  [NSString stringWithFormat:@"%@modifyPsw", SERVER_URL]
// 用户登录
#define HTTP_Login_URL [NSString stringWithFormat:@"%@login", SERVER_URL]
// 版本更新
#define HTTP_update_URL     [NSString stringWithFormat:@"%@update", SERVER_URL]
// 意见反馈
#define HTTP_feedback_URL  [NSString stringWithFormat:@"%@feedback", SERVER_URL]
// 签约
#define HTTP_sign_URL   [NSString stringWithFormat:@"%@sign", SERVER_URL]













