//
//  GVScoreView.m
//  Breaker
//
//  Created by Joel Garrett on 10/11/11.
//  Copyright 2011 Joel Garrett. All rights reserved.
//

#import "GVScoreView.h"

@interface GVScoreView ()

- (void)triggerBonus;

@end

@implementation GVScoreView

@synthesize score = _score;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), 140.0, 30.0);
    
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 140.0, 30.0)];
        [_scoreLabel setTextColor:[UIColor blackColor]];
        [_scoreLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [_scoreLabel setTextAlignment:UITextAlignmentRight];
        [_scoreLabel setText:[NSString stringWithFormat:@"%03d", _score]];
        [self addSubview:_scoreLabel];
        
    }
    
    return self;
}


- (void)dealloc
{
    [_scoreLabel release];
    [super dealloc];
}


- (void)didMoveToSuperview
{
    [self setBackgroundColor:self.superview.backgroundColor];
    [_scoreLabel setBackgroundColor:self.backgroundColor];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [_scoreLabel setText:[NSString stringWithFormat:@"%03d", _score]];
}


- (void)resetScore
{
    _score = 0;
    _bonus = 0;
    
    [self setNeedsLayout];
}


- (void)applyPoints:(NSUInteger)points
{
    // TODO: Apply points and calculate bonus
    _score += points;
    _bonus += points;
    
    [self triggerBonus];
    [self setNeedsLayout];
}


- (void)triggerBonus
{
    NSUInteger trigger = (_bonus / 150);
    
    switch (trigger) {
        case 1:
        {
            _score += 5;
            _bonus += 5;
            
            if (self.delegate != nil)
                [self.delegate pointsDidTriggerBonus:kScoreViewBonusExtraPoints];
        }   
            break;
            
        case 2:
        {
            _score += 10;
            _bonus = 0;
            
            if (self.delegate != nil)
                [self.delegate pointsDidTriggerBonus:kScoreViewBonusExtraBall];
        }
            break;
            
        default:
            break;
    }
}

@end
