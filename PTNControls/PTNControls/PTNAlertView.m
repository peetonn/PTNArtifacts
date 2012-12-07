//
//  PTNAlertView.m
//  PTNControls
//
//  Created by Peter Gusev on 10/14/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "PTNAlertView.h"


#define PTN_ALERTVIEW_CONTENT_WIDTH 260

#define PTN_ALERTVIEW_MAX_HEIGHT_VER 180
#define PTN_ALERTVIEW_MAX_HEIGHT_HOR 158

#define PTN_ALERTVIEW_LABEL_X 12
#define PTN_ALERTVIEW_LABEL_Y 40
#define PTN_ALERTVIEW_LABEL_Y_HOR (PTN_ALERTVIEW_LABEL_Y-8)
#define PTN_ALERTVIEW_LABEL_WIDTH PTN_ALERTVIEW_CONTENT_WIDTH
#define PTN_ALERTVIEW_LABEL_HEIGHT 48 // default
#define PTN_ALERTVIEW_LABEL_HEIGHT_HOR 37

#define PTN_ALERTVIEW_LABEL_TEXTFIELD_SPAN 3
#define PTN_ALERTVIEW_LABEL_TEXTFIELD_SPAN_HOR 0

#define PTN_ALERTVIEW_TEXTFIELD_X 16
#define PTN_ALERTVIEW_TEXTFIELD_Y 87
#define PTN_ALERTVIEW_TEXTFIELD_HEIGHT 28
#define PTN_ALERTVIEW_TEXTFIELD_WIDTH (PTN_ALERTVIEW_CONTENT_WIDTH-8)
#define PTN_ALERTVIEW_TEXTFIELD_BOTTOM_MARGIN 65

@interface PTNAlertView ()

@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, retain) UITextView *labelView;

@end

@implementation PTNAlertView
@synthesize ptnAlertViewStyle = _alertViewStyle, labelView = _labelView;

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
-(void)layoutSubviews
{
    [self.labelView removeFromSuperview];
    [self.passwordField removeFromSuperview];
    
    [super layoutSubviews];

    CGFloat fieldY, labelHeight, labelY;
    if ([self isLandscape])
    {
        // for some reasons, at startup, alertview's frame has incorrect height
        // we need to correct y-coordinate of textfield view accordingly
        // view's size is not changing for iPad idiom!!!
        CGFloat delta = 0;
        if (self.frame.size.height > PTN_ALERTVIEW_MAX_HEIGHT_HOR)
            delta = (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)?PTN_ALERTVIEW_MAX_HEIGHT_HOR-self.frame.size.height:PTN_ALERTVIEW_MAX_HEIGHT_VER-self.frame.size.height;
        
        fieldY = self.frame.size.height-PTN_ALERTVIEW_TEXTFIELD_BOTTOM_MARGIN-PTN_ALERTVIEW_TEXTFIELD_HEIGHT+delta;
        self.passwordField.frame = CGRectMake(PTN_ALERTVIEW_TEXTFIELD_X,
                                              fieldY,
                                              PTN_ALERTVIEW_TEXTFIELD_WIDTH,
                                              PTN_ALERTVIEW_TEXTFIELD_HEIGHT);
        
        labelHeight = (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)?(fieldY-PTN_ALERTVIEW_LABEL_TEXTFIELD_SPAN)-PTN_ALERTVIEW_LABEL_Y_HOR:(fieldY-PTN_ALERTVIEW_LABEL_TEXTFIELD_SPAN)-PTN_ALERTVIEW_LABEL_Y;
        labelY = (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)?PTN_ALERTVIEW_LABEL_Y_HOR:PTN_ALERTVIEW_LABEL_Y;
        
        self.labelView.frame = CGRectMake(self.labelView.frame.origin.x,
                                          labelY,
                                          PTN_ALERTVIEW_LABEL_WIDTH,
                                          labelHeight);
    }
    else
    {
        // for some reasons, at startup, alertview's frame has incorrect height
        // we need to correct y-coordinate of textfield view accordingly
        CGFloat delta = 0;
        if (self.frame.size.height > PTN_ALERTVIEW_MAX_HEIGHT_VER)
        {
            delta = PTN_ALERTVIEW_MAX_HEIGHT_VER-self.frame.size.height;
        }
        
        fieldY = self.frame.size.height-PTN_ALERTVIEW_TEXTFIELD_BOTTOM_MARGIN-PTN_ALERTVIEW_TEXTFIELD_HEIGHT+delta;
        self.passwordField.frame = CGRectMake(PTN_ALERTVIEW_TEXTFIELD_X,
                                              fieldY,
                                              PTN_ALERTVIEW_TEXTFIELD_WIDTH,
                                              PTN_ALERTVIEW_TEXTFIELD_HEIGHT);
        
        labelHeight = (fieldY-PTN_ALERTVIEW_LABEL_TEXTFIELD_SPAN)-PTN_ALERTVIEW_LABEL_Y;
        self.labelView.frame = CGRectMake(self.labelView.frame.origin.x,
                                          PTN_ALERTVIEW_LABEL_Y,
                                          PTN_ALERTVIEW_LABEL_WIDTH,
                                          labelHeight);
    }
    
    [self addSubview:self.labelView];
    [self addSubview:self.passwordField];
    [self.labelView flashScrollIndicators];    
}
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
    [self setupLabel];
    [self setupInputField];

    [self setAlertViewHeight];
    
    [self layoutSubviews];
}

