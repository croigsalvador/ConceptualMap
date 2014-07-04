//
//  CRMapWorkSapceViewController.m
//  ConceptualMap
//
//  Created by Carlos Roig Salvador on 04/07/14.
//  Copyright (c) 2014 CRoigSalvador. All rights reserved.
//

#import "CRMapWorkSapceViewController.h"
#import "CRCircle.h"
#import "CRSquare.h"
//#import "CRFigure.h"
#import "CRCustomFigureView.h"

@interface CRMapWorkSapceViewController ()
@property (nonatomic, assign) CGPoint currentTouch;
@property (nonatomic, strong) UIView *selectedView;
@end

@implementation CRMapWorkSapceViewController

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - IBAction Methods

- (IBAction)addFigureToViewPressed:(UIBarButtonItem *)sender {
    CRFigure *figure = [[CRSquare alloc]init];
    
    CGRect figureFrame = CGRectMake(figure.position.x, figure.position.y, figure.size.width, figure.size.height);
    
    CRCustomFigureView *figureView = [[CRCustomFigureView alloc] initWithFrame:figureFrame];
    figureView.backgroundColor = figure.color;
    self.selectedView = figureView;
    [self.view addSubview:self.selectedView];
}

- (IBAction)changeColorOfSelectedView:(UIButton *)sender {
    if ([[sender currentTitle]isEqualToString:@"Red"]) {
        self.selectedView.backgroundColor = [UIColor blueColor];
    }else {
        self.selectedView.backgroundColor = [UIColor orangeColor];
    }
}

#pragma mark - Touches Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self.view];
        self.currentTouch = touchPoint;
        
        for (UIView *view in [self.view subviews]) {
            if (CGRectContainsPoint(view.frame, touchPoint)) {
                self.selectedView = view;
                return;
            }
        }
        // Draw a red circle where the touch occurred
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.currentTouch = [touch locationInView:self.view];
    self.selectedView.center = self.currentTouch;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.currentTouch = [touch locationInView:self.view];
    self.selectedView.center = self.currentTouch;
}


@end
