//
//  UserInfoDataManager.m
//  JoJo
//
//  Created by duwen on 15/3/31.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "UserInfoDataManager.h"
static NSString * USERINFOKEY = @"PTUSERINFOKEY";
static NSString * USERNAMEKEY = @"PTUSERNAMEKEY";
static NSString * PASSWORDKEY = @"PTPASSWORDKEY";
static NSString * USERCITYKEY = @"PTUSERCITYKEY";

@implementation UserInfoDataManager
+ (UserInfoDataManager *)sharedManager{
    static UserInfoDataManager * shareUserInfoManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareUserInfoManagerInstance = [[self alloc] init];
    });
    return shareUserInfoManagerInstance;
}

- (UserInfoModel *)userInfoModel{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFOKEY];
    return [[UserInfoModel alloc] initWithDictionary:dic error:nil];
}

- (void)saveUserDataWithUserInfoModel:(UserInfoModel *)userInfoModel{
    [[NSUserDefaults standardUserDefaults] setObject:[userInfoModel toDictionary] forKey:USERINFOKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userID{
    UserInfoModel * userInfoModel = [self userInfoModel];
    return userInfoModel.userId?userInfoModel.userId:nil;
}

- (void)saveUserName:(NSString *)username password:(NSString *)_password{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:USERNAMEKEY];
    [[NSUserDefaults standardUserDefaults] setObject:_password forKey:PASSWORDKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)username{
    NSString * username = [[NSUserDefaults standardUserDefaults] objectForKey:USERNAMEKEY];
    return username?username:nil;
}

- (NSString *)password{
    NSString * password = [[NSUserDefaults standardUserDefaults] objectForKey:PASSWORDKEY];
    return password?password:nil;
}

- (void)saveUserLocationCityInfo:(NSString *)city{
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:USERCITYKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)city{
    NSString * city = [[NSUserDefaults standardUserDefaults] objectForKey:USERCITYKEY];
    return city?city:nil;
}

- (void)clearUserInfo{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:USERINFOKEY];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:PASSWORDKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
