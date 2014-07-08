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
#import "CRCustomFigureView.h"

@interface CRMapWorkSapceViewController ()<UIDynamicAnimatorDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGPoint currentTouch;
@property (nonatomic, strong) UIView *selectedView;

@end

@implementation CRMapWorkSapceViewController {
    CGPoint lastTouchPosition;
}

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Private Methods

- (void)addPinchGestureToSelectedView {
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handlePinchGesture:)];
    [pinchGesture setDelegate:self];
    [self.selectedView addGestureRecognizer:pinchGesture];
}

- (void)lightSelectedView {
    self.selectedView.alpha = 0.5;
}

- (void)unLightSelectedView {
    self.selectedView.alpha = 1.0;
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
        self.selectedView.backgroundColor = [UIColor flatAmethystColor];
    }else {
        self.selectedView.backgroundColor = [UIColor flatCarrotColor];
    }
}

#pragma mark - Touch Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self.view];
        self.currentTouch = touchPoint;
        
        for (UIView *view in [self.view subviews]) {
            if ([view isKindOfClass:[CRCustomFigureView class]]) {
                if (CGRectContainsPoint(view.frame, touchPoint)) {
                    [self unLightSelectedView];
                    self.selectedView = view;
                    [self lightSelectedView];
                    return;
                }
            }
        }
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

#pragma mark - Transform Views 

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer {
    
    static float initialDifference = 0.0;
    static float oldScale = 1.0;
    
    if (recognizer.state == UIGestureRecognizerStateBegan){
        initialDifference = oldScale - recognizer.scale;
    }
    
    CGFloat scale = oldScale - (oldScale - recognizer.scale) + initialDifference;
    
    self.selectedView.transform = CGAffineTransformScale(self.view.transform, scale, scale);
    
    oldScale = scale;
    
}










@end
