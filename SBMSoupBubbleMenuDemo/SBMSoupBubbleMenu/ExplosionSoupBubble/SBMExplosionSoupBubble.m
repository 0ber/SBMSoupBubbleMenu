//
//  explosionSoupBubble.m
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


#import "SBMExplosionSoupBubble.h"
#import "UIImage+Color.h"

NSString const * kImageName = @"explosion_soup_bubble0";
#define imagesCount 4

@implementation SBMExplosionSoupBubble

- (instancetype)initWithFrame:(CGRect)frame tintColor:(UIColor *)tintColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = tintColor;
        self.animationImages = [self createFrameImages];
        self.animationDuration = .2;
        self.animationRepeatCount = 1;
        self.alpha = .7;
    }
    return self;
}

- (NSArray *)createFrameImages
{
    NSMutableArray *images = [NSMutableArray new];
    for (NSUInteger i = 1; i <= imagesCount; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%@%lu", kImageName, (unsigned long)i];
        UIImage *image = [UIImage SBM_filledImageFrom:imageName withColor:self.tintColor];
        [images addObject:image];
    }
    return images;
}

@end
