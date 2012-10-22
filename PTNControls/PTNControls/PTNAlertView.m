//
//  PTNAlertView.m
//  PTNControls
//
//  Created by Peter Gusev on 10/14/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "PTNAlertView.h"

@interface PTNAlertView ()

@property (nonatomic, retain) UITextField *passwordField;

@end

@implementation PTNAlertView
@synthesize ptnAlertViewStyle = _alertViewStyle;

//********************************************************************
#pragma mark - received actions
// <#your IBAction's handlers goes here#>

//********************************************************************
#pragma mark - initialization and memory management
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)dealloc
{
    _message = nil;
}
//********************************************************************
#pragma mark - delegation: <#sender#>
// <#your delegated methods goes here#>

//********************************************************************
#pragma mark - protocol: <#protocol name#>
// <#your conformed protocol code goes here#>

//********************************************************************
#pragma mark - notifications
// <#your notification's handlers' code goes here#>

//********************************************************************
#pragma mark - overriden
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void)show
{
    [self prepareAlertView];
    [super show];
}

//********************************************************************
#pragma mark - class methods
// <#your class methods code goes here#>

//********************************************************************
#pragma mark - properties
-(NSString*)enteredText
{
    if (self.passwordField)
        return self.passwordField.text;
    
    return nil;
}
-(void)setPtnAlertViewStyle:(PTNAlertViewStyle)ptnAlertViewStyle
{
    _alertViewStyle = ptnAlertViewStyle;
}

//********************************************************************
#pragma mark - public methods


//********************************************************************
#pragma mark - private methods
-(void)prepareAlertView
{
    switch (self.ptnAlertViewStyle) {
        case PTNAlertViewStyleSecureInput:
            [self prepareSecureInpuAlertView];
            break;
        default:
            [self prepareDefaultView];
            break;
    }
}

-(void)prepareDefaultView
{
    self.message = _message;
}

-(void)prepareSecureInpuAlertView
{
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,40,260,25)];
    passwordLabel.font = [UIFont systemFontOfSize:16];
    passwordLabel.textColor = [UIColor whiteColor];
    passwordLabel.backgroundColor = [UIColor clearColor];
    passwordLabel.shadowColor = [UIColor blackColor];
    passwordLabel.shadowOffset = CGSizeMake(0,-1);
    passwordLabel.textAlignment = UITextAlignmentCenter;
    passwordLabel.text = self.message;
    passwordLabel.numberOfLines = 4;
    passwordLabel.lineBreakMode = UILineBreakModeWordWrap;
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    
    CGSize labelSize = [passwordLabel.text sizeWithFont:passwordLabel.font
                                      constrainedToSize:CGSizeMake(passwordLabel.frame.size.width, 999)
                                          lineBreakMode:passwordLabel.lineBreakMode];
    _message = self.message;
    
    NSString *messageStubText = @"\n";
    
    int nStubLines = (int) (labelSize.height / passwordLabel.font.lineHeight);
    nStubLines = (nStubLines<=4)?nStubLines:4;
    for (int i = 0; i < nStubLines; i++)
        messageStubText = [NSString stringWithFormat:@"%@\n",messageStubText];
    self.message = messageStubText;

    [passwordLabel sizeToFit];
    [self addSubview:passwordLabel];
    
    UIImageView *passwordImage =     [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ptnalertview_tfbg" ofType:@"png"]]];
    passwordImage.frame = CGRectMake(11,labelSize.height + 44,262,31);
    
    
    [self addSubview:passwordImage];
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(16,labelSize.height + 48,252,25)];
    self.passwordField.font = [UIFont systemFontOfSize:18];
    self.passwordField.backgroundColor = [UIColor whiteColor];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.keyboardAppearance = UIKeyboardAppearanceAlert;
    self.passwordField.delegate = self;
    [self.passwordField becomeFirstResponder];
    [self addSubview:self.passwordField];
}

@end
