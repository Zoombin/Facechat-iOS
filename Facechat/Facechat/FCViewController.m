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

@interface FCViewController () <UMSocialUIDelegate, WXApiDelegate>

@property UIWebView *webView;
@property WebViewJavascriptBridge *bridge;

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
	
	self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
	self.webView.backgroundColor = self.view.backgroundColor;
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL_STRING, _href]]]];
	[self.view addSubview:self.webView];
	
	self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView handler:^(id data, WVJBResponseCallback responseCallback) {
		NSLog(@"Received message from javascript: %@", data);
		responseCallback(@"Right back atcha");
	}];
	
	[self.bridge registerHandler:@"shareToWeChat" handler:^(id data, WVJBResponseCallback responseCallback) {
		if (data) {
			[self shareToWeChat:data];
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

- (void)shareToWeChat:(id)data {
	NSError *error = nil;
	FCSocialShareModel *model = [[FCSocialShareModel alloc] initWithDictionary: data error:&error];
	if (error) {
		NSLog(@"shareToWeChat error: %@", error);
		return;
	}
	
	enum WXScene scene = WXSceneSession;
	if ([model.scene isEqualToString:@"WXSceneTimeline"]) {
		scene = WXSceneTimeline;
	} else if ([model.scene isEqualToString:@"WXSceneFavorite"]) {
		scene = WXSceneFavorite;
	}
	
	if (!model.url.length) {
		return;
	}
	
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.url]];
	UIImage *image = [UIImage imageWithData:imageData];
	WXEmoticonObject *ext = [WXEmoticonObject object];
	ext.emoticonData = imageData;
	
	WXMediaMessage *message = [WXMediaMessage message];
	[message setThumbImage:image];
	message.mediaObject = ext;
	
	SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
	req.bText = NO;
	req.message = message;
	req.scene = scene;
	[WXApi sendReq:req];
}

@end
