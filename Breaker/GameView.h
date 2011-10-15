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
@class GVAudioPlayer;

extern float const kGameViewPaddleDragTouch;
extern float const kGameViewPaddleDragTilt;

@interface GameView : UIView
{
    CGPoint _ballMovement;
    
    GVLivesView *_livesView;
    GVScoreView *_scoreView;
    GVBrickView *_brickView;
    UIView *_ball;
    UIView *_playerPaddle;
    
    CGFloat _paddleDrag;
    CGPoint _paddleTranslation;
    
    GVAudioPlayer *_audioPlayer;
}

@property (nonatomic, readonly) GVLivesView *livesView;
@property (nonatomic, readonly) GVScoreView *scoreView;
@property (nonatomic, readonly) GVBrickView *brickView;
@property (nonatomic, readonly) UIView *ball;
@property (nonatomic, readonly) UIView *playerPaddle;

@property (nonatomic, readwrite) CGFloat paddleDrag;
@property (nonatomic, readwrite) CGPoint paddleTranslation;

@property (nonatomic, readonly) GVAudioPlayer *audioPlayer;


- (void)reset;
- (BOOL)isGameOver;

@end
