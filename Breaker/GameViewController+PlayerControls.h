//
//  GameViewController+PlayerControls.h
//  Breaker
//
//  Created by Joel Garrett on 10/13/11.
//  Copyright (c) 2011 Joel Garrett. All rights reserved.
//

#import "GameViewController.h"


@interface GameViewController (PlayerControls)

#pragma mark - Player control methods

- (void)setControlEnabled:(BOOL)enabled;
- (void)setControlType:(GameViewPlayerControlType)controlType;


#pragma mark - UIGestureRecognizer handler methods

- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer;
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer;

#pragma mark - UIAccelerometer delegate methods

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;

@end
