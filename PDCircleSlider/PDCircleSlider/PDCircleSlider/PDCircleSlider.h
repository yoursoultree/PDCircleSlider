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

- (id)initWithFrame:(CGRect)frame progressDidChangeBlock:(ProgressDidChangedBlock)block start:(CGFloat)start;

@end

@interface UIColor (hexColor)

+ (UIColor *)colorWithHexString:(NSString*)hex;

@end
