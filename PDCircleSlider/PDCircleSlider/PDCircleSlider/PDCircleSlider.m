//
//  PDCircleSlider.m
//  PDCircleSlider
//
//  Created by ChenGe on 14-3-30.
//  Copyright (c) 2014年 Panda. All rights reserved.
//

#import "PDCircleSlider.h"

#define LINE_WIDTH 10
#define BUTTON_RADIUS 20
#define BLUE_COLOR [UIColor colorWithRed:0 green:0.48 blue:1 alpha:1]

@interface PDCircleSlider ()
{
    CGFloat _circleRadius;
    CGPoint _currentPoint;
    
    BOOL _isSelected;
    CGRect _buttonRect;
    CGPoint _startPoint;
    CGPoint _center;
    
    UIColor * _bgColor_;
    UIColor * _buttonColor_;
    UIColor * _progressColor_;
    CGFloat _progress;
    
    ProgressDidChangedBlock progressDidChangeBlock;
}

@end

@implementation PDCircleSlider

- (id)initWithFrame:(CGRect)frame progressDidChangeBlock:(ProgressDidChangedBlock)block
              start:(CGFloat)start
{
    frame.size.height = frame.size.width;
    self = [super initWithFrame:frame];
    if (self) {
        progressDidChangeBlock = [block copy];
        _circleRadius = self.bounds.size.width / 2 - BUTTON_RADIUS;
        _isSelected = NO;
        _center = RectGetCenter(self.bounds);
        _bgColor_ = [UIColor colorWithHexString:@"EEEEEE"];
        _buttonColor_ = BLUE_COLOR;
        _progressColor_ = BLUE_COLOR;
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //背景环
    UIBezierPath * bgPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, BUTTON_RADIUS, BUTTON_RADIUS)];
    [_bgColor_ setStroke];
    [bgPath setLineWidth:LINE_WIDTH];
    [bgPath stroke];
    
    //进度条
    UIBezierPath * progressPath = [UIBezierPath bezierPathWithArcCenter:RectGetCenter(self.bounds) radius:self.bounds.size.width / 2 - BUTTON_RADIUS startAngle:ProgressToAngle(0) endAngle:ProgressToAngle(_progress) clockwise:YES];
    [_progressColor_ setStroke];
    [progressPath setLineWidth:LINE_WIDTH];
    [progressPath stroke];
    
    //按键 与 按键位置
    _currentPoint = progressPath.currentPoint;
    _buttonRect = CGRectMake(_currentPoint.x - BUTTON_RADIUS, _currentPoint.y - BUTTON_RADIUS, BUTTON_RADIUS * 2, BUTTON_RADIUS * 2);
    UIBezierPath * button = [UIBezierPath bezierPathWithOvalInRect:_buttonRect];
    [_buttonColor_ setFill];
    [button fill];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    _startPoint = [touch locationInView:self];
    _isSelected = CGRectContainsPoint(_buttonRect, _startPoint);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isSelected) {
        return;
    }
    UITouch * touch = [touches anyObject];
    CGPoint nowPoint = [touch locationInView:self];
    CGFloat tempAngle = AngleBetweenPoints(RectGetCenter(self.bounds), nowPoint);
    
    if (_progress > 0.5 && nowPoint.y < _center.y) {
        _progress = nowPoint.x < _center.x ? tempAngle / 360 : 1;
        
    } else if (_progress < 0.5 && nowPoint.y < _center.y) {
        _progress = nowPoint.x > _center.x ? tempAngle / 360 : 0;
        
    } else {
        _progress = tempAngle / 360;
    }
    
    progressDidChangeBlock(_progress);
    [self setNeedsDisplay];
}

#pragma mark - public method

CGFloat ProgressToAngle(CGFloat progress)
{
    return  progress * M_PI * 2 - M_PI_2;
    
}

CGPoint RectGetCenter(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGFloat DegreesFromRadians(CGFloat radians)
{
    return radians * 180.0f / M_PI;
}

CGFloat AngleBetweenPoints(CGPoint first, CGPoint second)
{
    CGFloat delta = 0;
    if (first.y <= second.y) {
        delta = 180;
    } else if (first.x > second.x){
        delta = 360;
    }
    
    CGFloat height = second.y - first.y;
    CGFloat width = first.x - second.x;
    CGFloat rads = atan(width/height);
    return DegreesFromRadians(rads) + delta;
}

CGFloat DistanceBetweenPoints(CGPoint first, CGPoint second)
{
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX * deltaX + deltaY * deltaY);
}


@end


@implementation UIColor (hexColor)

+ (UIColor *)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) return [UIColor grayColor];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end

