//
//  SBMSoupBubbleDataSource.m
//  SBMSoupBubbleMenu
//
//  Created by Alex Kalinkin on 30.07.14.
//  Copyright (c) 2014 Alex Kalinkin. All rights reserved.
//
//  Created by Alex Kalinkin (AlexKalinkin.com) on 29.07.14.
//  Copyright (C) 2013-2020 by Alex Kalinkin
//

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "SBMSoupBubbleDataSource.h"
#import "SBMSoupBubbleButton.h"

@interface SBMSoupBubbleDataSource ()<SBMSoupBubbleButtonDelegate>

@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, assign) BOOL isStopWaveAnimation;
@property (nonatomic, assign) NSInteger step;

#define WAVE_STEP_ANIMATION 5
#define ANGLE_ANIMATION .2

@end

@implementation SBMSoupBubbleDataSource

#pragma mark -
#pragma mark life circle
- (instancetype)initWithDelegate:(id<SBMSoupBubbleDataSourceDelegete>)aDelegate
{
    self = [super init];
    if (self) {
        self.delegate = aDelegate;
        [self createButtons];
    }
    return self;
}

- (void)createButtons
{
    NSUInteger yPosition = 0;
    NSMutableArray *aButtons = [NSMutableArray new];
    
    UIView *subView = [self.delegate subviewFromButtons];
    NSInteger buttonCount = [self.delegate buttonsCount];
    _step = [self.delegate stepBetweenButtons];
    
    for (NSInteger i=0; i<buttonCount; i++) {
        NSString *iconName = [self.delegate iconNameAtIndex:i];
        UIColor *tintColor = [self.delegate tintColorAtIndex:i];
        SBMSoupBubbleButton *soupBubbleButtton = [[SBMSoupBubbleButton alloc] initWithIconName:iconName
                                                                                        origin:CGPointMake(0, yPosition)
                                                                                    tintColoer:tintColor];
        soupBubbleButtton.tag = i;
        soupBubbleButtton.delegate = self;
        [subView addSubview:soupBubbleButtton];
        soupBubbleButtton.transform = CGAffineTransformScale(CGAffineTransformIdentity, .1, .1);
        [aButtons addObject:soupBubbleButtton];
        yPosition += _step;
    }
    _buttons = aButtons.copy;
}

#pragma mark -
#pragma mark animation methods

- (void)animationScale:(NSUInteger)scale
          boundNumbers:(NSInteger)boundNumbers
             stiffness:(SKBounceAnimationStiffness)stiffness
            completion:(void(^)(void))completion
{
    NSString *keyPath = @"transform";
    
    CGFloat duration = .5f;
    
    for (SBMSoupBubbleButton *button in _buttons) {
        CATransform3D transform = button.layer.transform;
        id finalValue = [NSValue valueWithCATransform3D:
                         CATransform3DScale(transform, scale, scale, scale)
                         ];
        
        SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
        bounceAnimation.fromValue = [NSValue valueWithCATransform3D:transform];
        bounceAnimation.toValue = finalValue;
        bounceAnimation.duration = duration;
        bounceAnimation.numberOfBounces = boundNumbers;
        bounceAnimation.shouldOvershoot = YES;
        bounceAnimation.stiffness = stiffness;
        
        [button.layer addAnimation:bounceAnimation forKey:@"someKey"];
        
        [button.layer setValue:finalValue forKeyPath:keyPath];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (completion) completion();
    });
}

- (void)animationScale:(CGFloat)scale completion:(void(^)(void))completion
{
    [UIView animateWithDuration:.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                        for (SBMSoupBubbleButton *button in _buttons) {
                            button.transform = CGAffineTransformMakeScale(scale, scale);
                        }
                     }
                     completion:^(BOOL finished) {
                         if (completion) completion();
                     }
     ];
}

- (void)showButtonExplosionAtIndex:(NSInteger)index inView:(UIView *)view
{
    SBMSoupBubbleButton *button = _buttons[index];
    UIView *subView = [self.delegate subviewFromButtons];
    [button showExplosionInView:view position:CGPointMake(subView.frame.origin.x, subView.frame.origin.y)];
}

#pragma mark -
#pragma mark wave animation

- (void)startWaveAnimation
{
    _isStopWaveAnimation = NO;
    [self waveAnimationWithDirections:YES];
}

- (void)waveAnimationWithDirections:(BOOL)isLeftDirections
{
    NSInteger xStep = isLeftDirections ? WAVE_STEP_ANIMATION * -1 : WAVE_STEP_ANIMATION;
    CGFloat angle = isLeftDirections ? ANGLE_ANIMATION * -1.0: ANGLE_ANIMATION;
    
    [self moveToXStep:xStep angle:angle completion:^{
        [self waveAnimationWithDirections:!isLeftDirections];
    }];
}

- (void)moveToXStep:(NSInteger)xStep angle:(CGFloat)angle completion:(void(^)(void))completion {
    if (_isStopWaveAnimation) return;
    
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         NSInteger buttonDirection = 1;
                         for (SBMSoupBubbleButton *button in _buttons) {
                             buttonDirection *= -1;
                             CGAffineTransform transform = CGAffineTransformMakeTranslation(xStep * buttonDirection, 0);
                             button.transform = CGAffineTransformRotate(transform, angle);
                         }
                     }
                     completion:^(BOOL finished) {
                         if (completion) completion();
                     }
     ];
}

- (void)stopWaveAnimation
{
    _isStopWaveAnimation = YES;
}


- (CGSize)menuSize
{
    SBMSoupBubbleButton *anyButton = [_buttons firstObject];
    anyButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    
    CGSize btnSize = anyButton.frame.size;
    NSInteger heightBetweenButton =  (_step - btnSize.height);
    
    CGSize aMenuSize = CGSizeMake(btnSize.width,
                                  btnSize.height * [_buttons count] + heightBetweenButton * ([_buttons count] - 1));
    anyButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, .1, .1);
    return aMenuSize;
}

#pragma mark -
#pragma mark  <SBMSoupBubbleButtonDelegate>

- (void)soupBubbleButtonDidSelectedAtIndex:(NSInteger)buttonIndex
{
    [self.delegate soupBubbleButtonDidSelectedAtIndex:buttonIndex];
}


@end
