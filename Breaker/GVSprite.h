//
//  GVSprite.h
//  Breaker
//
//  Created by Joel Garrett on 10/9/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GVSprite : UIView
{
    CGPoint _force;
    CGPoint _velocity;
}

@property (nonatomic) CGPoint force;
@property (nonatomic) CGPoint velocity;

- (void)handleCollision:(CGRect)collision;

@end

