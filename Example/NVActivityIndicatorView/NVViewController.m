//
//  NVViewController.m
//  NVActivityIndicatorView
//
//  Created by maitrungduc1410 on 06/24/2025.
//  Copyright (c) 2025 maitrungduc1410. All rights reserved.
//

#import "NVViewController.h"
#import "NVActivityIndicatorView.h"

@interface NVViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray<NSString *> *animationNames;
@property (nonatomic, strong) NSArray<NSNumber *> *animationTypes;
@property (nonatomic, strong) UISlider *speedSlider;
@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) NSMutableArray<NVActivityIndicatorView *> *activeIndicators;

@end

@implementation NVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"NVActivityIndicatorView Demo";
    self.view.backgroundColor = [UIColor colorWithRed:0.929 green:0.333 blue:0.396 alpha:1.0]; // #ed5565
    
    self.activeIndicators = [[NSMutableArray alloc] init];
    
    [self setupAnimationData];
    [self setupSpeedControls];
    [self setupScrollView];
    [self createAnimationGrid];
}

- (void)setupSpeedControls {
    // Create speed control container
    UIView *speedContainer = [[UIView alloc] init];
    speedContainer.backgroundColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.3 alpha:0.9];
    speedContainer.layer.cornerRadius = 8;
    speedContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:speedContainer];
    
    // Create speed label
    self.speedLabel = [[UILabel alloc] init];
    self.speedLabel.text = @"Speed: 1.0x";
    self.speedLabel.textColor = [UIColor whiteColor];
    self.speedLabel.font = [UIFont boldSystemFontOfSize:16];
    self.speedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [speedContainer addSubview:self.speedLabel];
    
    // Create speed slider
    self.speedSlider = [[UISlider alloc] init];
    self.speedSlider.minimumValue = 0.1;
    self.speedSlider.maximumValue = 3.0;
    self.speedSlider.value = 1.0;
    self.speedSlider.tintColor = [UIColor whiteColor];
    [self.speedSlider addTarget:self action:@selector(speedChanged:) forControlEvents:UIControlEventValueChanged];
    self.speedSlider.translatesAutoresizingMaskIntoConstraints = NO;
    [speedContainer addSubview:self.speedSlider];
    
    // Add constraints
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [speedContainer.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10],
            [speedContainer.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
            [speedContainer.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
            [speedContainer.heightAnchor constraintEqualToConstant:80],
            
            [self.speedLabel.topAnchor constraintEqualToAnchor:speedContainer.topAnchor constant:10],
            [self.speedLabel.centerXAnchor constraintEqualToAnchor:speedContainer.centerXAnchor],
            
            [self.speedSlider.topAnchor constraintEqualToAnchor:self.speedLabel.bottomAnchor constant:5],
            [self.speedSlider.leadingAnchor constraintEqualToAnchor:speedContainer.leadingAnchor constant:20],
            [self.speedSlider.trailingAnchor constraintEqualToAnchor:speedContainer.trailingAnchor constant:-20],
            [self.speedSlider.bottomAnchor constraintEqualToAnchor:speedContainer.bottomAnchor constant:-10]
        ]];
    }
}

- (void)speedChanged:(UISlider *)slider {
    CGFloat speed = slider.value;
    self.speedLabel.text = [NSString stringWithFormat:@"Speed: %.1fx", speed];
    
    // Update all active indicators
    for (NVActivityIndicatorView *indicator in self.activeIndicators) {
        indicator.animationSpeedMultiplier = speed;
    }
}

