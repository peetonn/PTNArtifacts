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
    BOOL _isAnimating;
    NSString *_originalText;
    UIColor *_functionColor, *_functionHighlightedColor;
}

@property (nonatomic, retain) id<PTNExpandableLabelDelegate> delegate;
@property (nonatomic, readonly) PTNExpandableLabelState currentState;
@property (nonatomic) NSUInteger visibleCharactersNum;
@property (nonatomic) UIColor *functionColor;
@property (nonatomic) UIColor *functionHighlightedColor;
@property (nonatomic) BOOL isExpandable;

@end

@protocol PTNExpandableLabelDelegate <NSObject>

-(void)expandableLabel:(PTNExpandableLabel*)expandableLabel willExpandToNewSize:(CGSize)newLabelSize duration:(NSTimeInterval)duration;
-(void)expandableLabelDidAnimationFinished:(PTNExpandableLabel *)expandableLabel;

@end