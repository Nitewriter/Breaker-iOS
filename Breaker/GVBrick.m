//
//  GVBrick.m
//  Breaker
//
//  Created by Joel Garrett on 10/9/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import "GVBrick.h"
#import <QuartzCore/QuartzCore.h>

@implementation GVBrick

@synthesize pointValue = _pointValue;

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x, frame.origin.y, 40.0, 20.0);
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code here.
        [self.layer setShouldRasterize:YES];
        [self setAnchored:YES];
    }
    
    return self;
}


- (void)handleCollision:(CGRect)collision
{
    [UIView animateWithDuration:0.3 animations:^(void) {
        
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview]; 
        
    }];
}


- (void)setPointValue:(NSInteger)pointValue
{
    _pointValue = pointValue;
    
    NSInteger rank = ((25 - pointValue) * 0.2);
    CGFloat channel = ((float)rank * 0.1) + 0.2;
    [self setBackgroundColor:[UIColor colorWithRed:channel green:channel blue:channel alpha:1.0]];
}

@end
