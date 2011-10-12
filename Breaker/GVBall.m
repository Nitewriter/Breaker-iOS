//
//  GVBall.m
//  Breaker
//
//  Created by Joel Garrett on 10/9/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import "GVBall.h"

@implementation GVBall

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x, frame.origin.y, 10.0, 10.0);
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}

@end
