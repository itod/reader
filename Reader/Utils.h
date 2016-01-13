//
//  Utils.h
//  Evolution
//
//  Created by Todd Ditchendorf on 1/1/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import <Foundation/Foundation.h>

void TDPerformOnMainThread(void (^block)(void));
void TDPerformOnBackgroundThread(void (^block)(void));
void TDPerformOnMainThreadAfterDelay(double delay, void (^block)(void));
void TDPerformOnBackgroundThreadAfterDelay(double delay, void (^block)(void));
