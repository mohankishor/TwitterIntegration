//
//  TIUserDefaults.h
//  TwitterIntegration
//
//  Created by Mohan Kishore on 05/08/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TI_User_Defaults [TIUserDefaults sharedInstance]
#define Standard_User_Defaults [NSUserDefaults standardUserDefaults]
#define kTwitterAccount @"twitterAccount"

@interface TIUserDefaults : NSObject

+ (id) sharedInstance;

- (void)setTwitterAccount:(NSData *)encodedTwitterAccount;
- (NSData *) twitterAccount;

@end
