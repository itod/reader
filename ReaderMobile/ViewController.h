//
//  ViewController.h
//  ReaderMobile
//
//  Created by Todd Ditchendorf on 3/11/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  Story;
@class  PageView;

@interface ViewController : UIViewController

- (IBAction)prevPage:(id)sender;
- (IBAction)nextPage:(id)sender;

@property (nonatomic, retain, readonly) PageView *pageView;
@property (nonatomic, retain) Story *story;
@end

