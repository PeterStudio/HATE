//
//  VersionModel.h
//  MirLiDoctor
//
//  Created by duwen on 15/2/10.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "BaseModel.h"

@protocol VersionNewsModel <NSObject>

@end

@interface VersionNewsModel : JSONModel
@property (nonatomic, copy) NSString<Optional> * version;
@property (nonatomic, copy) NSString<Optional> * content;
@property (nonatomic, copy) NSString<Optional> * isUpdate;
@property (nonatomic, copy) NSString<Optional> * urlAddress;
@end

@interface VersionModel : BaseModel
@property (nonatomic,copy) VersionNewsModel<Optional> * doc;
@end
