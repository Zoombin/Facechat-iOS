//
//  ZBAntTask.h
//  Facechat
//
//  Created by zhangbin on 12/29/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ZBAntTask : JSONModel

@property (nonatomic, strong) NSNumber *error;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *number;


@end
