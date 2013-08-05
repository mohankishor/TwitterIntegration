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
	ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	
	ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
	
	[accountStore requestAccessToAccountsWithType:accountType
							withCompletionHandler:^(BOOL granted, NSError *error) {
								dispatch_async(dispatch_get_main_queue(), ^{
									if (granted) {
										NSArray *twitterAccountsArray = [accountStore accountsWithAccountType:accountType];
										
										if ([twitterAccountsArray count]) {
											
											UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
											
											TITwitterAccountSelectorViewController *twitterAccountSelectorViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TwitterAccountSelector"];
											twitterAccountSelectorViewController.accountsArray = [twitterAccountsArray mutableCopy];
											twitterAccountSelectorViewController.twitterAccountSelectionHandler = ^(ACAccount *selectedAccount){
												if (selectedAccount) {
													TILog(@"%@",[selectedAccount username]);
													
													NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:selectedAccount];
													[TI_User_Defaults setTwitterAccount:encodedData];
													completionBlock(encodedData);
												}
											};
											
											UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:twitterAccountSelectorViewController];
											
											[parentController presentViewController:navigationController animated:YES completion:nil];
											
										}
										else
										{
											if (errorBlock) {
												errorBlock(@"Please add twitter accounts in Settings.");
											}
										}
									}
									else
									{
										if (errorBlock) {
											errorBlock(@"Please add twitter accounts and grant access to the app in Settings.");
										}
									}
								});
							}];
}

@end
