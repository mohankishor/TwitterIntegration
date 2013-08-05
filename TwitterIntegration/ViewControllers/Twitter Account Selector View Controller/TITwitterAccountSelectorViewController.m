//
//  TITwitterAccountSelectorViewController.m
//  TwitterIntegration
//
//  Created by Mohan Kishore on 30/07/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import "TITwitterAccountSelectorViewController.h"

@interface TITwitterAccountSelectorViewController ()

@property (weak, nonatomic) IBOutlet UITableView *twitterAccountSelectorTableView;

@end

@implementation TITwitterAccountSelectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"Select Account";
	
	UIBarButtonItem *leftBarbuttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemPressed)];
	
	[self.navigationItem setLeftBarButtonItem:leftBarbuttonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
	[self setTwitterAccountSelectorTableView:nil];
	[super viewDidUnload];
}

#pragma mark - Cancel Button Pressed

- (void) leftBarButtonItemPressed
{
	if (self.twitterAccountSelectionHandler) {
		self.twitterAccountSelectionHandler(nil);
		[self dismissViewControllerAnimated:YES completion:nil];
	}
}

#pragma mark - Table View Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.accountsArray count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTwitterAccountSelectorTableViewCellIdentifier];
	
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTwitterAccountSelectorTableViewCellIdentifier];
	}
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.accountsArray objectAtIndex:indexPath.row] username]];
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.twitterAccountSelectionHandler) {
		self.twitterAccountSelectionHandler([self.accountsArray objectAtIndex:indexPath.row]);
		[self dismissViewControllerAnimated:YES completion:nil];
	}	
}

@end
