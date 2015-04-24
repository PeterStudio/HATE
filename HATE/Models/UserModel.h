//
//  UserModel.h
//  JoJo
//
//  Created by duwen on 15/3/16.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol UserInfoModel <NSObject>

@end

@interface UserInfoModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * userId;
@property (nonatomic, copy) NSString<Optional> * name;
//@property (nonatomic, copy) NSString<Optional> * headUrl;
@end

@interface UserModel : BaseModel
@property (nonatomic, copy) UserInfoModel<Optional> * doc;
@end
