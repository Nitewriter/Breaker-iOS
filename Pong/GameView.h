//
//  GameView.h
//  Pong
//
//  Created by Joel Garrett on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameView : UIView
{
    UIView *_ball;
    CGPoint _ballMovement;
}

@property (nonatomic, readonly) UIView *ball;

@end
