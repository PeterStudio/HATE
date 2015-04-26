//
//  UserSystemService.m
//  Card58
//
//  Created by duwen on 15/4/12.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "UserSystemService.h"

@implementation UserSystemService

// 3.1.1	注册
- (void)request_Register_Http_phone:(NSString *)_phone
                                msg:(NSString *)_msg
                                psw:(NSString *)_psw
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure{
    NSString * hashStr = [NSString stringWithFormat:@"%@%@%@%@",_phone,_msg,_psw,MD5KEY];
    NSDictionary * params = @{@"phone":_phone
                              ,@"msg":_msg
                              ,@"psw":[_psw stringFromMD5]
                              ,@"hash":hashStr};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_register_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UserModel * demoModel = [[UserModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.2	通知服务器发送短信验证码 0 注册 1 忘记密码
- (void)request_GetCode_Http_phone:(NSString *)_phone
                              type:(NSString *)_type
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure{
    NSString * hashStr = [NSString stringWithFormat:@"%@%@%@",_phone,_type,MD5KEY];
    NSDictionary * params = @{@"phone":_phone,@"type":_type,@"hash":hashStr};
    // 发送POST请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_getcode_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BaseModel * demoModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"demoModel==%@",demoModel);
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.3	忘记密码 msg 10字以内 psw md5加密
- (void)request_ForgetPsw_Http_phone:(NSString *)_phone
                                 msg:(NSString *)_msg
                                 psw:(NSString *)_psw
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure{
    NSString * hashStr = [NSString stringWithFormat:@"%@%@%@%@",_phone,_msg,_psw,MD5KEY];
    NSDictionary * params = @{@"phone":_phone,@"msg":_msg,@"psw":[_psw stringFromMD5],@"hash":hashStr};
    // 发送POST请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_forgetPsw_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BaseModel * demoModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.4	用户登录 psw md5加密 system 1(苹果)
- (void)request_Login_Http_phone:(NSString *)_phone
                             psw:(NSString *)_psw
                          system:(NSString *)_system
                         version:(NSString *)_version
                            imei:(NSString *)_imei
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure{
    NSString * hashStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",_phone,_psw,_system,_version,_imei,MD5KEY];
    NSDictionary * params = @{@"phone":_phone,@"psw":[_psw stringFromMD5],@"system":_system,@"version":_version,@"imei":_imei,@"hash":hashStr};

    // 发送POST请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_Login_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UserModel * demoModel = [[UserModel alloc] initWithDictionary:responseObject error:nil];
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.5	版本更新 type=1(苹果)
- (void)request_Update_Http_version:(NSString *)_version
                               type:(NSString *)_type
                               imei:(NSString *)_imei
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure{
    NSString * hashStr = [NSString stringWithFormat:@"%@%@%@%@",_version,_type,_imei,MD5KEY];
    NSDictionary * params = @{@"version":_version,@"type":_type,@"imei":_imei,@"hash":hashStr};
    // 发送POST请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_update_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        VersionModel * demoModel = [[VersionModel alloc] initWithDictionary:responseObject error:nil];
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.6	意见反馈 contact 30字以内 content 200字以内
- (void)request_Feedback_Http_userId:(NSString *)_userId
                             contact:(NSString *)_contact
                             content:(NSString *)_content
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure{
    NSString * hashStr = [NSString stringWithFormat:@"%@%@%@%@",_userId,_contact,_content,MD5KEY];
    NSDictionary * params = @{@"userId":_userId,@"contact":_contact,@"content":_content,@"hash":hashStr};
    // 发送POST请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:HTTP_feedback_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BaseModel * demoModel = [[BaseModel alloc] initWithDictionary:responseObject error:nil];
        if (success) {
            success(demoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)request_Sign_Http_userId:(NSString *)_userId
                        bankType:(NSString *)_bankType
                         accName:(NSString *)_accName
                  onekeyTranType:(NSString *)_onekeyTranType
                        certType:(NSString *)_certType
                          certNo:(NSString *)_certNo
                         success:(void (^)(id))success
                         failure:(void (^)(NSError *))failure{
    NSString * hashStr = nil;
    NSDictionary * params = nil;
    if ([@"0" isEqualToString:_onekeyTranType]) {
        hashStr = [NSString stringWithFormat:@"%@%@%@%@%@",_userId,[_bankType stringFromMD5],_accName,_onekeyTranType,MD5KEY];
        params = @{@"userId":_userId,@"bankType":_bankType,@"accName":_accName,@"onekeyTranType":_onekeyTranType,@"hash":hashStr};
    }else{
        hashStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",_userId,[_bankType stringFromMD5],_accName,_onekeyTranType,_certType,_certNo,MD5KEY];
        params = @{@"userId":_userId,@"bankType":_bankType,@"accName":_accName,@"onekeyTranType":_onekeyTranType,@"certType":_certType,@"certNo":_certNo,@"hash":hashStr};
    }
    // 发送POST请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [manager POST:HTTP_sign_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

@end
