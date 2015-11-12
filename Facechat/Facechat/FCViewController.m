//
//  FCViewController.m
//  Facechat
//
//  Created by zhangbin on 11/12/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import "FCViewController.h"
#import "FCHeader.h"

@implementation FCViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	OKNavigationBarModel *model = [OKNavigationBarModel unarchive];
	if (model.color.length) {
		UIColor *color = [UIColor hexRGB:[model.color hexUInteger]];
		[self.navigationController.navigationBar setBarTintColor:color];
		[self.navigationController.navigationBar setTintColor:color];
	}
	if (model.titleColor.length) {
		UIColor *titleColor = [UIColor hexRGB:[model.titleColor hexUInteger]];
		[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : titleColor}];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
