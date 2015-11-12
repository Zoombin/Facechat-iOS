//
//  FCViewController.m
//  Facechat
//
//  Created by zhangbin on 11/12/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import "FCViewController.h"
#import "FCHeader.h"

@interface FCViewController ()

@end

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
	
	UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
	webView.backgroundColor = self.view.backgroundColor;
	NSString *URLString = [NSString stringWithFormat:@"%@%@", BASE_URL_STRING, _href];
	
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLString]]];
	[self.view addSubview:webView];
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