-(UITextView*)setupLabel
{
    UITextView *lbl = [[UITextView alloc] initWithFrame:CGRectMake(PTN_ALERTVIEW_LABEL_X,
                                              PTN_ALERTVIEW_LABEL_Y,
                                              PTN_ALERTVIEW_LABEL_WIDTH,
                                              PTN_ALERTVIEW_LABEL_HEIGHT)];
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.textColor = [UIColor whiteColor];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = UITextAlignmentCenter;
    lbl.text = self.message;
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.editable = NO;
    lbl.allowsEditingTextAttributes = NO;
    
    self.labelView = lbl;
    
    return lbl;
}
// in order to increase height of alertiview for emracing content
// we calculate the text (made with "\n") which should be set as
// an alertview's label content
-(void)setAlertViewHeight //ForHeight:(CGFloat)height maxHeight:(CGFloat)maxHeight andLabelFontSize:(CGFloat)fontHeight
{
    _message = self.message;
    
    NSString *messageStubText = @"\n";
    
    int nStubLines = 2; //(height > maxHeight)?maxHeight/fontHeight:(int) (height / fontHeight);
    
    for (int i = 0; i < nStubLines; i++)
        messageStubText = [NSString stringWithFormat:@"%@\n",messageStubText];
    self.message = messageStubText;
}

-(UIView*)setupInputField
{
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(PTN_ALERTVIEW_TEXTFIELD_X,
                                                                       PTN_ALERTVIEW_TEXTFIELD_Y,
                                                                       PTN_ALERTVIEW_TEXTFIELD_WIDTH,
                                                                       PTN_ALERTVIEW_TEXTFIELD_HEIGHT)];
    self.passwordField.font = [UIFont systemFontOfSize:18];
    self.passwordField.backgroundColor = [UIColor whiteColor];
    self.passwordField.borderStyle = UITextBorderStyleBezel;
    self.passwordField.secureTextEntry = YES;
    self.passwordField.keyboardAppearance = UIKeyboardAppearanceAlert;
    self.passwordField.delegate = self;
    [self.passwordField becomeFirstResponder];

    return self.passwordField;
}
-(UIButton*)getButton
{
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
            return (UIButton*)view;
    }
    return nil;
}
-(BOOL)isLandscape
{
    return UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]);
}
@end

static PTNInputAlertViewController *currentAlertViewController;

@implementation PTNInputAlertViewController

-(void)showInputAlertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                 cancelButtonTitle:(NSString *)cancelButtonTitle
              andDismissalCallback:(PTNALertViewDismissalCallback)clbck
{
    _alertView = [[PTNAlertView alloc] initWithTitle:title
                                                          message:message
                                                         delegate:self
                                                cancelButtonTitle:cancelButtonTitle
                                                otherButtonTitles: nil];
    
    _callback = clbck;
    _alertView.ptnAlertViewStyle = PTNAlertViewStyleSecureInput;
    [_alertView show];
    currentAlertViewController = self;
}
-(void)dealloc
{
    _alertView.delegate = nil;
    _alertView = nil;
    _callback = nil;
}

// UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self invokeCallback];
}

// private
-(void)invokeCallback
{
    _callback(_alertView, _alertView.enteredText);
    currentAlertViewController = nil;
}

@end