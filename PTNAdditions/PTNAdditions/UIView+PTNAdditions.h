//
//  UIView+PTNAdditions.h
//  PTNAdditions
//
//  Created by Peter Gusev on 12/3/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _PTNPopupAlignmentMask {
    PTNPopupAlignmentMaskLeft = 1<<0,
    PTNPopupAlignmentMaskRight = 1<<1,
    PTNPopupAlignmentMaskCenter = 1<<2,
    PTNPopupAlignmentMaskTop = 1<<3,
    PTNPopupAlignmentMaskBottom = 1<<4,
    } PTNPopupAlignmentMask;

typedef enum _PTNSlideDirectionMask {
    PTNSlideDirectionMaskVertical = 1<<0,
    PTNSlideDirectionMaskHorizontal = 1<<1,
} PTNSlideDirectionMask;

@interface UIView (PTNAdditions)

/**
 * Sets popup animation duration
 */
+(void)setPopupAnimationDuration:(float)animationDuration;
/**
 * Sets popup animation delay
 */
+(void)setPopupAnimationDelay:(float)animationDelay;

/**
 * Shows/hides provided view in a pop-up manner
 * @param popupView View to be presented as a top subview of current view
 * @param isVisible Should show/hide popupView
 * @param animated Should animate
 * @param mask PTNAlignmentMask defines position of popup view inside current view
 * @param animationOptions Animation options
 * @param callback Block called upon animation completion
 */
-(void)setSlideView:(UIView *)slideView
            visible:(BOOL)setVisible
           animated:(BOOL)animated
      alignmentMask:(PTNPopupAlignmentMask)mask
          slideMask:(PTNSlideDirectionMask)slideMask
   animationOptions:(UIViewAnimationOptions)animationOptions
 completionCallback:(void (^)())callback;

/**
 * Presents view on top of current view
 */
-(void)viewOnTop:(UIView *)presentedView setSisible:(BOOL)setVisible;


@end
