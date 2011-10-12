//
//  GVBrickView.m
//  Breaker
//
//  Created by Joel Garrett on 10/11/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import "GVBrickView.h"
#import "GVBrick.h"
#import <QuartzCore/QuartzCore.h>

@implementation GVBrickView

@synthesize bricks = _bricks;

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), 304.0, 116.0);
    
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code
        _bricks = [NSMutableArray new];
    }
    
    return self;
}


- (void)didMoveToSuperview
{
    [self setBackgroundColor:self.superview.backgroundColor];
    [self reloadBricks];
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
    GVBrick *brick__ = nil;
    
    for (NSMutableArray *column in self.bricks)
        // Check for brick collisions
        for (GVBrick *brick in column)
            if (CGRectIntersectsRect(rect, brick.frame))
            {
                brick__ = brick;
                [brick handleCollision:rect];
                break;
            }
    
    return brick__;
}


- (void)removeBrick:(GVBrick *)brick
{
    if (brick == nil)
        return;
    
    NSMutableArray *targetRow = nil;
    
    for (NSMutableArray *row in _bricks)
        if ([row containsObject:brick])
        {
            targetRow = row;
            break;
        }
    
    [targetRow removeObject:brick];
    
    if ([targetRow count] == 0)
        [_bricks removeObject:targetRow];
}


- (void)reloadBricks
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_bricks removeAllObjects];
    
    for (int row = 0; row < 5; row++)
    {
        NSMutableArray *brickRow = [NSMutableArray arrayWithCapacity:0];
        
        for (int column = 0; column < 7; column++)
        {
            GVBrick *brick = [[GVBrick alloc] initWithFrame:CGRectMake(44.0 * column, 24.0 * row, 40.0, 20.0)];
            [brick setPointValue:25 - (row * 5)];
            
            [self addSubview:brick];
            [brickRow addObject:brick];
            [brick release];
        }
        
        [_bricks addObject:brickRow];
    }
}

@end
