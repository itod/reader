//
//  PageViewController.h
//  ReaderMobile
//
//  Created by Todd Ditchendorf on 3/11/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  Story;
@class  PageView;

@interface PageViewController : UIViewController

- (IBAction)prevPage:(id)sender;
- (IBAction)nextPage:(id)sender;

- (IBAction)back:(id)sender;

@property (nonatomic, retain) IBOutlet PageView *pageView;
@property (nonatomic, retain) Story *story;
@end

