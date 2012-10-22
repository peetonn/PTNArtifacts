//
//  PTNAlertView.h
//  PTNControls
//
//  Created by Peter Gusev on 10/14/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PTNAlertViewStyleDefault = 1,
    PTNAlertViewStyleSecureInput = 2
    } PTNAlertViewStyle;

@interface PTNAlertView : UIAlertView <UITextFieldDelegate>
{
    NSString *_message;
}

@property (nonatomic, assign) PTNAlertViewStyle ptnAlertViewStyle;
@property (nonatomic, readonly) NSString *enteredText;

@end
