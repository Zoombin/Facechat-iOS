//
//  OKTabBarItemModel.h
//  facechat
//
//  Created by zhangbin on 11/12/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "OKModel.h"

@interface OKTabBarItemModel : OKModel

@property (nonatomic, strong) NSString *href;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nameColor;
@property (nonatomic, strong) NSString *nameColorSelected;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *imageSelected;

@end
