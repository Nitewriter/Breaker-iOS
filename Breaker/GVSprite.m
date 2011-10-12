//
//  GVSprite.m
//  Breaker
//
//  Created by Joel Garrett on 10/9/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import "GVSprite.h"
#import <QuartzCore/QuartzCore.h>

@implementation GVSprite

@synthesize force = _force;
@synthesize velocity = _velocity;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Init
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // TODO: Update position based on force and velocity
}


- (void)handleCollision:(CGRect)collision
{
    // TODO: adjust force in velocity
}

@end
