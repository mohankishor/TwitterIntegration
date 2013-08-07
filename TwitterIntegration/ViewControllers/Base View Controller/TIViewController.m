//
//  TIViewController.m
//  TwitterIntegration
//
//  Created by Mohan Kishore on 30/07/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import "TIViewController.h"

@interface TIViewController ()

- (IBAction)signinButtonPressed:(id)sender;

@end

@implementation TIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Sign In Button Pressed

- (IBAction)signinButtonPressed:(id)sender {
	
	[sender setEnabled:NO];
	
	__weak typeof(self) weakSelf = self;
	__weak typeof(sender) weakSender = sender;
	
	[TwitterManager signInWithTwitterWithParentController:self
										  completionBlock:^(NSData *responseData) {
											  
											  [weakSender setEnabled:YES];
											  
											  [weakSelf performSegueWithIdentifier:kComposeTweetSegue sender:self];
											  
										  } errorBlock:^(NSString *errorString) {
											  
											  [weakSender setEnabled:YES];
											  
											  if (errorString) {
												  [AlertView showAlertViewWithTitle:@"Alert!"
																			message:errorString
																  cancelButtonTitle:@"OK"
																  otherButtonTitles:nil
																	   alertHandler:nil];
											  }
										  }];
}

@end
