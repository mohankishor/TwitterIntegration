//
//  TIUserDefaults.m
//  TwitterIntegration
//
//  Created by Mohan Kishore on 05/08/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import "TIUserDefaults.h"

@implementation TIUserDefaults

+ (id) sharedInstance
{
	static TIUserDefaults *sharedInstance = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[TIUserDefaults alloc] init];
	});
	
	return sharedInstance;
}

- (void)setTwitterAccount:(NSData *)encodedTwitterAccount
{
	[Standard_User_Defaults setObject:encodedTwitterAccount forKey:kTwitterAccount];
	[Standard_User_Defaults synchronize];
}

- (NSData *) twitterAccount
{
	NSData *encodedTwitterAccount = [Standard_User_Defaults objectForKey:kTwitterAccount];
	return encodedTwitterAccount;
}

@end
