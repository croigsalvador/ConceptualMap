//
//  CRFigure.h
//  ConceptualMap
//
//  Created by Carlos Roig Salvador on 04/07/14.
//  Copyright (c) 2014 CRoigSalvador. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRFigureProtocol.h"

@interface CRFigure : NSObject <CRFigureProtocol>

@property (assign,nonatomic) CGPoint position;
@property (assign,nonatomic) CGSize size;
@property (strong, nonatomic) UIColor *color;

@end
