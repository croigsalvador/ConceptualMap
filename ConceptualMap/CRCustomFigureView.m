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
        [self setupTextLabels];
    }
    return self;
}

- (void)setupTextLabels {
    CGRect labelFrame = CGRectMake(20, 45, self.bounds.size.width - 20, 15);
    self.titleLabel = [[UILabel alloc] initWithFrame:labelFrame];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font =  [UIFont systemFontOfSize:14];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"Pruena de Label";
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    labelFrame.origin.y = CGRectGetMaxY(self.titleLabel.frame) + 20;

    self.textLabel = [[UILabel alloc] initWithFrame:labelFrame];
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font =  [UIFont systemFontOfSize:14];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.text = @"Pruena de texto";
    self.textLabel.numberOfLines = 0;
    [self addSubview:self.textLabel];
}


@end
