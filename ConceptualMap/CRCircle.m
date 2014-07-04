//
//  CRCircle.m
//  ConceptualMap
//
//  Created by Carlos Roig Salvador on 04/07/14.
//  Copyright (c) 2014 CRoigSalvador. All rights reserved.
//

#import "CRCircle.h"

static CGFloat kDefaultCircleRadio                  = 50.0f;

@implementation CRCircle

#pragma mark - Custom Getters

- (NSUInteger)numberOfSides {
    return 4;
}

- (CGFloat)radio {
    return kDefaultCircleRadio;
}

@end
