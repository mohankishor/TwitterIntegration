//
//  TIComposeTweetViewController.m
//  TwitterIntegration
//
//  Created by Mohan Kishore on 05/08/13.
//  Copyright (c) 2013 FreeLancer. All rights reserved.
//

#import "TIComposeTweetViewController.h"

@interface TIComposeTweetViewController ()

@property (strong, nonatomic) UIImagePickerController *pickerController;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UITextView *addTweetTextView;

@property (weak, nonatomic) IBOutlet UIView *addTweetBackgroundView;

@property (weak, nonatomic) IBOutlet UILabel *tweetCharacterCounterLabel;

- (IBAction)tapGestureHandler:(UITapGestureRecognizer *)sender;

@end

@implementation TIComposeTweetViewController

-(void)awakeFromNib
{
	[super awakeFromNib];
	
	[self registerForKeyboardNotifications];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[self setPhotoImageView:nil];
	[self setAddTweetTextView:nil];
	[self setAddTweetBackgroundView:nil];
	[self setTweetCharacterCounterLabel:nil];
	[super viewDidUnload];
}

-(void)dealloc
{
	[self unregisterForKeyboardNotifications];
}

#pragma mark - Tap Gesture Recognizer

- (IBAction)tapGestureHandler:(UITapGestureRecognizer *)sender {
	
	[self.addTweetTextView resignFirstResponder];
	
	//Allocate image picker controller if image picker controller is not allocated
	if (!self.pickerController) {
		self.pickerController = [[UIImagePickerController alloc] init];
		self.pickerController.delegate = self;
		self.pickerController.allowsEditing = YES;
	}
	
	//Allocate Array for holding action sheet buttons.Allocate the array every time because once the scope of the method is lost,it will be deallocated by arc.
	__block NSMutableArray *actionSheetButtonsArray = [[NSMutableArray alloc] init];
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		[actionSheetButtonsArray addObject:@"Choose From Photos"];
	}
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[actionSheetButtonsArray addObject:@"Take Photo"];
	}
	
    [ActionSheet showActionSheetWithTitle:@"Add Photo"
						cancelButtonTitle:@"Cancel"
				   destructiveButtonTitle:nil
						otherButtonTitles:actionSheetButtonsArray
					   actionSheetHandler:^(NSInteger clickedButtonIndex) {
						   if (clickedButtonIndex == 0) {
							   NSLog(@"Choose From Photos Button Pressed");
							   
							   self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
							   [self presentViewController:self.pickerController animated:YES completion:nil];
						   }
						   else if (clickedButtonIndex == 1 && [actionSheetButtonsArray count] != 1)
						   {
							   NSLog(@"Take Photo Button Pressed");
							   
							   self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
							   [self presentViewController:self.pickerController animated:YES completion:nil];
						   }
					   }];
}

#pragma mark - Textview Delegate Methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{	
	NSString *actualString = [textView.text stringByReplacingCharactersInRange:range withString:text];
	
	if (actualString.length <= kMaxTweetCharacterCount) {
		self.tweetCharacterCounterLabel.text = [NSString stringWithFormat:@"%d",kMaxTweetCharacterCount - actualString.length];
		return YES;
	}
	
	return NO;
}

#pragma mark - UIImagePickerController Delegate Method

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *finalImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [self.photoImageView setImage:finalImage];
    }

	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Keyboard Notification Methods

#pragma mark - Register For Keyboard Notifications

- (void)registerForKeyboardNotifications
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShowNotification:)
												 name:UIKeyboardWillShowNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillHideNotification:)
												 name:UIKeyboardWillHideNotification
											   object:nil];
}

#pragma mark - Register For Keyboard Notifications

- (void)unregisterForKeyboardNotifications
{
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillShowNotification
												  object:nil];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillHideNotification
												  object:nil];
}

#pragma mark - KeyboardWillShownotification Method

- (void) keyboardWillShowNotification : (NSNotification *)notification
{
	TILog(@"Keyboard will show");
	[UIView animateWithDuration:kAnimationDuration
					 animations:^{
						 [self.addTweetBackgroundView setFrame:CGRectMake(self.addTweetBackgroundView.frame.origin.x, self.addTweetBackgroundView.frame.origin.y - kKeyboardHeight, self.addTweetBackgroundView.frame.size.width, self.addTweetBackgroundView.frame.size.height)];
					 }];
}

#pragma mark - KeyboardWillHidenotification Method

- (void) keyboardWillHideNotification : (NSNotification *)notification
{
	TILog(@"Keyboard will hide");
	[UIView animateWithDuration:kAnimationDuration
					 animations:^{
						 [self.addTweetBackgroundView setFrame:CGRectMake(self.addTweetBackgroundView.frame.origin.x, self.addTweetBackgroundView.frame.origin.y + kKeyboardHeight, self.addTweetBackgroundView.frame.size.width, self.addTweetBackgroundView.frame.size.height)];
					 }];
}

@end
