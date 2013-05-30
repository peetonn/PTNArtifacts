//
//  UIViewController+PTNAdditions.m
//  PTNAdditions
//
//  Created by Peter Gusev on 5/29/13.
//  Copyright (c) 2013 peetonn inc. All rights reserved.
//

#import "UIViewController+PTNAdditions.h"
#import "NSObject+PTNAdditions.h"

@implementation UIViewController (PTNAdditions)

-(void)watchKeyboardVisibilityNotifications:(BOOL)enableListener
{
    if (enableListener)
        [self subscribeForNotificationsAndSelectors:
         UIKeyboardWillShowNotification, @selector(keyboardVisibilityChanged:),
         UIKeyboardWillHideNotification, @selector(keyboardVisibilityChanged:),
         nil];
    else
        [self unsubscribeFromNotifications:UIKeyboardWillShowNotification, UIKeyboardWillHideNotification, nil];
}

-(void)keyboardBecomeVisible:(BOOL)isVisible withFrame:(CGRect)kbdFrame andAnimationDuration:(NSTimeInterval)duration
{
}

-(void)keyboardVisibilityChanged:(NSNotification*)notification
{
    BOOL kbdShown = [notification.name isEqualToString:UIKeyboardWillShowNotification];
    
    id durationObj = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    double animationDuration = 0.25;
    
    if (durationObj && [durationObj respondsToSelector:@selector(doubleValue)])
        animationDuration = [durationObj doubleValue];
    
    CGRect kbdFrame;
    
    [(NSValue*)[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&kbdFrame];
    
    [self keyboardBecomeVisible:kbdShown
                      withFrame:kbdFrame
           andAnimationDuration:animationDuration];    
}

@end
