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
	
	UIBarButtonItem *leftBarbuttonItem = [[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemPressed)];
	[self.navigationItem setLeftBarButtonItem:leftBarbuttonItem];
	
	[self.navigationItem setHidesBackButton:YES];
	
	UIBarButtonItem *rightBarbuttonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(rightSystemItemPressed)];
	[self.navigationItem setRightBarButtonItem:rightBarbuttonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[self setTimelineTableView:nil];
	[super viewDidUnload];
}

-(void)dealloc
{
	[self setTimelineTableView:nil];
}

#pragma mark - Settings Button Pressed

- (void) leftBarButtonItemPressed
{
	
}

#pragma mark - Compose Tweet Button Pressed

- (void) rightSystemItemPressed
{
	[self performSegueWithIdentifier:kComposeTweetSegue sender:self];
}

@end
