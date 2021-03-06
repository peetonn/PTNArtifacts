//
//  PTNReadMoreLabel.m
//  PTNControls
//
//  Created by Peter Gusev on 9/12/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#define PTN_EXPLABEL_FUNCTION_TEXT @"read more"
#define PTN_EXPLABEL_DEFAULT_VISIBLE_CHNUM 140
#define PTN_EXPLABEL_KX -2
#define PTN_EXPLABEL_KY 2
#define PTN_EXPLABEL_EXPANSION_DURATION .15

#import "PTNExpandableLabel.h"
#import "NSAttributedString+PTNAttributes.h"
#import <QuartzCore/QuartzCore.h>

@interface PTNExpandableLabel()
@property (nonatomic, strong) CATextLayer *customLayer;

-(NSString*)truncateText:(NSString*)text byVisibleCharacters:(NSInteger)charactersNum;

@end

@implementation PTNExpandableLabel
@synthesize visibleCharactersNum;
@synthesize customLayer;
@synthesize currentState = _state;

//********************************************************************
#pragma mark - received actions
// <#your IBAction's handlers goes here#>

//********************************************************************
#pragma mark - initialization and memory management

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        {
            [self initialize];
        }
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    _state = PTNExpandableLabelStateMinimized;
    self.customLayer = [[CATextLayer alloc] init];
    self.customLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.customLayer.alignmentMode = kCAAlignmentRight;
    [self.layer addSublayer: self.customLayer];
    self.customLayer.string = [self functionString];
    self.customLayer.contentsScale = [[UIScreen mainScreen] scale]; 
    
    [self updateCustomLayerToSize:self.frame.size];
    
    self.visibleCharactersNum = PTN_EXPLABEL_DEFAULT_VISIBLE_CHNUM;
    self.isExpandable = YES;
    self.expansionAnimationDuration = PTN_EXPLABEL_EXPANSION_DURATION;
}

-(void)dealloc
{
    self.customLayer = nil;
}

//********************************************************************
#pragma mark - delegation: 

//********************************************************************
#pragma mark - protocol:
// 

//********************************************************************
#pragma mark - notifications
//

//********************************************************************
#pragma mark - overriden
-(CGSize)sizeThatFits:(CGSize)size
{
    CGSize sz = [super sizeThatFits:size];
    sz.width = size.width;
    
    return sz;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self updateCustomLayerToSize:frame.size];
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.customLayer.string = [self functionString];
    [self updateCustomLayerToSize:self.frame.size];
}
-(void)setText:(NSString *)text
{
    text = [[text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];
    
    if ([text length] > self.visibleCharactersNum && self.isExpandable)
    {
        _originalText = text;
        [super setText:[self truncateText:text byVisibleCharacters:self.visibleCharactersNum]];
    }
    else
    {
        [super setText:text];
        self.customLayer.hidden = YES;
    }
    [self sizeToFit];    
}
-(void)setHighlighted:(BOOL)highlighted
{
    if (self.isHighlighted ^ highlighted && !_isAnimating)
    {
        _isAnimating = YES;
        
        CGSize maxSize = CGSizeMake(self.frame.size.width, 999);
        CGSize newLabelSize = [_originalText sizeWithFont:self.font
                                        constrainedToSize:maxSize
                                            lineBreakMode:self.lineBreakMode];

        [super setText:_originalText];        
        self.customLayer.hidden = YES;
        
        [UIView animateWithDuration:self.expansionAnimationDuration
                              delay:0.
                            options:UIViewAnimationOptionCurveLinear
                         animations:^(void){
                             CGRect newFrame = self.frame;
                             newFrame.size.height = newLabelSize.height;
                             
                             if (self.delegate && [self.delegate respondsToSelector:@selector(expandableLabel:willExpandToNewSize:duration:)])
                             {
                                 [self.delegate expandableLabel:self
                                            willExpandToNewSize:newFrame.size
                                                       duration:self.expansionAnimationDuration];
                             }
                             
                             self.frame = newFrame;
                         }
                         completion:^(BOOL finished) {
                             _state = PTNExpandableLabelStateMaximized;
                             _isAnimating = NO;
                             [self sizeToFit];
                             
                             if (self.delegate && [self.delegate respondsToSelector:@selector(expandableLabelDidAnimationFinished:)])
                             {
                                 [self.delegate expandableLabelDidAnimationFinished:self];
                             }
                         }];
    }
    
    [super setHighlighted:highlighted];
    [self redrawCustomLayer];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (event.type == UIEventTypeTouches && touches.count == 1)
    {
        UITouch *touch = [touches anyObject];
        if ([self.customLayer hitTest:[touch locationInView:self]] == self.customLayer)//|| [self.layer hitTest:[touch locationInView:self]] == self.layer)
            [self setHighlighted:YES];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (event.type == UIEventTypeTouches)
    {
        [self setHighlighted:NO];
    }
}
//********************************************************************
#pragma mark - class methods
// 

//********************************************************************
#pragma mark - properties
-(void)setFunctionColor:(UIColor *)functionColor
{
    _functionColor = functionColor;
    [self redrawCustomLayer];
}
-(UIColor*)functionColor
{
    if (!_functionColor)
        _functionColor = [UIColor blueColor];
    
    return _functionColor;
}
-(void)setFunctionHighlightedColor:(UIColor *)functionHighlightedColor
{
    _functionHighlightedColor = functionHighlightedColor;
    [self redrawCustomLayer];
}
-(UIColor*)functionHighlightedColor
{
    if (!_functionHighlightedColor)
        _functionHighlightedColor = [UIColor redColor];
    return _functionHighlightedColor;
}
-(void)setIsExpandable:(BOOL)isExpandable
{
    _isExpandable = isExpandable;
    self.customLayer.hidden = !isExpandable;
}
-(BOOL)isExpandable
{
    return _isExpandable;
}
//********************************************************************
#pragma mark - public methods
// <#your public methods' code goes here#>

//********************************************************************
#pragma mark - private methods
-(NSString*)truncateText:(NSString*)text byVisibleCharacters:(NSInteger)charactersNum
{
    return [NSString stringWithFormat:@"%@...",[text stringByPaddingToLength:charactersNum-3 withString:@"" startingAtIndex:0]];    
}
-(UIFont*)functionFont
{
    return [UIFont systemFontOfSize:self.font.pointSize];//[UIFont italicSystemFontOfSize:self.font.pointSize];
}

-(NSAttributedString*)functionString
{
    NSMutableAttributedString *str = [NSMutableAttributedString attributedStringWithString:PTN_EXPLABEL_FUNCTION_TEXT];
    [str setFont:[self functionFont]];
    [str setTextColor: (self.isHighlighted)?self.functionHighlightedColor:self.functionColor];
    return str;
}
-(void)redrawCustomLayer
{
    self.customLayer.string = [self functionString];
    [self.customLayer setNeedsDisplay];
}
-(void)updateCustomLayerToSize:(CGSize)sz
{
    CGSize textSize = [PTN_EXPLABEL_FUNCTION_TEXT sizeWithFont:[self functionFont]
                                             constrainedToSize:CGSizeMake(100., CGFLOAT_MAX)
                                                 lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect newCustomLayerFrame = CGRectMake(sz.width-textSize.width+PTN_EXPLABEL_KX, sz.height-textSize.height+PTN_EXPLABEL_KY, textSize.width, textSize.height);
    self.customLayer.frame = newCustomLayerFrame;    
}
@end
