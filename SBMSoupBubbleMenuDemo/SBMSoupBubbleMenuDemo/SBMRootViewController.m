//
//  SBMViewController.m
//  SBMSoupBubbleMenuDemo
//
//  Created by Alex Kalinkin on 01.08.14.
//  Copyright (c) 2014 Alex Kalinkin. All rights reserved.
//

#import "SBMRootViewController.h"
#import "SBMSoupBubbleMenu.h"

@interface SBMRootViewController () <SBMSoupBubbleMenuDelegate>

@property(nonatomic, strong) SBMSoupBubbleMenu *soupBubbleMenu;

@end

@implementation SBMRootViewController

#pragma mark -
#pragma mark <SBMSoupBubbleMenuDelegate>

- (void)soupBubbleMenuDidShowWithBubbleMenu:(SBMSoupBubbleMenu *)bubbleMenu
{
    NSLog(@"show bubble menu");
}

- (void)soupBubbleMenuDidHideWithBubbleMenu:(SBMSoupBubbleMenu *)bubbleMenu
{
    NSLog(@"hide bubble menu");
    [bubbleMenu removeFromSuperview];
}

- (void)soupBubbleMenu:(SBMSoupBubbleMenu *)bubbleMenu didSelectedAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"soup bubble selected at index: %ld",(long)buttonIndex);
    [bubbleMenu hide];
}

#pragma mark -
#pragma mark IBAction

- (IBAction)showButton:(UIBarButtonItem *)sender
{
    [self createBubbleMenu];
    
    [_soupBubbleMenu show];
}

- (void)createBubbleMenu
{
    NSArray *iconNames = @[@"robotIcon", @"PenIcon", @"presentBox", @"stoneIcon"];
    _soupBubbleMenu = [[SBMSoupBubbleMenu alloc] initWithIconNames:iconNames
                                                              step:90
                                                         tintColor:[UIColor colorWithRed:0.856 green:0.523 blue:0.902 alpha:1.000]
                                                            inView:self.view];
    _soupBubbleMenu.frame = CGRectMake(120, 120, _soupBubbleMenu.frame.size.width, _soupBubbleMenu.frame.size.height);
    _soupBubbleMenu.delegate = self;
}

@end
