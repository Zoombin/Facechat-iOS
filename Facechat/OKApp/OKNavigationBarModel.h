//
//  OKNavigationBarModel.h
//  facechat
//
//  Created by zhangbin on 11/12/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "OKModel.h"

@interface OKNavigationBarModel : OKModel

@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *titleColor;

- (void)archive;
+ (instancetype)unarchive;

@end
