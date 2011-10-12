//
//  GVBrickView.m
//  Breaker
//
//  Created by Joel Garrett on 10/11/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import "GVBrickView.h"

@implementation GVBrickView

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), 300.0, 200.0);
    
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code
        [self setBackgroundColor:[UIColor blueColor]];
        _bricks = [NSMutableArray new];
    }
    
    return self;
}


- (void)dealloc
{
    [_bricks release];
    [super dealloc];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}


- (GVBrick *)brickInRect:(CGRect)rect
{
    return nil;
}


- (void)reloadBricks
{
    
}

@end
