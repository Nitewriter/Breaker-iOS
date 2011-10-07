//
//  GVLivesView.h
//  Pong
//
//  Created by Joel Garrett on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GVLivesView : UIView
{
    NSUInteger _lives;
}

@property (nonatomic, readwrite) NSUInteger lives;

@end
