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
    NSArray *iconNames = @[@"frogIcon", @"robotIcon", @"shopIcon", @"zombieIcon"];
    _soupBubbleMenu = [[SBMSoupBubbleMenu alloc] initWithIconNames:iconNames step:90 inView:self.view];
    _soupBubbleMenu.frame = CGRectMake(120, 120, _soupBubbleMenu.frame.size.width, _soupBubbleMenu.frame.size.height);
    _soupBubbleMenu.delegate = self;
}

@end
