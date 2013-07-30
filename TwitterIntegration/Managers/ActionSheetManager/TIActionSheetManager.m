//
//  PEActionSheetManager.m
//  MKPhotoEmailEffect
//
//  Created by Mohan Kishore on 30/07/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import "TIActionSheetManager.h"

@implementation TIActionSheetManager

+ (id) sharedInstance
{
	static TIActionSheetManager *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[TIActionSheetManager alloc] init];
	});
	
	return sharedInstance;
}

- (void) showActionSheetWithTitle:(NSString *)title
				cancelButtonTitle:(NSString *)cancelButtonTitle
		   destructiveButtonTitle:(NSString *)destructiveButtonTitle
				otherButtonTitles:(NSArray *)otherButtonTitles
			   actionSheetHandler:(ActionSheetHandler)actionSheetHandlerBlock
{
	TIActionSheet *actionSheet = [[TIActionSheet alloc] init];
	[actionSheet setTitle:title];
	[actionSheet setDelegate:self];
	
	int buttonIndex = 0;
	
	if (destructiveButtonTitle) {
		[actionSheet addButtonWithTitle:destructiveButtonTitle];
		[actionSheet setDestructiveButtonIndex:buttonIndex];
		buttonIndex++;
	}
	
	for (NSString *title in otherButtonTitles) {
		[actionSheet addButtonWithTitle:title];
		buttonIndex++;
	}
	
	if (cancelButtonTitle) {
		[actionSheet addButtonWithTitle:cancelButtonTitle];
		[actionSheet setCancelButtonIndex:buttonIndex];
		buttonIndex++;
	}
	
	actionSheet.actionSheetHandler = actionSheetHandlerBlock;
	
	[actionSheet showInView:[[[UIApplication sharedApplication] delegate] window]];
}

#pragma mark - Action Sheet Delegate Method

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	TIActionSheet *PEactionSheet = (TIActionSheet *)actionSheet;
	
	if (PEactionSheet.actionSheetHandler) {
		PEactionSheet.actionSheetHandler(buttonIndex);
	}
}

@end
