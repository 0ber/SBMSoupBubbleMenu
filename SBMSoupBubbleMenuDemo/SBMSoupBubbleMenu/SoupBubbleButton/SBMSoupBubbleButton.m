//
//  SoupBubbleView.m
//  SBMSoupBubbleMenu
//
//  Created by Alex Kalinkin on 29.07.14.
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

#import "SBMSoupBubbleButton.h"
#import "SBMExplosionSoupBubble.h"
#import "UIImageView+AnimationCompletion.h"
#import "UIImage+Color.h"

@interface SBMSoupBubbleButton ()

@property (nonatomic, strong) UIColor *soupTintColor;

@end

@implementation SBMSoupBubbleButton

#pragma mark -
#pragma mark lifeCircle

- (instancetype)initWithIconName:(NSString *)iconName origin:(CGPoint)origin tintColoer:(UIColor *)tintColor
{
    self = [super init];
    if (self) {
        
        _soupTintColor = tintColor;
        
        // icon
        UIImage *iconImage = [UIImage imageNamed:iconName];
        [self setImage:iconImage forState:UIControlStateNormal];
        
        // color image
        UIImage *soupBubbleColor = [UIImage SBM_filledImageFrom:@"soupBubble_color" withColor:_soupTintColor];
        self.frame = CGRectMake(origin.x, origin.y, soupBubbleColor.size.width, soupBubbleColor.size.height);
        [self setBackgroundImage:soupBubbleColor forState:UIControlStateNormal];
        
        // contur image
        UIImage *soupBubbleCountur = [UIImage imageNamed:@"soupBubble_contur"];
        UIImageView *soupBubbleCounturView = [[UIImageView alloc] initWithImage:soupBubbleCountur];
        soupBubbleCounturView.frame = CGRectMake(0, -2, soupBubbleCountur.size.width, soupBubbleCountur.size.height);
        [self addSubview:soupBubbleCounturView];
        
        self.alpha = .6;
        
        [self addTarget:self action:@selector(buttonHeandler:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark -
#pragma mark actions 

- (void)buttonHeandler:(UIButton *)sender
{
    [self.delegate soupBubbleButtonDidSelectedAtIndex:self.tag];
    [self removeFromSuperview];
}

#pragma mark -
#pragma mark helper methods

- (void)showExplosionInView:(UIView *)view position:(CGPoint)position
{
    CGRect explosionFrame = CGRectMake(position.x + self.frame.origin.x,
                                       position.y + self.frame.origin.y,
                                       self.frame.size.width,
                                       self.frame.size.height);
    
    SBMExplosionSoupBubble *explosionSoupBubble = [[SBMExplosionSoupBubble alloc] initWithFrame:explosionFrame
                                                                                      tintColor:_soupTintColor];
    [view addSubview:explosionSoupBubble];
    [explosionSoupBubble startAnimatingWithCompletionBlock:^(UIImageView *imageView, BOOL success) {
        [imageView removeFromSuperview];
    }];
}

@end
