//
//  PEAlertViewManager.m
//  MKPhotoEmailEffect
//
//  Created by Mohan Kishore on 30/07/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import "TIAlertViewManager.h"

@implementation TIAlertViewManager

+ (id) sharedInstance
{
	static TIAlertViewManager *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[TIAlertViewManager alloc] init];
	});
	return sharedInstance;
}

- (void) showAlertViewWithTitle:(NSString *)title
						message:(NSString *)message
			  cancelButtonTitle:(NSString *)cancelButtonTitle
			  otherButtonTitles:(NSArray *)otherButtonTitles
				   alertHandler:(AlertHandler)alertHandlerBlock
{
	TIAlertView *alertView = [[TIAlertView alloc] initWithTitle:title
														message:message
													   delegate:self
											  cancelButtonTitle:cancelButtonTitle
											  otherButtonTitles:nil];
	
	for (NSString *title in otherButtonTitles) {
		[alertView addButtonWithTitle:title];
	}
	
	alertView.alertHandler = alertHandlerBlock;
	
	[alertView show];
}

#pragma mark - AlertView Delegate Method

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	TIAlertView *PEalertView = (TIAlertView *)alertView;
	if (PEalertView.alertHandler) {
		PEalertView.alertHandler(buttonIndex);
	}
}

@end
