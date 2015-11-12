//
//  OKModel.h
//  facechat
//
//  Created by zhangbin on 11/12/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface OKModel : JSONModel

@property (nonatomic, strong) NSNumber *version;
@property (nonatomic, strong) NSNumber *exception;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray *data;

@end
