//
//  AppDelegate.m
//  Facechat
//
//  Created by zhangbin on 11/12/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import "AppDelegate.h"
#import "FCHeader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (UINavigationController *)rootNavigationControllerWithTabBarModel:(OKTabBarItemModel *)model {
	[WXApi registerApp:@"wx42e82edbe4bcc118" withDescription:@"facechat"];
//	[UMSocialData setAppKey:UMENG_APPKEY];
//	[UMSocialWechatHandler setWXAppId:@"wx42e82edbe4bcc118" appSecret:@"fe5e2430494ccbb052fb13b4fa226aa5" url:@"http://www.umeng.com/social"];

	
	FCViewController *viewController = [[FCViewController alloc] initWithNibName:nil bundle:nil];
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	viewController.title = model.title;
	viewController.href = model.href;
	navigationController.tabBarItem.title = model.name;
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.image]];
	AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
	[requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		navigationController.tabBarItem.image = [responseObject imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		UIColor *color = [UIColor hexRGB:[model.nameColor hexUInteger]];
		[navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : color} forState:UIControlStateNormal];
	} failure:nil];
	[requestOperation start];
	
	NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:model.imageSelected]];
	AFHTTPRequestOperation *requestOperation2 = [[AFHTTPRequestOperation alloc] initWithRequest:request2];
	requestOperation2.responseSerializer = [AFImageResponseSerializer serializer];
	[requestOperation2 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		navigationController.tabBarItem.selectedImage = [responseObject imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		UIColor *color = [UIColor hexRGB:[model.nameColorSelected hexUInteger]];
		[navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : color} forState:UIControlStateSelected];
	} failure:nil];
	[requestOperation2 start];
	
	return navigationController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[[FCHTTPManager shared] fetchData:@"navigationbar" withBlock:^(id responseObject, NSError *error) {
		if (!error) {
			OKModel *baseModel = [[OKModel alloc] initWithDictionary:responseObject error:nil];
			if (baseModel.exception.boolValue) {
				NSLog(@"navigationbar message: %@", baseModel.msg);
			} else {
				OKNavigationBarModel *navigationBarModel = [[OKNavigationBarModel alloc] initWithDictionary:baseModel.data[0] error:nil];
				[navigationBarModel archive];
			}
		}
	}];
	
	[[FCHTTPManager shared] fetchData:@"tabbar/items" withBlock:^(id responseObject, NSError *error) {
		if (!error) {
			OKModel *baseModel = [[OKModel alloc] initWithDictionary:responseObject error:nil];
			if (baseModel.exception.boolValue) {
				NSLog(@"tabbar message: %@", baseModel.msg);
			} else {
				NSArray *array = baseModel.data;
				
				NSMutableArray *controllers = [NSMutableArray array];
				[array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
					OKTabBarItemModel *tabBarItemModel = [[OKTabBarItemModel alloc] initWithDictionary:obj error:nil];
					[controllers addObject:[self rootNavigationControllerWithTabBarModel:tabBarItemModel]];
				}];
				
				UITabBarController *tabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
				tabBarController.viewControllers = controllers;
				
				self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
				self.window.rootViewController = tabBarController;
				[self.window makeKeyAndVisible];
			}
		}
	}];

	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
