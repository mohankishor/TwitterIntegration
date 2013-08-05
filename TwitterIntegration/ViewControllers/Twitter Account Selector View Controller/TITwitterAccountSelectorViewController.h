//
//  TITwitterAccountSelectorViewController.h
//  TwitterIntegration
//
//  Created by Mohan Kishore on 30/07/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^twitterAccountSelectionBlock)(ACAccount *selectedAccount);

@interface TITwitterAccountSelectorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *accountsArray;

@property (nonatomic, strong) twitterAccountSelectionBlock twitterAccountSelectionHandler;

@end
