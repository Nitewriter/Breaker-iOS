//
//  GVBrickView.h
//  Breaker
//
//  Created by Joel Garrett on 10/11/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GVBrick;

@interface GVBrickView : UIView
{
    NSMutableArray *_bricks;
}

@property (nonatomic, readonly) NSMutableArray *bricks;

- (GVBrick *)brickInRect:(CGRect)rect;
- (void)removeBrick:(GVBrick *)brick;
- (void)reloadBricks;

@end
