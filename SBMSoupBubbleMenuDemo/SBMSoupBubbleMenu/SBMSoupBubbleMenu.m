//
//  SBMSoupBubbleMenu.m
//  SBMSoupBubbleMenu
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


#import "SBMSoupBubbleMenu.h"
#import "SKBounceAnimation.h"
#import "SBMSoupBubbleDataSource.h"

@interface SBMSoupBubbleMenu ()<SBMSoupBubbleDataSourceDelegete>

@property (nonatomic, strong) NSArray *iconNames;
@property (nonatomic, assign) NSInteger step;
@property (nonatomic, strong) SBMSoupBubbleDataSource *dataSource;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIView *subView;

@end

@implementation SBMSoupBubbleMenu

#pragma mark -
#pragma mark life circle

- (instancetype)initWithIconNames:(NSArray *)iconNames step:(NSUInteger)step inView:(UIView *)view
{
    return [[SBMSoupBubbleMenu alloc] initWithIconNames:iconNames step:step tintColor:[UIColor greenColor] inView:view];
}

- (instancetype)initWithIconNames:(NSArray *)iconNames step:(NSUInteger)step tintColor:(UIColor *)tintColor inView:(UIView *)view
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _iconNames = iconNames;
        _step = step;
        _tintColor = tintColor;
        _subView = view;
        
        _dataSource = [[SBMSoupBubbleDataSource alloc] initWithDelegate:self];
        CGSize menuSize = [self.dataSource menuSize];
        self.frame = CGRectMake(0, 0, menuSize.width, menuSize.height);
    }
    return self;
}

#pragma mark -
#pragma mark <SBMSoupBubbleDataSourceDelegete>

- (UIView *)subviewFromButtons
{
    return self;
}

- (NSUInteger)buttonsCount
{
    return [_iconNames count];
}

-(NSUInteger)stepBetweenButtons
{
    return _step;
}

- (NSString *)iconNameAtIndex:(NSUInteger)index
{
    return _iconNames[index];
}

- (UIColor *)tintColorAtIndex:(NSUInteger)index
{
    return _tintColor;
}

- (void)soupBubbleButtonDidSelectedAtIndex:(NSInteger)buttonIndex
{
    [self.dataSource showButtonExplosionAtIndex:buttonIndex inView:_subView];
    [self.delegate soupBubbleMenu:self didSelectedAtIndex:buttonIndex];
}

#pragma mark -
#pragma mark public methods

- (void)show
{
    [_subView addSubview:self];
    
    [self.dataSource animationScale:10
                       boundNumbers:2
                          stiffness:SKBounceAnimationStiffnessLight
                         completion:^{
                             
                             [self.dataSource startWaveAnimation];
                             [self.delegate soupBubbleMenuDidShowWithBubbleMenu:self];
    }];
}

- (void)hide
{
    [self.dataSource stopWaveAnimation];
    [self.dataSource animationScale:.1 completion:^{
        [self.delegate soupBubbleMenuDidHideWithBubbleMenu:self];
    }];
}



@end
