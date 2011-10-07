//
//  GameView.h
//  Pong
//
//  Created by Joel Garrett on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GVLivesView;

@interface GameView : UIView
{
    CGPoint _ballMovement;
    NSUInteger _score;
    NSUInteger _bonus;
    
    GVLivesView *_livesView;
    UIView *_ball;
    UIView *_playerPaddle;
    UILabel *_scoreLabel;
    
    NSMutableArray *_bricks;
    
}

@property (nonatomic, readonly) GVLivesView *livesView;
@property (nonatomic, readonly) UIView *ball;
@property (nonatomic, readonly) UIView *playerPaddle;
@property (nonatomic, readonly) UILabel *scoreLabel;

@property (nonatomic, readonly) NSMutableArray *bricks;

- (void)reset;
- (BOOL)isGameOver;

@end
