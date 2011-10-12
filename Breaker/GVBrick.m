//
//  GVBrick.m
//  Breaker
//
//  Created by Joel Garrett on 10/9/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import "GVBrick.h"

@implementation GVBrick

@synthesize pointValue = _pointValue;

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x, frame.origin.y, 40.0, 20.0);
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}


- (void)setPointValue:(NSInteger)pointValue
{
    _pointValue = pointValue;
    
    CGFloat channel = ((float)pointValue * 0.1) + 0.2;
    [self setBackgroundColor:[UIColor colorWithRed:channel green:channel blue:channel alpha:1.0]];
}

@end
