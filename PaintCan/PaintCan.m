//
//  PaintCan.m
//  PaintCan
//
//  Created by Wolfgang Baird on 2/1/21.
//  Copyright © 2021 macEnhance. All rights reserved.
//

@import AppKit;
#import "ZKSwizzle.h"

static NSBundle *CarBundle;

@interface PaintCan : NSObject
@end

@implementation PaintCan

+ (void)load {
    /*
        Add the following file to PaintCan.bundle
        /Library/Application Support/MacEnhance/Plugins/PaintCan.bundle/Contents/Resources/tictok.car
     */
    
    NSLog(@"PaintCan applying some fresh paint...");
    CarBundle = [NSBundle bundleForClass:PaintCan.class];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NSApp setAppearance:NSApp.effectiveAppearance];
    });
}

@end

ZKSwizzleInterface(_PaintDefense, NSApplication, NSApplication)
@implementation _PaintDefense

- (NSAppearance *)appearance {
    NSAppearance *ape = ZKOrig(NSAppearance *);
    // NSLog(@"PaintCan checkin appearance - %@", ape.name);
    
    /* determine system appearance */
    NSString *bongwater = [NSUserDefaults.standardUserDefaults stringForKey:@"AppleInterfaceStyle"];
    NSAppearanceName dd = NSAppearanceNameDarkAqua;
    if (!bongwater)
        dd = NSAppearanceNameAqua;
    /* done */
    
    if (CarBundle) {
        NSString *replacement = [dd stringByAppendingString:@".paintcan"];
        NSString *file = [CarBundle pathForResource:replacement ofType:@"car"];
        if (file) {
            ape = [[NSAppearance alloc] initWithAppearanceNamed:replacement bundle:CarBundle];
            NSLog(@"PaintCan applying replacement -- %@", replacement);
        } else {
            ape = [NSAppearance appearanceNamed:dd];
        }
    }
    
    return ape;
}

@end
