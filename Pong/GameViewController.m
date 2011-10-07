//
//  GameViewController.m
//  Pong
//
//  Created by Joel Garrett on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "GameView.h"

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) 
    {
        // Custom initialization
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
    GameView *view = [[GameView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setView:view];
    [view release];
}


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initializeTimer];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Class methods

- (void)initializeTimer
{
    float interval = 1.0/30.0;
    [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(updateGameView:) userInfo:nil repeats:YES];
}

- (void)updateGameView:(NSTimer *)timer
{
    [self.gameView setNeedsDisplay];
}

- (GameView *)gameView
{
    return (GameView *)self.view;
}

@end
