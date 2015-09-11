//
//  PXView.m
//  PXCoalescedRunner
//
//  Created by Spencer Phippen on 2015/09/11.
//  Copyright (c) 2015年 Spencer Phippen. All rights reserved.
//

#import "PXView.h"

@implementation PXView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self)
        return nil;
    
    _button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button1 setTitle:@"Start timer (block)" forState:UIControlStateNormal];

    _button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button2 setTitle:@"Start time (C function + context)" forState:UIControlStateNormal];

    _button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button3 setTitle:@"Start time (target + selector)" forState:UIControlStateNormal];
    
    [self addSubview:_button1];
    [self addSubview:_button2];
    [self addSubview:_button3];
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    return self;
}

- (void) layoutSubviews {
    const CGRect entireArea = [self bounds];
    
    CGRect button1Frame = CGRectZero;
    CGRect button2Frame = CGRectZero;
    CGRect button3Frame = CGRectZero;
    
    CGFloat buttonHeight = ceil(entireArea.size.height / 3.0);
    
    CGRect workingArea = entireArea;
    CGRectDivide(workingArea, &button1Frame, &workingArea, buttonHeight, CGRectMinYEdge);
    CGRectDivide(workingArea, &button2Frame, &button3Frame, buttonHeight, CGRectMinYEdge);
    
    [_button1 setFrame:button1Frame];
    [_button2 setFrame:button2Frame];
    [_button3 setFrame:button3Frame];
}

@end
