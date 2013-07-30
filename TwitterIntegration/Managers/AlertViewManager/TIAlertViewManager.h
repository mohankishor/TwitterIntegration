//
//  PEAlertViewManager.h
//  MKPhotoEmailEffect
//
//  Created by Mohan Kishore on 30/07/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIAlertView.h"

#define AlertView [TIAlertViewManager sharedInstance]

@interface TIAlertViewManager : NSObject<UIAlertViewDelegate>

+ (id) sharedInstance;

- (void) showAlertViewWithTitle:(NSString *)title
						message:(NSString *)message
			  cancelButtonTitle:(NSString *)cancelButtonTitle
			  otherButtonTitles:(NSArray *)otherButtonTitles
				   alertHandler:(AlertHandler)alertHandlerBlock;

@end
