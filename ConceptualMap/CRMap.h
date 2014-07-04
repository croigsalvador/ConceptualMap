//
//  CRMap.h
//  ConceptualMap
//
//  Created by Carlos Roig Salvador on 04/07/14.
//  Copyright (c) 2014 CRoigSalvador. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CRFigure;

@interface CRMap : NSObject

@property (nonatomic, copy) NSString *mapName;

- (void)addFigure:(CRFigure *)figure;
- (void)removeFigure:(CRFigure *)figure;
- (NSArray *)figures;

@end
