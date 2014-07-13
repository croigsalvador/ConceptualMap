//
//  CRCustomFigureView.m
//  ConceptualMap
//
//  Created by Carlos Roig Salvador on 04/07/14.
//  Copyright (c) 2014 CRoigSalvador. All rights reserved.
//

#import "CRCustomFigureView.h"

@interface CRCustomFigureView ()

@property (nonatomic, assign) CGPoint currentTouch;
@property (nonatomic, strong) UIView *dragView;

@end

@implementation CRCustomFigureView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


@end
