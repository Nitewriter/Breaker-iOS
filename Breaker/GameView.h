//
//  GameView.h
//  Breaker
//
//  Created by Joel Garrett on 10/6/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GVLivesView;
@class GVScoreView;
@class GVBrickView;

@interface GameView : UIView
{
    CGPoint _ballMovement;
    
    GVLivesView *_livesView;
    GVScoreView *_scoreView;
    GVBrickView *_brickView;
    UIView *_ball;
    UIView *_playerPaddle;
}

@property (nonatomic, readonly) GVLivesView *livesView;
@property (nonatomic, readonly) GVScoreView *scoreView;
@property (nonatomic, readonly) GVBrickView *brickView;
@property (nonatomic, readonly) UIView *ball;
@property (nonatomic, readonly) UIView *playerPaddle;

- (void)reset;
- (BOOL)isGameOver;

@end
