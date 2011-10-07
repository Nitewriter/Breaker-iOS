//
//  GameView.m
//  Pong
//
//  Created by Joel Garrett on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameView.h"

@implementation GameView

@synthesize ball = _ball;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _ball = [[UIView alloc] initWithFrame:CGRectMake(80.0, 80.0, 20.0, 20.0)];
        [self.ball setBackgroundColor:[UIColor blackColor]];
        [self addSubview:self.ball];
        
        _ballMovement = CGPointMake(4.0, 4.0);
    }
    
    return self;
}

- (void)dealloc
{
    [_ball release];
    [super dealloc];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.ball.center = CGPointMake(self.ball.center.x + _ballMovement.x, self.ball.center.y + _ballMovement.y);
    
    if (self.ball.center.x > 300.0 || self.ball.center.x < 20)
        _ballMovement.x = -_ballMovement.x;
    
    if (self.ball.center.y > 440.0 || self.ball.center.y < 40)
        _ballMovement.y = -_ballMovement.y;
}

@end
