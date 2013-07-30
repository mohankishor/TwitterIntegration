//
//  TITwitterManager.m
//  TwitterIntegration
//
//  Created by Mohan Kishore on 30/07/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import "TITwitterManager.h"

@implementation TITwitterManager

#pragma mark - Shared Instance

+ (id) sharedInstance
{
	static TITwitterManager *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[TITwitterManager alloc] init];
	});
	return sharedInstance;
}

#pragma mark - SignIn With Twitter

- (void) signInWithTwitterWithParentController:(UIViewController *)controller
							   completionBlock:(CompletionBlock)completionBlock
									errorBlock:(ErrorBlock)errorBlock
{
	
}

@end
