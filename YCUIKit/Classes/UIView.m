//
//  UIView.m
//  ting_macOS
//
//  Created by cube on 2017/1/9.
//  Copyright © 2017年 cube. All rights reserved.
//

#import "UIView.h"
#import <objc/objc-runtime.h>
#import <QuartzCore/QuartzCore.h>

#ifndef NSAppKitVersionNumber10_13
#define NSAppKitVersionNumber10_13 1561
#endif

@implementation NSScreen (YCUIKit)

- (CGFloat)scale
{
    return self.backingScaleFactor;
}

+ (CGFloat)scale
{
    return [NSScreen mainScreen].backingScaleFactor;
}

@end

@implementation NSValue (YCUIKit)

- (CGRect)CGRectValue
{
    return NSRectToCGRect(self.rectValue);
}

+ (NSValue *)valueWithCGRect:(CGRect)rect
{
    return [self valueWithRect:NSRectFromCGRect(rect)];
}

@end

@interface UIView () <NSWindowDelegate>

@end

@implementation UIView

- (void)setContentCompressionResistancePriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis
{
    
}

+ (void)transitionWithView:(__kindof NSView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion
{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = duration;
        if (animations){
            animations();
        }
    } completionHandler:^{
        if (completion){
            completion(YES);
        }
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self){
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self){
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.window.delegate = self;
    self.wantsLayer = YES;
    self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidResize:) name:NSWindowDidResizeNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setNeedsDisplay
{
    [self.layer setNeedsDisplay];
}

- (void)bringSubviewToFront:(NSView *)view
{
    NSView *superview = [view superview];
    [view removeFromSuperview];
    [superview addSubview:view];
}

- (BOOL)isFlipped
{
    return YES;
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    if ([self.viewDelegate respondsToSelector:@selector(uiview:viewDidHidden:)]){
        [self.viewDelegate uiview:self viewDidHidden:hidden];
    }
}

- (void)setFrame:(NSRect)frame
{
    [super setFrame:frame];
    if ([self.viewDelegate respondsToSelector:@selector(uiviewDidLayout:)]){
        [self.viewDelegate uiviewDidLayout:self];
    }
}

- (void)layout
{
    [super layout];
    
    if ([self.viewDelegate respondsToSelector:@selector(uiviewDidLayout:)]){
        [self.viewDelegate uiviewDidLayout:self];
    }
}

- (void)windowDidResize:(NSNotification *)notification
{
    if ([self.viewDelegate respondsToSelector:@selector(uiviewDidLayout:)]){
        [self.viewDelegate uiviewDidLayout:self];
    }
}

- (void)layoutSubviews
{
    
}

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations
{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = duration;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        if (animations){
            animations();
        }
    } completionHandler:^{
        
    }];
}

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion
{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = duration;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        if (animations){
            animations();
        }
    } completionHandler:^{
        if (completion){
            completion(YES);
        }
    }];
}

+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion
{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = duration;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        if (animations){
            animations();
        }
    } completionHandler:^{
        if (completion){
            completion(YES);
        }
    }];
}

+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion
{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = duration;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        if (animations){
            animations();
        }
    } completionHandler:^{
        if (completion){
            completion(YES);
        }
    }];
}

+ (void)animateKeyframesWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewKeyframeAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion
{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = duration;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        if (animations){
            animations();
        }
    } completionHandler:^{
        if (completion){
            completion(YES);
        }
    }];
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    if (floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_13) {
        if (self.backgroundColor){
            CGContextRef ctx = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
            [self.backgroundColor setFill];
            CGContextFillRect(ctx, self.bounds);
        }
    }
}

@end

@implementation UIGestureRecognizer

@end

@implementation UITapGestureRecognizer

@end

@implementation NSView (UIKitExtension)

- (NSColor *)backgroundColor
{
    return objc_getAssociatedObject(self, @selector(backgroundColor));
}

- (void)setBackgroundColor:(NSColor *)backgroundColor
{
    objc_setAssociatedObject(self, @selector(backgroundColor), backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_13){
        
    }else{
        self.layer.backgroundColor = backgroundColor.CGColor;
    }
}

#pragma mark 重写x
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}

#pragma mark 重写y
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}

#pragma mark 重写width
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width
{
    return self.frame.size.width;
}

#pragma mark 重写height
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height
{
    return self.frame.size.height;
}

#pragma mark 重写centerX
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.layer.position;
    center.x = centerX;
    self.layer.position = center;
}
- (CGFloat)centerX
{
    return self.layer.position.x;
}

#pragma mark 重写centerY
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.layer.position;
    center.y = centerY;
    self.layer.position = center;
}
- (CGFloat)centerY
{
    return self.layer.position.y;
}

#pragma mark 重写size
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}

#pragma mark 重写point
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setCenter:(CGPoint)center
{
    
}

- (CGPoint)center
{
    return CGPointMake((self.frame.origin.x + (self.frame.size.width / 2)), (self.frame.origin.y + (self.frame.size.height / 2)));
}

- (CGFloat)alpha
{
    return self.alphaValue;
}

- (void)setAlpha:(CGFloat)alpha
{
    self.alphaValue = alpha;
}

@end
