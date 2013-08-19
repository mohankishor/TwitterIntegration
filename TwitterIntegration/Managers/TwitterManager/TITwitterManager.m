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

- (void) signInWithTwitterWithParentController:(UIViewController *)parentController
							   completionBlock:(CompletionBlock)completionBlock
									errorBlock:(ErrorBlock)errorBlock
{
	if (!self.accountStore)	self.accountStore = [[ACAccountStore alloc] init];
	
	ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
	
	[self.accountStore requestAccessToAccountsWithType:accountType
								 withCompletionHandler:^(BOOL granted, NSError *error) {
									 dispatch_async(dispatch_get_main_queue(), ^{
										 if (granted) {
											 
											 NSArray *twitterAccountsArray = [self.accountStore accountsWithAccountType:accountType];
											 
											 if ([twitterAccountsArray count]) {
												 
												 UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
												 
												 TITwitterAccountSelectorViewController *twitterAccountSelectorViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TwitterAccountSelector"];
												 
												 twitterAccountSelectorViewController.twitterAccountSelectionHandler = ^(ACAccount *selectedAccount){
													 if (selectedAccount) {
														 TILog(@"%@",[selectedAccount username]);
														 
														 NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:selectedAccount];
														 [TI_User_Defaults setTwitterAccount:encodedData];
														 
														 if (completionBlock) {
															 completionBlock(encodedData);
														 }
													 }
													 else
													 {
														 if (errorBlock) {
															 errorBlock(nil);
														 }
													 }
												 };
												 
												 twitterAccountSelectorViewController.accountsArray = twitterAccountsArray;
												 
												 UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:twitterAccountSelectorViewController];
												 
												 [parentController presentViewController:navigationController animated:YES completion:nil];
												 
											 }
											 else
											 {
												 if (errorBlock) {
													 NSError *addTwitterAccountsError = [[NSError alloc] initWithDomain:kTwitterAddAccountsCustomErrorDomain code:kTwitterAddAccountsCustomErrorCode userInfo:@{kErrorKey: @"Please add twitter accounts in Settings."}];
													 errorBlock(addTwitterAccountsError);
												 }
											 }
										 }
										 else
										 {
											 if (errorBlock) {
												 NSError *addTwitterAccountsError = [[NSError alloc] initWithDomain:kTwitterAddAccountsCustomErrorDomain code:kTwitterAddAccountsCustomErrorCode userInfo:@{kErrorKey: @"Please add twitter accounts and grant access to the app in Settings."}];
												 errorBlock(addTwitterAccountsError);
											 }
										 }
									 });
								 }];
}

#pragma mark - Post Tweet

- (void) postTweetWithMessage:(NSString *)message
						Image:(NSData *)imageData
			  completionBlock:(CompletionBlock)completionBlock
				   errorBlock:(ErrorBlock)errorBlock
{
	if([TWTweetComposeViewController canSendTweet]){
		
		NSData *encodedObject = [TI_User_Defaults twitterAccount];
		ACAccount *account = (ACAccount *)[NSKeyedUnarchiver unarchiveObjectWithData: encodedObject];
		
		NSURL *url = [NSURL URLWithString:kUpdateStatusWithPhotoApiLink];
		
		TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:nil requestMethod:TWRequestMethodPOST];
		[request setAccount:account];
		
		if (imageData)
		{
			[request addMultiPartData:imageData
							 withName:@"media[]"
								 type:@"multipart/form-data"];
		}
		
		[request addMultiPartData:[message dataUsingEncoding:NSUTF8StringEncoding]
						 withName:@"status"
							 type:@"multipart/form-data"];
		
		
		[request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
			
			if (!error) {
				completionBlock(responseData);
			}
			else{
				NSError *failedToPostError = [[NSError alloc] initWithDomain:kCannotPostInTwitterCustomErrorDomain code:kCannotPostInTwitterCustomErrorCode userInfo:@{kErrorKey: @"Failed to post in twitter.Please try after some time."}];
				errorBlock(failedToPostError);
			}
		}];
	}
	else
	{
		NSError *failedToPostError = [[NSError alloc] initWithDomain:kCannotPostInTwitterCustomErrorDomain code:kCannotPostInTwitterCustomErrorCode userInfo:@{kErrorKey: @"Failed to post in twitter.Please try after some time."}];
		errorBlock(failedToPostError);
	}

}

@end
