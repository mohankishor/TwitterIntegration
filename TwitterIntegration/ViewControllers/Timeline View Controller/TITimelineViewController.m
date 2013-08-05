//
//  TITimelineViewController.m
//  TwitterIntegration
//
//  Created by Mohan Kishore on 05/08/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import "TITimelineViewController.h"

@interface TITimelineViewController ()

@property (weak, nonatomic) IBOutlet UITableView *timelineTableView;

@end

@implementation TITimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[self setTimelineTableView:nil];
	[super viewDidUnload];
}

@end
