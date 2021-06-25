//
//  PKView.m
//  PKView
//
//  Created by Fancy on 2021/6/25.
//

#import "PKView.h"

#define AngleWithDegrees(deg) (M_PI * (deg) / 180.0)

@interface PKView () <CAAnimationDelegate>

@end

@implementation PKView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self didInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self didInit];
    }
    return self;
}
 
- (void)didInit {
    _space = 3;
    _angle = 75;
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    [self.layer addSublayer:self.leftLayer];
    [self.layer addSublayer:self.rightLayer];
    
    [self didInitialize];
}
 
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    if (self.progress) {
        CGFloat leftRate = self.progress;
        CGFloat rightRate = 1 - leftRate;
        CGFloat angleWidth = height / tan(AngleWithDegrees(self.angle));
        CGFloat rateWidth = width - self.space;
        
        self.leftLayer.frame = CGRectMake(0, 0, leftRate * rateWidth + angleWidth, height);
        self.rightLayer.frame = CGRectMake(CGRectGetWidth(self.leftLayer.frame) - angleWidth + self.space, 0, rightRate * rateWidth + angleWidth, height);
        
        NSMutableArray *leftPointArray = [NSMutableArray array];
        [leftPointArray addObject:NSStringFromCGPoint(CGPointMake(0, 0))];
        [leftPointArray addObject:NSStringFromCGPoint(CGPointMake(CGRectGetWidth(self.leftLayer.bounds), 0))];
        [leftPointArray addObject:NSStringFromCGPoint(CGPointMake(CGRectGetWidth(self.leftLayer.bounds) - angleWidth, height))];
        [leftPointArray addObject:NSStringFromCGPoint(CGPointMake(0, height))];
        CAShapeLayer *leftMask = [CAShapeLayer layer];
        leftMask.path = [self maskPathWithPoints:leftPointArray].CGPath;
        self.leftLayer.mask = leftMask;
  
        NSMutableArray *rightPointArray = [NSMutableArray array];
        [rightPointArray addObject:NSStringFromCGPoint(CGPointMake(angleWidth, 0))];
        [rightPointArray addObject:NSStringFromCGPoint(CGPointMake(CGRectGetWidth(self.rightLayer.bounds), 0))];
        [rightPointArray addObject:NSStringFromCGPoint(CGPointMake(CGRectGetWidth(self.rightLayer.bounds), height))];
        [rightPointArray addObject:NSStringFromCGPoint(CGPointMake(0, height))];
        CAShapeLayer *rightMask = [CAShapeLayer layer];
        rightMask.path = [self maskPathWithPoints:rightPointArray].CGPath;
        self.rightLayer.mask = rightMask;
    } else {
        self.leftLayer.frame = CGRectZero;
        self.rightLayer.frame = CGRectZero;
    }
}

#pragma mark -- 动画
- (void)animate {
    self.leftLayer.hidden = NO;
    self.rightLayer.hidden = NO;
 
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    [self animateWithLayer:self.leftLayer
              fromPosition:CGPointMake(-CGRectGetWidth(self.leftLayer.bounds) * 0.5, height * 0.5)
                toPosition:CGPointMake(CGRectGetWidth(self.leftLayer.bounds) * 0.5, height * 0.5)];
    
    [self animateWithLayer:self.rightLayer
              fromPosition:CGPointMake(width + CGRectGetWidth(self.rightLayer.bounds) * 0.5, height * 0.5)
                toPosition:CGPointMake(CGRectGetMinX(self.rightLayer.frame) + CGRectGetWidth(self.rightLayer.bounds) * 0.5, height * 0.5)];
}

- (void)animateWithLayer:(CALayer*)layer
            fromPosition:(CGPoint)fromValue
              toPosition:(CGPoint)toValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:fromValue];
    animation.toValue = [NSValue valueWithCGPoint:toValue];
    animation.duration = .4;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate = self;
    [layer addAnimation:animation forKey:nil];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.leftLayer removeAllAnimations];
    [self.rightLayer removeAllAnimations];
}
 
#pragma mark -- Method
- (UIBezierPath*)maskPathWithPoints:(NSArray *)pointArray {
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < pointArray.count; i++) {
        CGPoint retrievedPoint = CGPointFromString(pointArray[i]);
        if (i == 0) {
            [path moveToPoint:retrievedPoint];
        } else {
            [path addLineToPoint:retrievedPoint];
        }
    }
    [path closePath];
    return  path;
}

#pragma mark - Set
- (void)setProgress:(CGFloat)progress {
    if (_progress != progress && progress >= 0 && progress <= 1) {
        _progress = progress;
        [self setNeedsLayout];
    }
}

- (void)setSpace:(CGFloat)space {
    if (_space != space && space >= 0) {
        _space = space;
        [self setNeedsLayout];
    }
}

- (void)setAngle:(CGFloat)angle {
    if (_angle != angle && angle >= 0 && angle <= 360) {
        _angle = angle;
        [self setNeedsLayout];
    }
}

#pragma mark - Get
- (CAShapeLayer *)leftLayer {
    if (!_leftLayer) {
        _leftLayer = [CAShapeLayer layer];
        _leftLayer.backgroundColor = [UIColor blueColor].CGColor;
        _leftLayer.hidden = YES;
    }
    return _leftLayer;
}

- (CAShapeLayer *)rightLayer {
    if (!_rightLayer) {
        _rightLayer = [CAShapeLayer layer];
        _rightLayer.backgroundColor = [UIColor redColor].CGColor;
        _rightLayer.hidden = YES;
    }
    return _rightLayer;
}

@end

@implementation PKView (PKViewSubclassingHooks)

- (void)didInitialize {
    // 子类重写
}

@end
