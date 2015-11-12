//
//  FirstViewController.m
//  Facechat
//
//  Created by zhangbin on 11/12/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:3000/"]]];
	[self.view addSubview:webView];
	
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
