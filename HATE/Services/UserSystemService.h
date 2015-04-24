//
//  UserSystemService.h
//  Card58
//
//  Created by duwen on 15/4/12.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseService.h"
#import "VersionModel.h"
#import "UserModel.h"
@interface UserSystemService : BaseService
- (void)request_Register_Http_phone:(NSString *)_phone
                                msg:(NSString *)_msg
                                psw:(NSString *)_psw
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

- (void)request_GetCode_Http_phone:(NSString *)_phone
                              type:(NSString *)_type
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

- (void)request_ForgetPsw_Http_phone:(NSString *)_phone
                                 msg:(NSString *)_msg
                                 psw:(NSString *)_psw
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;


- (void)request_Login_Http_phone:(NSString *)_phone
                             psw:(NSString *)_psw
                          system:(NSString *)_system
                         version:(NSString *)_version
                            imei:(NSString *)_imei
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

- (void)request_Update_Http_version:(NSString *)_version
                               type:(NSString *)_type
                               imei:(NSString *)_imei
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

- (void)request_Feedback_Http_userId:(NSString *)_userId
                             contact:(NSString *)_contact
                             content:(NSString *)_content
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

- (void)request_Sign_Http_userId:(NSString *)_userId
                        bankType:(NSString *)_bankType
                         accName:(NSString *)_accName
                  onekeyTranType:(NSString *)_onekeyTranType
                        certType:(NSString *)_certType
                          certNo:(NSString *)_certNo
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;
@end
