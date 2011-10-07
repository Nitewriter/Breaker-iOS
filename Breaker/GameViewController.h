//
//  GameViewController.h
//  Breaker
//
//  Created by Joel Garrett on 10/6/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameView;

typedef enum
{
    kGameViewStateGameOver = 0,
    kGameViewStatePlaying,
    kGameViewStatePaused
} GameViewState;

@interface GameViewController : UIViewController <UIAccelerometerDelegate>
{
    GameViewState _currentState;
    UITapGestureRecognizer *_tapRecognizer;
    
    NSTimer *_gameTimer;
}

@property (nonatomic, readonly) GameView *gameView;
@property (nonatomic, readwrite) GameViewState currentState;

- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer;
- (void)initializeTimer;
- (void)updateGameView:(NSTimer *)timer;

@end
