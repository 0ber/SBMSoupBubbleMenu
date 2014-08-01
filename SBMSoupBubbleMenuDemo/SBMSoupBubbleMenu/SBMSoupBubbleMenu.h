//
//  SBMSoupBubbleMenu.h
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


#import <UIKit/UIKit.h>

@class SBMSoupBubbleMenu;

@protocol SBMSoupBubbleMenuDelegate <NSObject>

- (void)soupBubbleMenuDidShowWithBubbleMenu:(SBMSoupBubbleMenu *)bubbleMenu;
- (void)soupBubbleMenuDidHideWithBubbleMenu:(SBMSoupBubbleMenu *)bubbleMenu;
- (void)soupBubbleMenu:(SBMSoupBubbleMenu *)bubbleMenu didSelectedAtIndex:(NSInteger)buttonIndex;

@end

@interface SBMSoupBubbleMenu : UIView

- (instancetype)initWithIconNames:(NSArray *)iconNames step:(NSUInteger)step inView:(UIView *)view;
- (instancetype)initWithIconNames:(NSArray *)iconNames step:(NSUInteger)step tintColor:(UIColor *)tintColor inView:(UIView *)view;


@property (nonatomic, weak) id<SBMSoupBubbleMenuDelegate> delegate;


- (void)show;

- (void)hide;

@end
