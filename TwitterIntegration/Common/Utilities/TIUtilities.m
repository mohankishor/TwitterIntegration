//
//  TIUtilities.m
//  TwitterIntegration
//
//  Created by Mohan Kishore on 19/08/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import "TIUtilities.h"

@implementation TIUtilities

+(NSString *)errorMessageForErrorObject:(NSError *)error
{
    NSString *errorMessage = nil;
    
    NSDictionary *errorUserInfoDictionary = [error userInfo];
    
    if (errorUserInfoDictionary)
    {
		if ([[errorUserInfoDictionary allKeys] containsObject:kErrorKey]) {
			errorMessage = [errorUserInfoDictionary objectForKey:kErrorKey];
		}
            
    }
    
    return errorMessage;
}

@end
