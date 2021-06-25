//
//  PKCustomView.m
//  PKView
//
//  Created by Fancy on 2021/6/25.
//

#import "PKCustomView.h"

@implementation PKCustomView

- (void)didInitialize {
    [super didInitialize];
    
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftLabel.frame = self.leftLayer.frame;
    self.rightLabel.frame = self.rightLayer.frame;
}

#pragma mark - Get
- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rightLabel;
}

@end
