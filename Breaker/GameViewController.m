//
//  GameViewController.m
//  Breaker
//
//  Created by Joel Garrett on 10/6/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import "GameViewController.h"
#import "GameView.h"

#define kGameViewRefreshRate    1.0/30.0

@implementation GameViewController

@synthesize currentState = _currentState;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) 
    {
        // Custom initialization
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [_tapRecognizer setNumberOfTapsRequired:1];
    }
    
    return self;
}

- (void)dealloc
{
    [_tapRecognizer release];
    [super dealloc];
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
    
    // Add tap support for game pausing
    [self.view addGestureRecognizer:_tapRecognizer];
    
    
    // Add accelerometer tracking for player paddle input
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.updateInterval = kGameViewRefreshRate;
    accelerometer.delegate = self;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.currentState = kGameViewStateGameOver;
    
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:0.0];
    [[UIAccelerometer sharedAccelerometer] setDelegate:nil];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Class methods

- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    if ([self.gameView isGameOver])
        [self.gameView reset];
    
    switch (self.currentState) {
        case kGameViewStateGameOver:
            self.currentState = kGameViewStatePlaying;
            break;
            
        case kGameViewStatePlaying:
            self.currentState = kGameViewStatePaused;
            break;
            
        case kGameViewStatePaused:
            self.currentState = kGameViewStatePlaying;
            break;
            
        default:
            NSLog(@"Current State %d: Unbound state received. Resetting state to game over.", self.currentState);
            self.currentState = kGameViewStateGameOver;
            break;
    }
    
    if (self.currentState == kGameViewStatePlaying)
        [self initializeTimer];
    else
        [_gameTimer invalidate];
}

- (void)initializeTimer
{
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:kGameViewRefreshRate target:self selector:@selector(updateGameView:) userInfo:nil repeats:YES];
}

- (void)updateGameView:(NSTimer *)timer
{
    if ([self.gameView isGameOver])
        self.currentState = kGameViewStateGameOver;
    
    if (self.currentState != kGameViewStatePlaying)
        [timer invalidate];
    
    else
        [self.gameView setNeedsDisplay];
}

- (GameView *)gameView
{
    return (GameView *)self.view;
}


#pragma mark - UIAccelerometer delegate methods

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    float offset = self.gameView.playerPaddle.center.x + (acceleration.x * 12.0);
    
    if (self.currentState == kGameViewStatePlaying && offset > 30.0 && offset < 290.0)
        self.gameView.playerPaddle.center = CGPointMake(offset, self.gameView.playerPaddle.center.y);
}

@end
