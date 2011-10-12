//
//  GameView.m
//  Breaker
//
//  Created by Joel Garrett on 10/6/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import "GameView.h"
#import "GVLivesView.h"
#import "GVScoreView.h"
#import "GVBrickView.h"
#import <QuartzCore/QuartzCore.h>

@interface GameView () <GVScoreViewDelegate>

- (NSMutableArray *)newBricks;

@end

@implementation GameView

@synthesize ball = _ball;
@synthesize playerPaddle = _playerPaddle;
@synthesize livesView = _livesView;
@synthesize scoreView = _scoreView;
@synthesize brickView = _brickView;
@synthesize bricks = _bricks;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code
        _ballMovement = CGPointMake(4.0, 4.0);
        
        [self setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.0]];
        
        _scoreView = [[GVScoreView alloc] initWithFrame:CGRectMake(172.0, 0.0, 140.0, 30.0)];
        [_scoreView setDelegate:self];
        [self addSubview:self.scoreView];
        
        _livesView = [[GVLivesView alloc] initWithFrame:CGRectMake(0.0, 0.0, 140.0, 30.0)];
        [_livesView setLives:3];
        [self addSubview:_livesView];
        
        _ball = [[UIView alloc] initWithFrame:CGRectMake(80.0, 340.0, 10.0, 10.0)];
        [self.ball setBackgroundColor:[UIColor blackColor]];
        [self.ball.layer setCornerRadius:CGRectGetMidX(self.ball.bounds)];
        [self.ball.layer setShouldRasterize:YES];
        [self addSubview:self.ball];
        
        _playerPaddle = [[UIView alloc] initWithFrame:CGRectMake(120.0, 420.0, 70.0, 10.0)];
        [self.playerPaddle setBackgroundColor:[UIColor grayColor]];
        [self.playerPaddle.layer setCornerRadius:4.0];
        [self.playerPaddle.layer setShouldRasterize:YES];
        [self addSubview:self.playerPaddle];
        
        _bricks = [[NSMutableArray alloc] initWithCapacity:0];
        [self.bricks addObjectsFromArray:[self newBricks]];
    }
    
    return self;
}

