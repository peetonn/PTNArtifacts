//
//  UIView+PTNAdditions.m
//  PTNAdditions
//
//  Created by Peter Gusev on 12/3/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "UIView+PTNAdditions.h"

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
      alignmentMask:(PTNPopupAlignmentMask)mask
          slideMask:(PTNSlideDirectionMask)slideMask 
   animationOptions:(UIViewAnimationOptions)animationOptions
 completionCallback:(void (^)())callback
{
    CGRect initialFrame = slideView.frame;
    CGRect hiddenFrame = slideView.frame;
    CGRect visibleFrame = slideView.frame;
    
//    hiddenFrame.size.height = (slideMask&PTNSlideDirectionMaskVertical)?0:hiddenFrame.size.height;
//    hiddenFrame.size.width = (slideMask&PTNSlideDirectionMaskHorizontal)?0:hiddenFrame.size.width;
    
    // horizontal alignment
    if (mask & PTNPopupAlignmentMaskLeft)
    {
        visibleFrame.origin.x = 0;
        hiddenFrame.origin.x = (slideMask & PTNSlideDirectionMaskHorizontal)?-slideView.frame.size.width:visibleFrame.origin.x;
    }
    else
    {
        if (mask & PTNPopupAlignmentMaskRight)
        {
            visibleFrame.origin.x = self.frame.size.width - slideView.frame.size.width;
            hiddenFrame.origin.x = (slideMask & PTNSlideDirectionMaskHorizontal)?self.frame.size.width:visibleFrame.origin.x;            
        }
        else
        {
            hiddenFrame.origin.x = self.frame.size.width/2.-slideView.frame.size.width/2.;
            visibleFrame.origin.x = hiddenFrame.origin.x;
        }
        
    }
    // vertical alignment
    if (mask & PTNPopupAlignmentMaskTop)
    {
        visibleFrame.origin.y = 0;
        hiddenFrame.origin.y = (slideMask&PTNSlideDirectionMaskVertical)?-slideView.frame.size.height:visibleFrame.origin.y;
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
        
        [UIView animateWithDuration:PTNPopupAnimationDuration
                              delay:PTNPopupAnimationDelay
                            options:animationOptions
                         animations:^(){
                             slideView.frame = visibleFrame;
                         }
                         completion:^(BOOL finished){
                             if (callback)
                                 callback();
                         }];
    }
    else
    {
        slideView.hidden = NO;
        [self addSubview:slideView];
        [self bringSubviewToFront:slideView];
        slideView.frame = visibleFrame;
        
        [UIView animateWithDuration:PTNPopupAnimationDuration
                              delay:PTNPopupAnimationDelay
                            options:animationOptions
                         animations:^(){
                             slideView.frame = hiddenFrame;
                         }
                         completion:^(BOOL finished){
                             slideView.hidden = YES;
                             slideView.frame = initialFrame;
                             [slideView removeFromSuperview];
                             
                             if (callback)
                                 callback();
                         }];
        
    }
}

@end
