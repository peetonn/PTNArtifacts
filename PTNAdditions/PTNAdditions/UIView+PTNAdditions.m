//
//  UIView+PTNAdditions.m
//  PTNAdditions
//
//  Created by Peter Gusev on 12/3/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "UIView+PTNAdditions.h"
#import <QuartzCore/QuartzCore.h>

static float PTNPopupAnimationDuration = 0.2;
static float PTNPopupAnimationDelay = 0.;

@implementation UIView (PTNAdditions)

+(void)setPopupAnimationDuration:(float)animationDuration
{
    PTNPopupAnimationDuration = animationDuration;
}

+(void)setPopupAnimationDelay:(float)animationDelay
{
    PTNPopupAnimationDelay = animationDelay;
}

-(void)setSlideView:(UIView *)slideView
            visible:(BOOL)setVisible
           animated:(BOOL)animated
      alignmentMask:(PTNAlignmentMask)mask
          slideMask:(PTNSlideDirectionMask)slideMask 
   animationOptions:(UIViewAnimationOptions)animationOptions
     animationBlock:(void (^)(UIView *slideView))animationBlock
 completionCallback:(void (^)())callback
{
    // if already shown or already hidden - skip
    BOOL alreadyVisible = (!slideView.hidden && [self.subviews containsObject:slideView]);
    if (!(setVisible^alreadyVisible))
        return;
    
    CGRect initialFrame = slideView.frame;
    CGRect hiddenFrame = slideView.frame;
    CGRect visibleFrame = slideView.frame;
    
    hiddenFrame.size.height = (slideMask&PTNSlideDirectionMaskVertical)?0:hiddenFrame.size.height;
    hiddenFrame.size.width = (slideMask&PTNSlideDirectionMaskHorizontal)?0:hiddenFrame.size.width;
    
    // horizontal alignment
    if (mask & PTNAlignmentMaskLeft)
    {
        visibleFrame.origin.x = 0;
    }
    else
    {
        if (mask & PTNAlignmentMaskRight)
        {
            visibleFrame.origin.x = self.frame.size.width - slideView.frame.size.width;
            hiddenFrame.origin.x = (slideMask & PTNSlideDirectionMaskHorizontal)?self.frame.size.width:visibleFrame.origin.x;            
        }
        else
        {
            hiddenFrame.origin.x = self.frame.size.width/2.-slideView.frame.size.width/2.;
            visibleFrame.origin.x = self.frame.size.width/2.-slideView.frame.size.width/2.;
        }
        
    }
    // vertical alignment
    if (mask & PTNAlignmentMaskTop)
    {
        visibleFrame.origin.y = 0;
        hiddenFrame.origin.y = (slideMask&PTNSlideDirectionMaskVertical)?0:visibleFrame.origin.y;
    }
    else
    {
        visibleFrame.origin.y = self.frame.size.height-slideView.frame.size.height;
        hiddenFrame.origin.y = (slideMask&PTNSlideDirectionMaskVertical)?self.frame.size.height:visibleFrame.origin.y;
    }

    
    if (setVisible)
    {
        [self addSubview:slideView];
        [self bringSubviewToFront:slideView];
        slideView.frame = hiddenFrame;
        slideView.hidden = NO;
        
        if (animated)        
            [UIView animateWithDuration:PTNPopupAnimationDuration
                              delay:PTNPopupAnimationDelay
                            options:animationOptions
                         animations:^(){
                             slideView.frame = visibleFrame;
                             
                             if (animated && animationBlock)
                                 animationBlock(slideView);
                         }
                         completion:^(BOOL finished){
                             if (callback)
                                 callback();
                         }];
        else
            slideView.frame = visibleFrame;
    }
    else
    {
        slideView.hidden = NO;
        [self addSubview:slideView];
        [self bringSubviewToFront:slideView];
        slideView.frame = visibleFrame;
        
        if (animated)
            [UIView animateWithDuration:PTNPopupAnimationDuration
                              delay:PTNPopupAnimationDelay
                            options:animationOptions
                         animations:^(){
                             slideView.frame = hiddenFrame;
                             
                             if (animated && animationBlock)
                                 animationBlock(slideView);
                         }
                         completion:^(BOOL finished){
                             slideView.hidden = YES;
                             slideView.frame = initialFrame;
                             [slideView removeFromSuperview];
                             
                             if (callback)
                                 callback();
                         }];
        else
        {
            slideView.frame = hiddenFrame;
            slideView.hidden = YES;
            slideView.frame = initialFrame;
            [slideView removeFromSuperview];   
        }
    }
}

-(void)viewOnTop:(UIView *)presentedView setVisible:(BOOL)setVisible
{
    // if view is to be presented and already presented or
    // if view was not presented and to be hidden - return
    if (!setVisible^[self.subviews containsObject:presentedView])
        return;
    
    if (setVisible)
    {
        presentedView.hidden = NO;
        presentedView.frame = self.bounds;
        [self addSubview:presentedView];
        [self bringSubviewToFront:presentedView];
    }
    else
        [presentedView removeFromSuperview];
}

-(CGMutablePathRef)roundedPathForRect:(CGRect)rect radius:(CGFloat)radius corners:(PTNAlignmentMask)corners

{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));

    // draw top right corner
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius*(corners&PTNAlignmentMaskTop && corners&PTNAlignmentMaskRight));
    // draw bottom right corner
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius*(corners&PTNAlignmentMaskBottom && corners&PTNAlignmentMaskRight));
    // draw bottom left corner
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius*(corners&PTNAlignmentMaskBottom && corners&PTNAlignmentMaskLeft));
    // draw top left corner
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius*(corners&PTNAlignmentMaskTop && corners&PTNAlignmentMaskLeft));
    CGPathCloseSubpath(path);
    
    return path;
}
@end
