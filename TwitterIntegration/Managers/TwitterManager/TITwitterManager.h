//
//  TITwitterManager.h
//  TwitterIntegration
//
//  Created by Mohan Kishore on 30/07/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TwitterManager [TITwitterManager sharedInstance]

typedef void (^CompletionBlock)(NSData *responseData);
typedef void (^ErrorBlock)(NSError *error);

@interface TITwitterManager : NSObject

@property (strong, nonatomic) CompletionBlock completionBlock;
@property (strong, nonatomic) ErrorBlock errorBlock;

+ (id) sharedInstance;

- (void) signInWithTwitterWithParentController:(UIViewController *)controller
							   completionBlock:(CompletionBlock)completionBlock
									errorBlock:(ErrorBlock)errorBlock;
@end
