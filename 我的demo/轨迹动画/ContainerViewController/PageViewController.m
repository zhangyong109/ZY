//
//  PageViewController.m
//  Container
//
//  Created by Oliver Drobnik on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
	// set up the base view
	CGRect frame = [[UIScreen mainScreen] applicationFrame];
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	label.backgroundColor = [UIColor magentaColor];
	label.numberOfLines = 0; // multiline
	label.textAlignment = NSTextAlignmentCenter;

	// let's just have this view description
	label.text = [self description];
	self.view = label;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
	NSLog(@"willMove-%@",[self description]);
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
	NSLog(@"didMove-%@",[self description]);
}

- (void)viewWillAppear:(BOOL)animated
{
	NSLog(@"viewWillAppear-%@",[self description]);
}

- (void)viewDidAppear:(BOOL)animated
{
	NSLog(@"viewDidAppear-%@",[self description]);
}

- (void)viewWillDisappear:(BOOL)animated
{
	NSLog(@"viewWillDisappear-%@",[self description]);
}

- (void)viewDidDisappear:(BOOL)animated
{
	NSLog(@"viewDidDisappear-%@",[self description]);
}

@end
