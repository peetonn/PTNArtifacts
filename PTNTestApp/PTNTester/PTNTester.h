//
//  PTNTester.h
//  PTNTester
//
//  Created by Peter Gusev on 9/12/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <PTNArtifacts/PTNArtifacts.h>

@interface PTNTester : SenTestCase<PTNExpandableLabelDelegate, UIAlertViewDelegate>
{
    UIView *stub;
}
@end
