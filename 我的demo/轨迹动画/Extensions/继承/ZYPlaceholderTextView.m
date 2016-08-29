//
//  ZYPlaceholderTextView.m
//  ZYPlaceholderTextView
//
//  Created by ZY on 16/8/13.
//  Copyright © 2016年 scorpio. All rights reserved.
//

#import "ZYPlaceholderTextView.h"

static CGFloat const ZYPlaceholderLabelX = 6.0;
static CGFloat const ZYPlaceholderLabelY = 7.0;
#define ZYPlaceholderLabelW self.frame.size.width - 2 * ZYPlaceholderLabelX

@interface ZYPlaceholderTextView()

/** 
 占位文字label 
 */
@property (nonatomic, strong)UILabel *placeholderLabel;

@end

@implementation ZYPlaceholderTextView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 设置默认字体
        self.font = [UIFont systemFontOfSize:17];
        // 设置默认的占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        // 监听文字
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeNotification) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

#pragma mark -
- (void)textDidChangeNotification {
    // 有文字就隐藏占位文字
    self.placeholderLabel.hidden = self.hasText;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 更新占位文字的frame
    self.placeholderLabel.frame = CGRectMake(ZYPlaceholderLabelX, ZYPlaceholderLabelY, ZYPlaceholderLabelW, 0);
    [self.placeholderLabel sizeToFit];
}

#pragma mark - setter/getter
- (UILabel *)placeholderLabel {
    if (_placeholderLabel == nil) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textDidChangeNotification];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self textDidChangeNotification];
}

#pragma mark -
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
