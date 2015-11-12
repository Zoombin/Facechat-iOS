//
//  FCHTTPManager.m
//  Facechat
//
//  Created by zhangbin on 11/12/15.
//  Copyright © 2015 zoombin. All rights reserved.
//

#import "FCHTTPManager.h"

NSString * const BASE_URL_STRING = @"http://localhost:3000/";

@implementation FCHTTPManager

+ (instancetype)shared {
	static FCHTTPManager *_shared = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_shared = [[FCHTTPManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL_STRING]];
		NSMutableSet *types = [_shared.responseSerializer.acceptableContentTypes mutableCopy];
		[types addObject:@"text/html"];
		_shared.responseSerializer.acceptableContentTypes = types;
	});
	return _shared;
}

- (NSString *)apiString:(NSString *)path {
	return [NSString stringWithFormat:@"%@%@%@", BASE_URL_STRING, @"api/", path];
}

- (void)fetchData:(NSString *)path withBlock:(void (^)(id responseObject, NSError *error))block {
	[self GET:[self apiString:path] parameters:NULL success:^(AFHTTPRequestOperation *operation, id responseObject) {
		if (block) block(responseObject, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) block(nil, error);
	}];
}

@end
