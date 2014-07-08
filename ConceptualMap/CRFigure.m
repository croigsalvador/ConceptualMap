//
//  CRFigure.m
//  ConceptualMap
//
//  Created by Carlos Roig Salvador on 04/07/14.
//  Copyright (c) 2014 CRoigSalvador. All rights reserved.
//

#import "CRFigure.h"

static CGPoint  const kDefaultPosition            = { 200.0f, 200.0f };
static CGSize   const kDefaultSize                = { 150.0f, 60.0f };

@implementation CRFigure

#pragma mark - Initializer Methods

- (instancetype)init {
    return [self initWithPosition:kDefaultPosition size:kDefaultSize andColor:[UIColor redColor]];
}

// Designated Initializer
- (instancetype)initWithPosition:(CGPoint)position size:(CGSize)size andColor:(UIColor *)color {
    if (self = [super init]){
        _position = position;
        _size = size;
        _color = color;
    }
    return self;
}

#pragma mark - Custom Getters

- (NSUInteger)numberOfSides {
    [NSException raise:NSInternalInconsistencyException
				format:@"%@: Subclasses must override this method and provide the number of sides", NSStringFromSelector(_cmd)];
    
    return 0;
}


@end
