//
//  FCViewController.m
//  Facechat
//
//  Created by zhangbin on 11/12/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import "FCViewController.h"
#import "FCHeader.h"
#import "WebViewJavascriptBridge.h"

@interface FCViewController () <UMSocialUIDelegate>

@property UIWebView *webView;
@property WebViewJavascriptBridge *bridge;

@end

@implementation FCViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(share)];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
	self.webView.backgroundColor = self.view.backgroundColor;
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL_STRING, _href]]]];
	[self.view addSubview:self.webView];
	
	self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView handler:^(id data, WVJBResponseCallback responseCallback) {
		NSLog(@"Received message from javascript: %@", data);
		responseCallback(@"Right back atcha");
	}];
	
	[self.bridge registerHandler:@"umshare" handler:^(id data, WVJBResponseCallback responseCallback) {
		if (data) {
			NSLog(@"umshare data: %@", data);
			responseCallback(@"Right back 123");
//			self.shareInfo = [[ZMShareInfo alloc] initWithString:data error:nil];
//			if (_zmdelegate) {
//				[_zmdelegate setUpShareInfo:self.shareInfo];
//			}
		}
	}];
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

- (void)share {
	NSLog(@"share");
	
	[UMSocialSnsService presentSnsIconSheetView:self
										 appKey:UMENG_APPKEY
									  shareText:@"你要分享的文字"
									 shareImage:[UIImage imageNamed:@"Test"]
								shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession, UMShareToWechatTimeline, nil]
									   delegate:self];
}

@end
