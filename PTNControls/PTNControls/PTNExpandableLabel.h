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

/**
 * This class is derived from UILabel and represents a label, with custom link in the end of the text which is when tapped, expands label to comprise all text. Usually you will use this class for displaying some textual information in concise form (truncated up to visibleCharactersNum characters) with additional ability for expanding it. PTNExpandableLabel can be expanded only once.
 */
@interface PTNExpandableLabel : UILabel
{
    PTNExpandableLabelState _state;
    BOOL _isAnimating, _isExpandable;
    NSString *_originalText;
    UIColor *_functionColor, *_functionHighlightedColor;
}
/**
 * Delegate of the expandable label which conforms to PTNExpandableLabelDelegate
 */
@property (nonatomic, retain) id<PTNExpandableLabelDelegate> delegate;
/**
 * Represents current label state (expanded or not)
 */
@property (nonatomic, readonly) PTNExpandableLabelState currentState;
/**
 * Number of characters visible on the label when it is collapsed.
 */
@property (nonatomic) NSUInteger visibleCharactersNum;
/**
 * Color of "read more" label
 */
@property (nonatomic, retain) UIColor *functionColor;
/**
 * Color of "read more" label when tapped
 */
@property (nonatomic, retain) UIColor *functionHighlightedColor;
/**
 * Sets whether label should be expandable or normal label
 */
@property (nonatomic) BOOL isExpandable;
/**
 * Duration of expansion animation
 */
@property (nonatomic) float expansionAnimationDuration;

@end

/**
 * Protocol for delegates of PTNExpandableLabel
 */
@protocol PTNExpandableLabelDelegate <NSObject>
/**
 * Called upon expansion animation started
 */
-(void)expandableLabel:(PTNExpandableLabel*)expandableLabel willExpandToNewSize:(CGSize)newLabelSize duration:(NSTimeInterval)duration;
/**
 * Called upon expansion animation ended
 */
-(void)expandableLabelDidAnimationFinished:(PTNExpandableLabel *)expandableLabel;
@end