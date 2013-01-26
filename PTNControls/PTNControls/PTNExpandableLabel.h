//
//  PTNReadMoreLabel.h
//  PTNControls
//
//  Created by Peter Gusev on 9/12/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _PTNExpandableLableState {
    PTNExpandableLabelStateMinimized = 1,
    PTNExpandableLabelStateMaximized = 2
} PTNExpandableLabelState;

@protocol PTNExpandableLabelDelegate;

@interface PTNExpandableLabel : UILabel
{
    PTNExpandableLabelState _state;
    BOOL _isAnimating, _isExpandable;
    NSString *_originalText;
    UIColor *_functionColor, *_functionHighlightedColor;
}

@property (nonatomic, retain) id<PTNExpandableLabelDelegate> delegate;
@property (nonatomic, readonly) PTNExpandableLabelState currentState;
@property (nonatomic) NSUInteger visibleCharactersNum;
@property (nonatomic, retain) UIColor *functionColor;
@property (nonatomic, retain) UIColor *functionHighlightedColor;
@property (nonatomic) BOOL isExpandable;
@property (nonatomic) float expansionAnimationDuration;

@end

@protocol PTNExpandableLabelDelegate <NSObject>
// called upon exapnsion animation started
-(void)expandableLabel:(PTNExpandableLabel*)expandableLabel willExpandToNewSize:(CGSize)newLabelSize duration:(NSTimeInterval)duration;
// called upon expansion animation ended
-(void)expandableLabelDidAnimationFinished:(PTNExpandableLabel *)expandableLabel;
@end