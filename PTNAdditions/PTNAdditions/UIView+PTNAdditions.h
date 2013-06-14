//
//  UIView+PTNAdditions.h
//  PTNAdditions
//
//  Created by Peter Gusev on 12/3/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _PTNPopupAlignmentMask {
    PTNAlignmentMaskLeft = 1<<0,
    PTNAlignmentMaskRight = 1<<1,
    PTNAlignmentMaskCenter = 1<<2,
    PTNAlignmentMaskTop = 1<<3,
    PTNAlignmentMaskBottom = 1<<4,
    } PTNAlignmentMask;

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
      alignmentMask:(PTNAlignmentMask)mask
          slideMask:(PTNSlideDirectionMask)slideMask
   animationOptions:(UIViewAnimationOptions)animationOptions
     animationBlock:(void(^)(UIView *slideView))animationBlock
 completionCallback:(void (^)())callback;

/**
 * Presents view on top of current view
 */
-(void)viewOnTop:(UIView *)presentedView setVisible:(BOOL)setVisible;

//********************************************************************************
/**
 * @name Drawing functions
 */
/**
 * Creates path with rounded cornere along the specified recttangle
 * @param rect Rectangle which is used as a baseline for a path
 * @param radius Corner radius
 * @param corners Corners required to be rounded. Must be compound using left|right and top|bottom alignemnt masks. PTNAlignmentMaskMiddle is ignored.
 */
-(CGMutablePathRef)roundedPathForRect:(CGRect)rect radius:(CGFloat)radius corners:(PTNAlignmentMask)corners;

@end
