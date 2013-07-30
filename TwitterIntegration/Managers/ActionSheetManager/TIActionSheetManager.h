//
//  PEActionSheetManager.h
//  MKPhotoEmailEffect
//
//  Created by Mohan Kishore on 30/07/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIActionSheet.h"

#define ActionSheet [TIActionSheetManager sharedInstance]

@interface TIActionSheetManager : NSObject<UIActionSheetDelegate>

+ (id) sharedInstance;

- (void) showActionSheetWithTitle:(NSString *)title
				cancelButtonTitle:(NSString *)cancelButtonTitle
		   destructiveButtonTitle:(NSString *)destructiveButtonTitle
				otherButtonTitles:(NSArray *)otherButtonTitles
			   actionSheetHandler:(ActionSheetHandler)actionSheetHandlerBlock;

@end
