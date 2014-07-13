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
#import <UIColor+FlatColors.h>
#import "CRCircleFigureView.h"

static CGSize kScrollViewContainerSize                  = {2040.0f, 2040.0f};

@interface CRMapWorkSapceViewController ()<UIDynamicAnimatorDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (nonatomic, assign) CGPoint currentTouch;
@property (nonatomic, strong) UIView *selectedView;

@property (strong,nonatomic) UIView *containerView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation CRMapWorkSapceViewController {
    CGPoint lastTouchPosition;
}

#pragma mark - ViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Set up the container view to hold our custom view hierarchy
    [self setupScrollView];
    [self setupContainerView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
    [self centerScrollViewContents];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.scrollView = nil;
    self.containerView = nil;
}


#pragma mark - Setting up UIElements
- (void)setupContainerView {
    self.containerView = [[UIView alloc] initWithFrame:(CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=kScrollViewContainerSize}];
    self.containerView.backgroundColor = [UIColor blueColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.containerView addGestureRecognizer:tapGesture];
    [self.scrollView addSubview:self.containerView];
}

- (void)setupScrollView {
    self.scrollView.contentSize = kScrollViewContainerSize;
}

#pragma mark - Resizing

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.containerView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.containerView.frame = contentsFrame;
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
    CGSize figureSize = CGSizeMake(200, 200);
    CRFigure *figure = [[CRSquare alloc]initWithPosition:figurePosition size:figureSize andColor:[UIColor redColor]];
    
    [self unLightSelectedView];
    self.selectedView = [self createViewWithFigure:figure];
    [self addPinchGestureToSelectedView];
    [self lightSelectedView];
}

- (UIView *)createViewWithFigure:(CRFigure *)figure {
    CGRect figureFrame = CGRectMake(figure.position.x, figure.position.y, figure.size.width, figure.size.height);
    CRCustomFigureView *figureView = [[CRCircleFigureView alloc] initWithFrame:figureFrame];
//    figureView.backgroundColor = figure.color;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [figureView addGestureRecognizer:panGesture];
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
    [self.containerView addSubview:self.selectedView];
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
    [self.containerView endEditing:YES];
}

#pragma mark - Gesture Methods

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


- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
    self.selectedView = recognizer.view;
    CGPoint center = [recognizer locationInView:self.containerView];
    self.selectedView.center = center;
}

- (void)handleTapGesture:(UITapGestureRecognizer *) recognizer {
    [self.view endEditing:YES];
}

#pragma mark - UIScrollViewDelegate

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}











@end
