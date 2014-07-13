//
//  CRCircleFigureView.m
//  ConceptualMap
//
//  Created by Carlos Roig Salvador on 13/07/14.
//  Copyright (c) 2014 CRoigSalvador. All rights reserved.
//

#import "CRCircleFigureView.h"

@implementation CRCircleFigureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 //// Color Declarations
    UIColor* color2 = [UIColor colorWithRed: 0.959 green: 0 blue: 0 alpha: 1];
 
 //// Oval Drawing
 UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: self.bounds];
 [color2 setFill];
 [ovalPath fill];
 
}


@end
