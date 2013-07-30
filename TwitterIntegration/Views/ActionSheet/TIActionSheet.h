//
//  PEActionSheet.h
//  MKPhotoEmailEffect
//
//  Created by Mohan Kishore on 30/07/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionSheetHandler)(NSInteger clickedButtonIndex);

@interface TIActionSheet : UIActionSheet

@property (nonatomic, strong) ActionSheetHandler actionSheetHandler;

@end
