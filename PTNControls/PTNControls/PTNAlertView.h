//
//  PTNAlertView.h
//  PTNControls
//
//  Created by Peter Gusev on 10/14/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTNAlertView;

typedef enum {
    PTNAlertViewStyleDefault = 1,
    PTNAlertViewStyleSecureInput = 2
    } PTNAlertViewStyle;

@interface PTNAlertView : UIAlertView <UITextFieldDelegate>
{
    NSString *_message;
    UITextView *_labelView;
}


/**
 * @name Properties
 */
/**
 * Alert view style
 */
@property (nonatomic, assign) PTNAlertViewStyle ptnAlertViewStyle;
/**
 * Entered text
 */
@property (nonatomic, readonly) NSString *enteredText;

@end

typedef void(^PTNALertViewDismissalCallback)(PTNAlertView *alertView, NSString *enteredText);

/**
 * Class wrapper for PTNAlertView with style PTNAlertViewStyleSecureInput
 */
@interface PTNInputAlertViewController : NSObject<UIAlertViewDelegate>
{
    __strong PTNAlertView *_alertView;
    __strong PTNALertViewDismissalCallback _callback;
}

/**
 * @name Class methods
 */

/**
 * Shows alert view
 */
-(void)showInputAlertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
              andDismissalCallback:(PTNALertViewDismissalCallback)clbck;

@end