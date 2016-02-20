//
//  ZBAnt.m
//  Facechat
//
//  Created by zhangbin on 12/29/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import "ZBAnt.h"
#import "AFHTTPRequestOperationManager.h"
#import "ZBAntTask.h"

NSString * const HOME_URL_STRING = @"http://localhost:3000/admin/";

@interface ZBAnt () <UIWebViewDelegate>

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) ZBAntTask *task;

@end

@implementation ZBAnt

- (AFHTTPRequestOperationManager *)manager {
	if (!_manager) {
		_manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:HOME_URL_STRING]];
		NSMutableSet *types = [_manager.responseSerializer.acceptableContentTypes mutableCopy];
		[types addObject:@"text/html"];
		_manager.responseSerializer.acceptableContentTypes = types;
	}
	return _manager;
}

- (UIWebView *)webView {
	if (!_webView) {
		_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		_webView.delegate = self;
	}
	return _webView;
}

- (void)fetchTaskWithBlock:(void (^)(id responseObject, NSError *error))block {
	[[self manager] GET:@"gettask" parameters:NULL success:^(AFHTTPRequestOperation *operation, id responseObject) {
		if (block) block(responseObject, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) block(nil, error);
	}];
}

- (void)submitTask:(NSString *)string withBlock:(void (^)(id responseObject, NSError *error))block {
	[[self manager] POST:@"" parameters:NULL success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
		
	} failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
		
	}];
}

- (void)start {
	[self fetchTaskWithBlock:^(id responseObject, NSError *error) {
		if (!error) {
			NSLog(@"response: %@", responseObject);
			_task = [[ZBAntTask alloc] initWithDictionary:responseObject error:nil];
			NSLog(@"task: %@", _task);
			[[self webView] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_task.url]]];
		}
	}];
}

- (void)autoClick {
	NSLog(@"autoClick");
	//TODO 这里要写一下dom的id

	NSString *titleCode = @"document.getElementById('sogou_vr_11002601_title_0').innerHTML";
	NSString *title = [[self webView] stringByEvaluatingJavaScriptFromString:titleCode];
	NSLog(@"title: %@", title);
	
	NSString *code = @"document.getElementById('sogou_vr_11002601_title_0').click()";
	[[self webView] stringByEvaluatingJavaScriptFromString:code];
}

#pragma mark - UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	if ([webView.request.URL.absoluteString containsString:@"weixin.sogou.com"]) {
		_timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoClick) userInfo:nil repeats:NO];
	}
	
	if ([webView.request.URL.absoluteString containsString:@"weixin.qq.com"]) {
		NSLog(@"url: %@", webView.request.URL.absoluteString);
		[self submitTask:webView.request.URL.absoluteString withBlock:^(id responseObject, NSError *error) {
			if (error) {
				NSLog(@"submit task error: %@", error);
			} else {
				NSLog(@"submit success");
			}
		}];
	}
}


@end
