//
//  PDCircleSlider.h
//  PDCircleSlider
//
//  Created by ChenGe on 14-3-30.
//  Copyright (c) 2014年 Panda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ProgressDidChangedBlock)(CGFloat progress);

@interface PDCircleSlider : UIView

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, copy)   ProgressDidChangedBlock progressDidChangeBlock;

@property (nonatomic, strong, setter = setBgColor:) UIColor * bgColor;
@property (nonatomic, strong, setter = setButtonColor:) UIColor * buttonColor;
@property (nonatomic, strong, setter = setProgressColor:) UIColor * progressColor;

- (id)initWithFrame:(CGRect)frame progressDidChangeBlock:(ProgressDidChangedBlock)block
              start:(CGFloat)start
          clockwise:(BOOL)clockwise;

@end



@interface UIColor (hexColor)

+ (UIColor *)colorWithHexString:(NSString*)hex;

@end