- (void)dealloc
{
    [_ball release];
    [_playerPaddle release];
    [_bricks release];
    [_livesView release];
    [_scoreView release];
    [_brickView release];
    
    [super dealloc];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.ball.center = CGPointMake(self.ball.center.x + _ballMovement.x, self.ball.center.y + _ballMovement.y);
    
    if (self.ball.center.x > (CGRectGetWidth(self.frame) - CGRectGetWidth(self.ball.frame)) || self.ball.center.x < CGRectGetWidth(self.ball.frame))
        _ballMovement.x = -_ballMovement.x;
    
    if (self.ball.center.y < CGRectGetHeight(self.livesView.frame))
        _ballMovement.y = -_ballMovement.y;
    else if (self.ball.center.y > CGRectGetHeight(self.frame))
    {
        [_livesView setLives:_livesView.lives - 1];
        
        self.ball.frame = CGRectMake(80.0, 340.0, 10.0, 10.0);
        self.playerPaddle.frame = CGRectMake(120.0, 420.0, 70.0, 10.0);
        _ballMovement = CGPointMake(4.0, 4.0);
    }
    
    if (CGRectIntersectsRect(self.ball.frame, self.playerPaddle.frame))
    {
        _ballMovement.y = -_ballMovement.y;
        
        CGRect collision = CGRectIntersection(self.ball.frame, self.playerPaddle.frame);
        CGPoint point = self.ball.center;
        CGFloat ball_middle = CGRectGetMidX(self.ball.bounds);
        
        //        CGFloat offset_x = (collision.origin.x - self.playerPaddle.frame.origin.x) + ball_middle;
        CGFloat offset_y = (collision.origin.y - self.playerPaddle.frame.origin.y) + ball_middle;
        
        
        if (offset_y > CGRectGetMidY(self.playerPaddle.bounds) && _ballMovement.y > 0)
            point.y = CGRectGetMaxY(self.playerPaddle.frame) + ball_middle;
        
        else if (offset_y <= CGRectGetMidY(self.playerPaddle.bounds) && _ballMovement.y < 0)
            point.y = CGRectGetMinY(self.playerPaddle.frame) - ball_middle;
        
        /*
         else if (offset_x > CGRectGetMidX(self.playerPaddle.bounds))
         point.x = CGRectGetMaxX(self.playerPaddle.frame) + center_point;
         
         else if (offset_x <= CGRectGetMidX(self.playerPaddle.bounds))
         point.x = CGRectGetMinX(self.playerPaddle.frame) - center_point;
         */
        
        self.ball.center = point;
    }
    
    else
    {
        // Add or remove bricks
        NSMutableArray *column__ = nil;
        UIView *brick__ = nil;
        
        for (NSMutableArray *column in self.bricks)
        {
            // Check for brick collisions
            for (UIView *brick in column)
                if (CGRectIntersectsRect(self.ball.frame, brick.frame))
                {
                    _ballMovement.y = -_ballMovement.y;
                    brick__ = brick;
                    break;
                }
            
            
            // Target column for removal if empty
            if (brick__ != nil)
            {
                column__ = column;
                break;
            }
        }
        
        // Handle brick removal
        if (brick__ != nil)
        {
            CGFloat row = ((brick__.frame.origin.y - 30.0) / 24.0) + 1.0;
            CGFloat multiplier = (5.0 - row) + 1.0;
            NSUInteger points = (NSUInteger)(5.0 * multiplier);
            [self.scoreView applyPoints:points];
            
            [column__ removeObject:brick__];
            
            [UIView animateWithDuration:0.3 animations:^(void) {
                
                brick__.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                
                [brick__ removeFromSuperview];
                
            }];
            
            if ([column__ count] == 0)
                [self.bricks removeObject:column__];
        }
    }
}


- (void)reset
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self addSubview:self.livesView];
    [self addSubview:self.playerPaddle];
    [self addSubview:self.ball];
    
    [_scoreView resetScore];
    [_livesView setLives:3];
    
    [self.bricks removeAllObjects];
    [self.bricks addObjectsFromArray:[self newBricks]];
    
    self.ball.frame = CGRectMake(80.0, 340.0, 10.0, 10.0);
    self.playerPaddle.frame = CGRectMake(120.0, 420.0, 70.0, 10.0);
    _ballMovement = CGPointMake(4.0, 4.0);
}


- (NSMutableArray *)newBricks
{
    NSMutableArray *bricks = [NSMutableArray arrayWithCapacity:0];
    
    for (int row = 0; row < 5; row++)
    {
        NSMutableArray *brickRow = [NSMutableArray arrayWithCapacity:0];
        CGFloat channel = ((float)row * 0.1) + 0.2;
        
        for (int column = 0; column < 7; column++)
        {
            UIView *brick = [[UIView alloc] initWithFrame:CGRectMake(44.0 * column + 8.0, 24.0 * row + 30.0, 40.0, 20.0)];
            [brick setBackgroundColor:[UIColor colorWithRed:channel green:channel blue:channel alpha:1.0]];
            [brick.layer setShouldRasterize:YES];
            
            [self addSubview:brick];
            [brickRow addObject:brick];
            [brick release];
        }
        
        [bricks addObject:brickRow];
    }
    
    return bricks;
}


- (BOOL)isGameOver
{
    return (_livesView.lives == 0 || [self.bricks count] == 0);
}


#pragma mark - GVScroreView delegate method

- (void)pointsDidTriggerBonus:(ScoreViewBonus)bonus
{
    if (bonus == kScoreViewBonusExtraBall)
        if (self.livesView.lives < 3)
            [self.livesView setLives:self.livesView.lives + 1];
        else
            [self.scoreView applyPoints:50];
}


@end
