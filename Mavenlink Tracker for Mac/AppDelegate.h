//
//  AppDelegate.h
//  Mavenlink Tracker for Mac
//
//  Created by Vasken Hauri on 8/9/13.
//  Copyright (c) 2013 10up. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *TextTimer;
@property (weak) IBOutlet NSButton *reset;
- (IBAction)push_start:(id)sender;
- (IBAction)push_reset:(id)sender;
- (void) tick:(id)sender;
@property (weak) IBOutlet NSTextField *project;

@end
