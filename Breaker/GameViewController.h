//
//  GameViewController.h
//  Breaker
//
//  Created by Joel Garrett on 10/6/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CADisplayLink.h>

@class GameView;

extern float const kGameViewRefreshRate;

typedef enum
{
    kGameViewStateGameOver = 0,
    kGameViewStatePlaying,
    kGameViewStatePaused
} GameViewState;

typedef enum
{
    kGameViewPlayerControlTypeTouch = 0,
    kGameViewPlayerControltypeTilt,
} GameViewPlayerControlType;

@interface GameViewController : UIViewController <UIAccelerometerDelegate>
{
    GameViewState _currentState;
    GameViewPlayerControlType _controlType;
    
    UITapGestureRecognizer *_tapRecognizer;
    UIPanGestureRecognizer *_panRecognizer;
    
    CADisplayLink *_displayLink;
}

@property (nonatomic, readonly) GameView *gameView;
@property (nonatomic, readonly) GameViewState currentState;
@property (nonatomic, readonly) GameViewPlayerControlType controlType;

- (void)startGame;
- (void)stopGame;
- (void)updateGame:(CADisplayLink *)displayLink;

@end
