//
//  GameViewController+PlayerControls.m
//  Breaker
//
//  Created by Joel Garrett on 10/13/11.
//  Copyright (c) 2011 Joel Garrett. All rights reserved.
//

#import "GameViewController+PlayerControls.h"
#import "GameView.h"

@implementation GameViewController (PlayerControls)

#pragma mark - Player control methods

- (void)setControlType:(GameViewPlayerControlType)controlType
{
    _controlType = controlType;
    
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    
    if (controlType == kGameViewPlayerControltypeTilt)
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
    if ([self.gameView isGameOver])
        [self.gameView reset];
    
    switch (self.currentState) {
        case kGameViewStateGameOver:
            _currentState = kGameViewStatePlaying;
            break;
            
        case kGameViewStatePlaying:
            _currentState = kGameViewStatePaused;
            break;
            
        case kGameViewStatePaused:
            _currentState = kGameViewStatePlaying;
            break;
            
        default:
            NSLog(@"Current State %d: Unbound state received. Resetting state to game over.", self.currentState);
            _currentState = kGameViewStateGameOver;
            break;
    }
    
    
    if (self.currentState == kGameViewStatePlaying)
        [self startGame];
    
    else
        [self stopGame];
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    if (self.currentState == kGameViewStatePlaying)
        switch (recognizer.state) {
            case UIGestureRecognizerStateChanged:
            {
                self.gameView.paddleTranslation = [recognizer locationInView:self.gameView];;
            }
                break;
                
            default:
                break;
        }
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
