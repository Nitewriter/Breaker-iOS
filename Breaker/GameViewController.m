//
//  GameViewController.m
//  Breaker
//
//  Created by Joel Garrett on 10/6/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import "GameViewController.h"
#import "GameViewController+PlayerControls.h"
#import "GameView.h"

float const kGameViewRefreshRate = (1.0 / 30.0);

@implementation GameViewController

@synthesize currentState = _currentState;
@synthesize controlType = _controlType;
@synthesize controlEnabled = _controlEnabled;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) 
    {
        // Custom initialization
        // Add tap gesture for switching game states
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [_tapRecognizer setNumberOfTapsRequired:1];
        
        // Add pan gesture for touch control support
        _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [_panRecognizer setMaximumNumberOfTouches:1];
    }
    
    return self;
}

- (void)dealloc
{
    [_tapRecognizer release];
    [_panRecognizer release];
    [super dealloc];
}


#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    CGRect frame = CGRectOffset(CGRectInset([[UIScreen mainScreen] bounds], 0.0, 10.0), 0.0, -10.0);
    
    // Create and set game view
    GameView *view = [[GameView alloc] initWithFrame:frame];
    [self setView:view];
    [view release];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Add gestures to game view
    [self.view addGestureRecognizer:_tapRecognizer];
    [self.view addGestureRecognizer:_panRecognizer];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Stop the game if playing
    if (self.currentState == kGameViewStatePlaying)
        [self stopGame];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Class methods

- (GameView *)gameView
{
    return (GameView *)self.view;
}


- (void)startGame;
{
    // Block consecutive start game calls
    if (_displayLink != nil)
        return;
    
    // Reset game view before resume if needed
    if ([self.gameView isGameOver])
        [self.gameView reset];
    
    // Set game state to playing
    _currentState = kGameViewStatePlaying;
    
    // Set player's preferred control type
    if (self.controlType != [NSUserDefaults preferredControlType])
        [self setControlType:[NSUserDefaults preferredControlType]];
    
    [self setControlEnabled:YES];
    
    // Observe display link iterations
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateGame:)];
    _displayLink.frameInterval = 2;
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode: NSDefaultRunLoopMode];
}


- (void)stopGame
{
    // Disable player controls
    [self setControlEnabled:NO];
    
    // Pause game if currently playing
    if (self.currentState == kGameViewStatePlaying)
        _currentState = kGameViewStatePaused;
    
    // Stop display link iteration observations
    [_displayLink invalidate];
    _displayLink = nil;
}


- (void)updateGame:(CADisplayLink *)__unused displayLink;
{
    if ([self.gameView isGameOver])
        _currentState = kGameViewStateGameOver;
    
    if (self.currentState != kGameViewStatePlaying)
        [self stopGame];
    
    else
        [self.gameView setNeedsDisplay];
}

@end
