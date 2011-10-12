//
//  GVScoreView.h
//  Breaker
//
//  Created by Joel Garrett on 10/11/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GVScoreViewDelegate;

typedef enum
{
    kScoreViewBonusExtraPoints = 1,
    kScoreViewBonusExtraBall,
} ScoreViewBonus;

#define kGVScoreViewBonusExtraPoints    150
#define kGVScoreViewBonusExtraBall      300

@interface GVScoreView : UIView
{
    id <GVScoreViewDelegate> _delegate;
    UILabel *_scoreLabel;
    
    NSUInteger _score;
    NSUInteger _bonus;
}

@property (assign) id <GVScoreViewDelegate> delegate;
@property (nonatomic, readonly) NSUInteger score;

- (void)resetScore;
- (void)applyPoints:(NSUInteger)points;

@end


@protocol GVScoreViewDelegate <NSObject>

- (void)pointsDidTriggerBonus:(ScoreViewBonus)bonus;

@end