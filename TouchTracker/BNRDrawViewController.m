//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Dylan Jhaveri on 4/23/14.
//  Copyright (c) 2014 Dylan Jhaveri. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end
