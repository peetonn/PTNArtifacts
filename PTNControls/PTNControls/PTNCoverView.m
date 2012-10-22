//
//  PTNCoverView.m
//  PTNControls
//
//  Created by Peter Gusev on 8/15/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "PTNCoverView.h"

@interface PTNCoverView ()
-(void)initialize;
-(void)handleTap:(UITapGestureRecognizer*)tapRcognizer;
@end

@implementation PTNCoverView
@synthesize delegate;

//********************************************************************
#pragma mark - received actions
// <#your IBAction's handlers goes here#>

//********************************************************************
#pragma mark - initialization and memory management
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
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
// <#your overide code goes here#>

//********************************************************************
#pragma mark - class methods
// <#your class methods code goes here#>

//********************************************************************
#pragma mark - properties
// <#your customized accessors' code goes here#>

//********************************************************************
#pragma mark - public methods
// <#your public methods' code goes here#>

//********************************************************************
#pragma mark - private methods
-(void)initialize
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapRecognizer];    
}

-(void)handleTap:(UITapGestureRecognizer*)tapRecognizer
{
    if (tapRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(coverViewWasTapped:)])
            [self.delegate coverViewWasTapped:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
