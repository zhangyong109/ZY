//
//  ZYScrollViewController.m
//  ZYScrollViewController
//
//  Created by ZY on 15/9/24.
//  Copyright © 2015年 ZY. All rights reserved.
//

#import "ZYScrollViewController.h"

@implementation ZYScrollViewController

//http://www.wtoutiao.com/p/I35S1d.html
//http://ios.jobbole.com/82637/



#pragma mark - life cycle
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self addScrollView];
    [self addContentView];
    [self addViewSubViewConstraints];
    [self addContentSubViews];
}

#pragma mark - UI
- (void)addScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.scrollView];
}

- (void)addContentView {
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor magentaColor];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.contentView];
}

- (void)addViewSubViewConstraints {
    NSDictionary *tmpViewsDictionary = @{
                                         @"scrollView":self.scrollView,
                                         @"contentView":self.contentView
                                         };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[scrollView]-(0)-|" options:0 metrics:nil views:tmpViewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[scrollView]-(0)-|" options:0 metrics:nil views:tmpViewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[contentView]-(0)-|" options:0 metrics:nil views:tmpViewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[contentView]-(0)-|" options:0 metrics:nil views:tmpViewsDictionary]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0
                              ]
     ];
}

- (void)addContentSubViews {
    self.topLabel = [[UILabel alloc] init];
    self.topLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.topLabel.numberOfLines = 0;
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    self.topLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.topLabel.text = @"顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶";
    self.topLabel.textColor = [UIColor blackColor];
    self.topLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.topLabel];
    
    self.boxView = [[UIView alloc] init];
    self.boxView.translatesAutoresizingMaskIntoConstraints = NO;
    self.boxView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.boxView];
    
    self.bottomLabel = [[UILabel alloc] init];
    self.bottomLabel.numberOfLines = 0;
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bottomLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomLabel.text = [self bottomLabelText];
    self.bottomLabel.textColor = [UIColor blackColor];
    self.bottomLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.bottomLabel];
    
    [self addContentSubViewConstraints];
}

- (NSString *)bottomLabelText {
    return @"顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶";
}

- (void)addContentSubViewConstraints {
    NSDictionary *tmpViewsDictionary = @{
                                         @"topLabel":self.topLabel,
                                         @"boxView":self.boxView,
                                         @"bottomLabel":self.bottomLabel
                                         };
    NSDictionary *metrics = @{
                              @"space":@30,
                              
                              };
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(space)-[topLabel]-[boxView(186)]-space-[bottomLabel]-space-|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:tmpViewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[topLabel]-|" options:0 metrics:nil views:tmpViewsDictionary]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[bottomLabel]-|" options:0 metrics:nil views:tmpViewsDictionary]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[boxView]-|" options:0 metrics:nil views:tmpViewsDictionary]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.boxView
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1
                                                                  constant:0
                                     ]
     ];
    
}
@end
