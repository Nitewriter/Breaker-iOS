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

#import "GVBrick.h"

#import <QuartzCore/QuartzCore.h>

float const kGameViewPaddleDragTouch = 0.125;
float const kGameViewPaddleDragTilt = 1.0;

@interface GameView () <GVScoreViewDelegate>

@end

@implementation GameView

@synthesize ball = _ball;
@synthesize playerPaddle = _playerPaddle;
@synthesize livesView = _livesView;
@synthesize scoreView = _scoreView;
@synthesize brickView = _brickView;
@synthesize paddleDrag = _paddleDrag;
@synthesize paddleTranslation = _paddleTranslation;
@synthesize collisionSound = _collisionSound;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code
        _ballMovement = CGPointMake(4.0, 4.0);
        _paddleDrag = kGameViewPaddleDragTilt;
        
        [self setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.0]];
        
        _scoreView = [[GVScoreView alloc] initWithFrame:CGRectMake(172.0, 0.0, 140.0, 30.0)];
        [_scoreView setDelegate:self];
        [self addSubview:self.scoreView];
        
        _livesView = [[GVLivesView alloc] initWithFrame:CGRectMake(0.0, 0.0, 140.0, 30.0)];
        [_livesView setLives:3];
        [self addSubview:self.livesView];
        
        _brickView = [[GVBrickView alloc] initWithFrame:CGRectMake(8.0, 30.0, 300.0, 200.0)];
        [self addSubview:self.brickView];
        
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
        
        _paddleTranslation = _playerPaddle.center;
        
        // Load audio for collisions
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Blip_008" ofType:@"caf"];
        CFURLRef collisionURL = (CFURLRef)[NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID(collisionURL, &_collisionSound);
    }
    
    return self;
}

- (void)dealloc
{
    AudioServicesDisposeSystemSoundID(_collisionSound);
    
    [_ball release];
    [_playerPaddle release];
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
    
    // Update paddle translation
    CGFloat distance = self.paddleTranslation.x - self.playerPaddle.center.x;
    CGFloat offset_x = self.playerPaddle.center.x + (distance * self.paddleDrag);
    
    if (offset_x > CGRectGetMidX(self.playerPaddle.bounds) && 
        offset_x < CGRectGetWidth(self.frame) - CGRectGetMidX(self.playerPaddle.bounds))
        self.playerPaddle.center = CGPointMake(offset_x, self.playerPaddle.center.y);
    
    // Boundary collisions
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
    
    // Paddle collisions
    if (CGRectIntersectsRect(self.ball.frame, self.playerPaddle.frame))
    {
        AudioServicesPlaySystemSound(self.collisionSound);
        
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
    
    // Brick collisions
    else if (CGRectIntersectsRect(self.ball.frame, self.brickView.frame))
    {
        CGRect intersection = CGRectIntersection(self.ball.frame, self.brickView.frame);
        GVBrick *brick = [self.brickView brickInRect:[self convertRect:intersection toView:self.brickView]];
        
        if (brick != nil)
        {
            AudioServicesPlaySystemSound(self.collisionSound);
            
            [brick handleCollision:CGRectNull];
            
            _ballMovement.y = -_ballMovement.y;
            [self.scoreView applyPoints:[brick pointValue]];
            [self.brickView removeBrick:brick];
        }
    }
}


- (void)reset
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self addSubview:self.livesView];
    [self addSubview:self.scoreView];
    [self addSubview:self.brickView];
    [self addSubview:self.playerPaddle];
    [self addSubview:self.ball];
    
    [_scoreView resetScore];
    [_livesView setLives:3];
    
    self.ball.frame = CGRectMake(80.0, 340.0, 10.0, 10.0);
    self.playerPaddle.frame = CGRectMake(120.0, 420.0, 70.0, 10.0);
    _ballMovement = CGPointMake(4.0, 4.0);
}


- (BOOL)isGameOver
{
    return (_livesView.lives == 0 || [self.brickView.bricks count] == 0);
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
