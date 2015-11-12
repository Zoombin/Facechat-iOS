//
//  FCHTTPManager.h
//  Facechat
//
//  Created by zhangbin on 11/12/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface FCHTTPManager : AFHTTPRequestOperationManager

+ (instancetype)shared;
- (void)fetchData:(NSString *)path withBlock:(void (^)(id responseObject, NSError *error))block;

@end