- (void)setupAnimationData {
    self.animationNames = @[
        @"Ball Pulse",                      // 1
        @"Ball Grid Pulse",                 // 2
        @"Ball Clip Rotate",                // 3
        @"Square Spin",                     // 4
        @"Ball Clip Rotate Pulse",          // 5
        @"Ball Clip Rotate Multiple",       // 6
        @"Ball Pulse Rise",                 // 7
        @"Ball Rotate",                     // 8
        @"Cube Transition",                 // 9
        @"Ball Zig Zag",                    // 10
        @"Ball Zig Zag Deflect",            // 11
        @"Ball Triangle Path",              // 12
        @"Ball Scale",                      // 13
        @"Line Scale",                      // 14
        @"Line Scale Party",                // 15
        @"Ball Scale Multiple",             // 16
        @"Ball Pulse Sync",                 // 17
        @"Ball Beat",                       // 18
        @"Line Scale Pulse Out",            // 19
        @"Line Scale Pulse Out Rapid",     // 20
        @"Ball Scale Ripple",               // 21
        @"Ball Scale Ripple Multiple",     // 22
        @"Ball Spin Fade Loader",          // 23
        @"Line Spin Fade Loader",          // 24
        @"Triangle Skew Spin",              // 25
        @"Pacman",                          // 26
        @"Ball Grid Beat",                  // 27
        @"Semi Circle Spin",                // 28
        @"Ball Rotate Chase",               // 29
        @"Orbit",                           // 30
        @"Audio Equalizer",                 // 31
        @"Circle Stroke Spin",              // 32
        @"Ball Double Bounce"               // 33
    ];
    
    self.animationTypes = @[
        @(NVActivityIndicatorTypeBallPulse),                    // 1
        @(NVActivityIndicatorTypeBallGridPulse),                // 2
        @(NVActivityIndicatorTypeBallClipRotate),               // 3
        @(NVActivityIndicatorTypeSquareSpin),                   // 4
        @(NVActivityIndicatorTypeBallClipRotatePulse),          // 5
        @(NVActivityIndicatorTypeBallClipRotateMultiple),       // 6
        @(NVActivityIndicatorTypeBallPulseRise),                // 7
        @(NVActivityIndicatorTypeBallRotate),                   // 8
        @(NVActivityIndicatorTypeCubeTransition),               // 9
        @(NVActivityIndicatorTypeBallZigZag),                   // 10
        @(NVActivityIndicatorTypeBallZigZagDeflect),            // 11
        @(NVActivityIndicatorTypeBallTrianglePath),             // 12
        @(NVActivityIndicatorTypeBallScale),                    // 13
        @(NVActivityIndicatorTypeLineScale),                    // 14
        @(NVActivityIndicatorTypeLineScaleParty),               // 15
        @(NVActivityIndicatorTypeBallScaleMultiple),            // 16
        @(NVActivityIndicatorTypeBallPulseSync),                // 17
        @(NVActivityIndicatorTypeBallBeat),                     // 18
        @(NVActivityIndicatorTypeLineScalePulseOut),            // 19
        @(NVActivityIndicatorTypeLineScalePulseOutRapid),       // 20
        @(NVActivityIndicatorTypeBallScaleRipple),              // 21
        @(NVActivityIndicatorTypeBallScaleRippleMultiple),      // 22
        @(NVActivityIndicatorTypeBallSpinFadeLoader),           // 23
        @(NVActivityIndicatorTypeLineSpinFadeLoader),           // 24
        @(NVActivityIndicatorTypeTriangleSkewSpin),             // 25
        @(NVActivityIndicatorTypePacman),                       // 26
        @(NVActivityIndicatorTypeBallGridBeat),                 // 27
        @(NVActivityIndicatorTypeSemiCircleSpin),               // 28
        @(NVActivityIndicatorTypeBallRotateChase),              // 29
        @(NVActivityIndicatorTypeOrbit),                        // 30
        @(NVActivityIndicatorTypeAudioEqualizer),               // 31
        @(NVActivityIndicatorTypeCircleStrokeSpin),             // 32
        @(NVActivityIndicatorTypeBallDoubleBounce)              // 33
    ];
}

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.929 green:0.333 blue:0.396 alpha:1.0]; // #ed5565
    [self.view addSubview:self.scrollView];
    
    // Add constraints for scroll view (with top margin for speed controls)
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:100], // 100pt for speed controls
            [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
            [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
            [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
        ]];
    } else {
        // Fallback on earlier versions
    }
}

- (void)createAnimationGrid {
    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
    CGFloat spacing = 10;
    NSInteger columns = 4; // Fixed to 4 items per row
    
    // Calculate item width based on screen width to fit exactly 4 items
    // Formula: screenWidth = (spacing) + 4 * itemWidth + 3 * spacing + (spacing)
    // screenWidth = 2 * spacing + 4 * itemWidth + 3 * spacing = 5 * spacing + 4 * itemWidth
    CGFloat itemWidth = (screenWidth - (5 * spacing)) / 4;
    CGFloat itemHeight = itemWidth + 40; // Add extra height for label
    
    NSInteger rows = (NSInteger)ceil((double)self.animationNames.count / columns);
    
    
    for (NSInteger i = 0; i < self.animationNames.count; i++) {
        NSInteger row = i / columns;
        NSInteger col = i % columns;
        
        CGFloat x = spacing + col * (itemWidth + spacing);
        CGFloat y = spacing + row * (itemHeight + spacing);
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeight)];
        containerView.backgroundColor = [UIColor clearColor]; // No background
        
        // Create activity indicator - centered in the container with responsive size
        CGFloat indicatorSize = MIN(itemWidth * 0.6, 60); // 60% of item width, max 60px
        CGFloat indicatorX = (itemWidth - indicatorSize) / 2;
        CGFloat indicatorY = 10;
        
        NVActivityIndicatorType type = [self.animationTypes[i] integerValue];
        NVActivityIndicatorView *activityIndicator = [[NVActivityIndicatorView alloc]
            initWithFrame:CGRectMake(indicatorX, indicatorY, indicatorSize, indicatorSize)
                     type:type 
                    color:[UIColor whiteColor]]; // White color
        
        // Set initial speed multiplier
        activityIndicator.animationSpeedMultiplier = self.speedSlider.value;
        
        // Track this indicator for speed updates
        [self.activeIndicators addObject:activityIndicator];
        
        [containerView addSubview:activityIndicator];
        
        // Create label - positioned below the indicator
        CGFloat labelY = indicatorY + indicatorSize + 5;
        CGFloat labelHeight = itemHeight - labelY - 5;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, labelY, itemWidth - 4, labelHeight)];
        label.text = [NSString stringWithFormat:@"%ld. %@", (long)(i + 1), self.animationNames[i]]; // Start numbering from 1
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.numberOfLines = 3;
        label.textColor = [UIColor whiteColor]; // White text for better visibility on red background
        
        [containerView addSubview:label];
        [self.scrollView addSubview:containerView];
    }
    
    // Set content size for scroll view
    CGFloat contentHeight = spacing + rows * (itemHeight + spacing);
    self.scrollView.contentSize = CGSizeMake(screenWidth, contentHeight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
