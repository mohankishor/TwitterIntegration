//
//  TITwitterManager.h
//  TwitterIntegration
//
//  Created by Mohan Kishore on 30/07/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Accounts/ACAccount.h>
#import <Accounts/ACAccountStore.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import "TITwitterAccountSelectorViewController.h"

#define TwitterManager [TITwitterManager sharedInstance]

typedef void (^CompletionBlock)(NSData *responseData);
typedef void (^ErrorBlock)(NSError *error);

@interface TITwitterManager : NSObject

@property (strong, nonatomic) CompletionBlock completionBlock;
@property (strong, nonatomic) ErrorBlock errorBlock;

@property (strong, nonatomic) ACAccountStore *accountStore;

+ (id) sharedInstance;

- (void) signInWithTwitterWithParentController:(UIViewController *)parentController
							   completionBlock:(CompletionBlock)completionBlock
									errorBlock:(ErrorBlock)errorBlock;

- (void) postTweetWithMessage:(NSString *)message
						Image:(NSData *)imageData
			  completionBlock:(CompletionBlock)completionBlock
				   errorBlock:(ErrorBlock)errorBlock;

@end
