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
#import <UIColor+FlatColors.h>


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
    self.selectedView.alpha = 0.6;
}

- (void)unLightSelectedView {
    self.selectedView.alpha = 1.0;
}

- (void)createFigure {
    CGPoint figurePosition = self.view.center;
    CGSize figureSize = CGSizeMake(100, 100);
    CRFigure *figure = [[CRSquare alloc]initWithPosition:figurePosition size:figureSize andColor:[UIColor redColor]];
    
    [self unLightSelectedView];
    self.selectedView = [self createViewWithFigure:figure];
    [self addPinchGestureToSelectedView];
    [self lightSelectedView];
}

- (UIView *)createViewWithFigure:(CRFigure *)figure {
    CGRect figureFrame = CGRectMake(figure.position.x, figure.position.y, figure.size.width, figure.size.height);
    CRCustomFigureView *figureView = [[CRCustomFigureView alloc] initWithFrame:figureFrame];
    figureView.backgroundColor = figure.color;
    return figureView;
}

- (UITextView *)textViewForFigure:(CGSize)figureSize {
    CGRect textFrame = CGRectMake(0, 0, figureSize.width, figureSize.height);
    UITextView *figureTextView = [[UITextView alloc] initWithFrame:CGRectInset(textFrame, 10, 20)];
    figureTextView.editable = YES;
    figureTextView.backgroundColor = [UIColor whiteColor];
    NSLog(@"TextView: %@", NSStringFromCGRect(figureTextView.frame));
    return figureTextView;
}


#pragma mark - IBAction Methods

- (IBAction)addFigureToViewPressed:(UIBarButtonItem *)sender {
    [self createFigure];
    [self.view addSubview:self.selectedView];
}

- (IBAction)changeColorOfSelectedView:(UIButton *)sender {
    if ([[sender currentTitle]isEqualToString:@"Red"]) {
        self.selectedView.backgroundColor = [UIColor flatAmethystColor];
    }else {
        self.selectedView.backgroundColor = [UIColor flatCarrotColor];
    }
}

- (IBAction)zoomSteepedPressed:(UIStepper *)sender {
    static float initialDifferenceZoom = 0.0;
    static float oldScaleZoom = 1.0;
    
    CGFloat scale = oldScaleZoom - (oldScaleZoom - sender.value) + initialDifferenceZoom;
    self.view.transform = CGAffineTransformScale(self.view.transform, scale, scale);
    oldScaleZoom = scale;
}

- (IBAction)addTextViewToSelectedFigure:(UIButton *)sender {
    [self.selectedView addSubview:[self textViewForFigure:self.selectedView.frame.size]];
}

- (IBAction)removeSelectedView:(UIButton *)sender {
    [self.selectedView removeFromSuperview];
}

#pragma mark - Touch Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    if ([touches count] == 1) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self.view];
        //        self.currentTouch = touchPoint;
        
        for (CRCustomFigureView *view in [self.view subviews]) {
            if (CGRectContainsPoint(view.frame, touchPoint)) {
                [self unLightSelectedView];
                self.selectedView = view;
                [self lightSelectedView];
                return;
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.currentTouch = [touch locationInView:self.view];
    self.selectedView.center = self.currentTouch;
    //    for (CRCustomFigureView *view in [self.view subviews]) {
    //        if ([self.selectedView isEqual:view]) {
    //            CGPoint selectPoint = [touch locationInView:view];
    //            self.selectedView.center = selectPoint;
    //        }
    //    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.currentTouch = [touch locationInView:self.view];
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
