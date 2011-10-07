//
//  GameViewController.h
//  Pong
//
//  Created by Joel Garrett on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameView;

@interface GameViewController : UIViewController

@property (nonatomic, readonly) GameView *gameView;

- (void)initializeTimer;
- (void)updateGameView:(NSTimer *)timer;

@end
