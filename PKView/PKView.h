//
//  PKView.h
//  PKView
//
//  Created by Fancy on 2021/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PKView : UIView

@property (nonatomic, strong) CAShapeLayer *leftLayer;
@property (nonatomic, strong) CAShapeLayer *rightLayer;
@property (nonatomic, assign) CGFloat progress;
//default 3
@property (nonatomic, assign) CGFloat space;
//default 75°
@property (nonatomic, assign) CGFloat angle;

- (void)animate;

@end

@interface PKView (PKViewSubclassingHooks)
 
- (void)didInitialize NS_REQUIRES_SUPER;

@end


NS_ASSUME_NONNULL_END
