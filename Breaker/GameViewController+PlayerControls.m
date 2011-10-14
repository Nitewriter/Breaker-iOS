//
//  GameViewController+PlayerControls.m
//  Breaker
//
//  Created by Joel Garrett on 10/13/11.
//  Copyright (c) 2011 Joel Garrett. All rights reserved.
//

#import "GameViewController+PlayerControls.h"
#import "GameView.h"

#import "InfoViewController.h"

@implementation GameViewController (PlayerControls)

#pragma mark - Player control methods

- (void)setControlType:(GameViewPlayerControlType)controlType
{
    _controlType = controlType;
    
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    
    if (controlType == kGameViewPlayerControltypeTilt && accelerometer.delegate == nil)
    {
        accelerometer.updateInterval = kGameViewRefreshRate;
        accelerometer.delegate = self;
        
        [_panRecognizer setEnabled:NO];
        [self.gameView setPaddleDrag:kGameViewPaddleDragTilt];
    }
    
    else if (controlType == kGameViewPlayerControlTypeTouch)
    {
        accelerometer.updateInterval = 0.0;
        accelerometer.delegate = nil;
        
        [_panRecognizer setEnabled:YES];
        [self.gameView setPaddleDrag:kGameViewPaddleDragTouch];
    }
}

#pragma mark - UIGestureRecognizer handler methods

- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    // Stop the game if playing
    if (self.currentState == kGameViewStatePlaying)
        [self stopGame];
    
    // Start the game if not playing and tapping below score/life display
    else if ([recognizer locationInView:self.view].y > 30.0)
        [self startGame];
    
    
    // TODO Add setting button during paused state
    // Display settings view controller
    else
    {
        InfoViewController *controller = [[InfoViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [controller release];
        
        [self presentModalViewController:navController animated:YES];
        [navController release];
    }
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    if (self.currentState == kGameViewStatePlaying)
        self.gameView.paddleTranslation = [recognizer locationInView:self.gameView];
}


#pragma mark - UIAccelerometer delegate methods

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    if (self.currentState == kGameViewStatePlaying)
    {
        CGFloat offset_x = self.gameView.playerPaddle.center.x + (acceleration.x * 12.0);
        CGPoint translation = CGPointMake(offset_x, self.gameView.playerPaddle.center.y);
        
        [self.gameView setPaddleTranslation:translation];   
    }
}

@end
