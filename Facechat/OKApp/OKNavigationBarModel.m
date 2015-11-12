//
//  OKNavigationBarModel.m
//  facechat
//
//  Created by zhangbin on 11/12/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import "OKNavigationBarModel.h"

NSString * const OK_USER_DEFAULT_KEY_NAVIGATION_BAR_COLOR = @"OK_USER_DEFAULT_KEY_NAVIGATION_BAR_COLOR";
NSString * const OK_USER_DEFAULT_KEY_NAVIGATION_BAR_TITLE_COLOR = @"OK_USER_DEFAULT_KEY_NAVIGATION_BAR_TITLE_COLOR";

@implementation OKNavigationBarModel

- (void)archive {
	if (_color.length) {
		[[NSUserDefaults standardUserDefaults] setObject:_color forKey:OK_USER_DEFAULT_KEY_NAVIGATION_BAR_COLOR];
		[[NSUserDefaults standardUserDefaults] setObject:_titleColor forKey:OK_USER_DEFAULT_KEY_NAVIGATION_BAR_TITLE_COLOR];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}

+ (instancetype)unarchive {
	OKNavigationBarModel *model = [[OKNavigationBarModel alloc] init];
	NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:OK_USER_DEFAULT_KEY_NAVIGATION_BAR_COLOR];
	NSString *titleColor = [[NSUserDefaults standardUserDefaults] objectForKey:OK_USER_DEFAULT_KEY_NAVIGATION_BAR_TITLE_COLOR];
	model.color = color;
	model.titleColor = titleColor;
	return model;
}

@end
