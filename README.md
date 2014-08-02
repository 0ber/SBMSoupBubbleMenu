SBMSoupBubbleMenu
=================

 SBMSoupBubbleMenu without icons  | SBMSoupBubbleMenu with icons
------------- | -------------
<img src="https://github.com/ober01/SBMSoupBubbleMenu/blob/master/ScreenShot/SoupBubbleWithoutIcons.gif" alt="MenuWithoutIcons" width="316" height="490" />  | <img src="https://github.com/ober01/SBMSoupBubbleMenu/blob/master/ScreenShot/SoupBubbleWithIcons.gif" alt="MenuWithIcons" width="316" height="490" />


## Video Demo
[video example](http://youtu.be/SGhjGoIFWTw.)
 


## Requirements
* Xcode 5 or higher
* Apple LLVM compiler
* iOS 6.0 or higher
* ARC

## Demo

Build and run the `SBMSoupBubbleMenuDemo` project in Xcode to see `SBMSoupBubbleMenu` in action. 

## Manual Install

All you need to do is drop `SBMSoupBubbleMenu` files into your project, and add `#include "SBMSoupBubbleMenu.h"` to the top of classes that will use it.

## Example
``` objective-c
// create icons names array
NSArray *iconNames = @[@"frogIcon", @"robotIcon", @"shopIcon", @"zombieIcon"];
    
//create soupBubbleMenu
SBMSoupBubbleMenu *soupBubbleMenu = [[SBMSoupBubbleMenu alloc] initWithIconNames:iconNames 
                                                                            step:90 
                                                                          inView:self.view];
soupBubbleMenu.delegate = self;
    
// Present the menu
[_soupBubbleMenu show];
```

Delegate methods:
``` objective-c
- (void)soupBubbleMenuDidShowWithBubbleMenu:(SBMSoupBubbleMenu *)bubbleMenu;
- (void)soupBubbleMenuDidHideWithBubbleMenu:(SBMSoupBubbleMenu *)bubbleMenu;
- (void)soupBubbleMenu:(SBMSoupBubbleMenu *)bubbleMenu didSelectedAtIndex:(NSInteger)buttonIndex;
```

## Contact

[![AlexKalinkin.com](https://github.com/ober01/SBMSoupBubbleMenu/blob/master/ScreenShot/logoA.png)](http://www.alexkalinkin.com)

My site - [AlexKalinkin.com](http://www.alexkalinkin.com)

## License

SBMSoupBubbleMenu is available under the MIT license. See the LICENSE file for more info.
