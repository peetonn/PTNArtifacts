//
//  UIViewController+PTNAdditions.h
//  PTNAdditions
//
//  Created by Peter Gusev on 5/29/13.
//  Copyright (c) 2013 peetonn inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PTNAdditions)

/**
 * Listen to keyboard visibility notifications.
 * @param enableListener If YES, current view controller will receive UIKeyboardWillShowNotification and UIKeyboardWillHideNotification notifications.
 */
-(void)watchKeyboardVisibilityNotifications:(BOOL)enableListener;

/**
 * Called when keyboard visibility has changed. Should be overriden in order to handle keyboard visibility changes.
 */
-(void)keyboardBecomeVisible:(BOOL)isVisible withFrame:(CGRect)kbdFrame andAnimationDuration:(NSTimeInterval)duration;

@end
