//
//  CRBezierPath.m
//  ConceptualMap
//
//  Created by Carlos Roig Salvador on 07/07/14.
//  Copyright (c) 2014 CRoigSalvador. All rights reserved.
//

#import "CRBezierPath.h"

@implementation CRBezierPath

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setPath:(UIBezierPath *)path {
    _path = path;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self.path stroke];
}


@end
