//
//  GVLivesView.m
//  Pong
//
//  Created by Joel Garrett on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GVLivesView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GVLivesView

@synthesize lives = _lives;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code
    }
    
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil)
        return;
    
    [self setBackgroundColor:newSuperview.backgroundColor];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int life = 0; life < _lives; life++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(life * 14.0 + 10.0, 10.0, 10.0, 10.0)];
        [view setBackgroundColor:[UIColor blackColor]];
        [view.layer setCornerRadius:CGRectGetMidX(view.bounds)];
        [self addSubview:view];
    }
}

- (void)setLives:(NSUInteger)lives
{
    if (lives > 3)
        lives = 3;
    
    _lives = lives;
    [self setNeedsDisplay];
}

@end
