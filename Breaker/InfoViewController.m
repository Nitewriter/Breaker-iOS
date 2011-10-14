//
//  InfoViewController.m
//  Breaker
//
//  Created by Joel Garrett on 10/14/11.
//  Copyright (c) 2011 Joel Garrett. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoView.h"

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Breaker";
        
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(buttonPressed:)];
        self.navigationItem.rightBarButtonItem = doneItem;
        [doneItem release];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    CGRect frame = CGRectOffset(CGRectInset([[UIScreen mainScreen] bounds], 0.0, 10.0), 0.0, -10.0);
    
    InfoView *view = [[InfoView alloc] initWithFrame:frame];
    [self setView:view];
    [view release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Class methods

- (void)buttonPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
