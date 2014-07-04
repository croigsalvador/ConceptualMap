//
//  CRMap.m
//  ConceptualMap
//
//  Created by Carlos Roig Salvador on 04/07/14.
//  Copyright (c) 2014 CRoigSalvador. All rights reserved.
//

#import "CRMap.h"
#import "CRFigure.h"

@interface CRMap ()

@property (nonatomic, copy) NSMutableArray *figuresMutable;

@end

@implementation CRMap

#pragma mark - Custom Getters

- (NSMutableArray *)figuresMutable {
    if (!_figuresMutable) {
        _figuresMutable = [[NSMutableArray alloc]init];
    }
    return _figuresMutable;
}

#pragma mark - Public Methods

- (void)addFigure:(CRFigure *)figure {
    [self.figuresMutable addObject:figure];
}

- (void)removeFigure:(CRFigure *)figure {
    [self.figuresMutable removeObject:figure];
}

- (NSArray *)figures {
    return [self.figures copy];
}

@end
