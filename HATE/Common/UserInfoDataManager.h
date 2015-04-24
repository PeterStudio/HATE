//
//  UserInfoDataManager.h
//  JoJo
//
//  Created by duwen on 15/3/31.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface UserInfoDataManager : NSObject
+ (UserInfoDataManager *)sharedManager;

/**
 *  获取用户信息
 *
 *  @return
 */
- (UserInfoModel *)userInfoModel;

/**
 *  保存用户信息
 *
 *  @param userInfoModel 用户信息
 */
- (void)saveUserDataWithUserInfoModel:(UserInfoModel *)userInfoModel;

/**
 *  获取用户ID
 *
 *  @return
 */
- (NSString *)userID;

/**
 *  保存帐号+密码
 *
 *  @param username  帐号
 *  @param _password 密码
 */
- (void)saveUserName:(NSString *)username password:(NSString *)_password;
/**
 *  获取帐号
 *
 *  @return
 */
- (NSString *)username;
/**
 *  获取密码
 *
 *  @return
 */
- (NSString *)password;

/**
 *  保存用户所在城市
 *
 *  @param city 城市
 */
- (void)saveUserLocationCityInfo:(NSString *)city;

/**
 *  获取用户所在城市
 *
 *  @return 
 */
- (NSString *)city;

/**
 *  退出清空用户数据
 */
- (void)clearUserInfo;

@end
