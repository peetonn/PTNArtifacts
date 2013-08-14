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
    PTNAlertViewStyleSecureInput = 2,
    PTNAlertViewStyleInput = 3
    } PTNAlertViewStyle;

/**
 * Modal alert view with optional secure text input on it. Can be used for promptimg users to enter passwords/codes in modal view. Derived from UIAlertView.
 */
@interface PTNAlertView : UIAlertView <UITextFieldDelegate>
{
    CGRect _lastFrame;
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

/**
 * Dismissal callback for PTNAlertView
 */
typedef void(^PTNALertViewDismissalCallback)(PTNAlertView *alertView, NSString *enteredText, NSInteger buttonIndex);

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
+(void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
                         style:(PTNAlertViewStyle)style
          andDismissalCallback:(PTNALertViewDismissalCallback)clbck
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString*)title1;
/**
 * Shows alert view
 */
-(void)showAlertViewWithTitle:(NSString *)title
                      message:(NSString *)message
                        style:(PTNAlertViewStyle)style
         andDismissalCallback:(PTNALertViewDismissalCallback)clbck
            cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString*)title1;



@end