//
//  PEAlertView.h
//  MKPhotoEmailEffect
//
//  Created by Mohan Kishore on 29/07/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertHandler)(NSInteger clickedButtonIndex);

@interface TIAlertView : UIAlertView

@property (nonatomic, strong) AlertHandler alertHandler;

@end
