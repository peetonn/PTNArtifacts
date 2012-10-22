//
//  PTNCoverView.h
//  PTNControls
//
//  Created by Peter Gusev on 8/15/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTNCoverViewDelegate;

@interface PTNCoverView : UIView

@property (nonatomic, weak) IBOutlet id<PTNCoverViewDelegate> delegate;

@end

@protocol PTNCoverViewDelegate <NSObject>

@optional
-(void)coverViewWasTapped:(PTNCoverView*)coverView;

@end