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
	[TwitterManager signInWithTwitterWithParentController:self
										  completionBlock:^(NSData *responseData) {
												
										  } errorBlock:^(NSError *error) {
											  
										  }];
}

@end
