//
//  AppDelegate.m
//  Rainy
//
//  Created by Paul Semionov on 23.05.14.
//  Copyright (c) 2014 Paul Semionov. All rights reserved.
//

#import "AppDelegate.h"
#import "MainScene.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /* Pick a size for the scene */
    SKScene *scene = [MainScene sceneWithSize:self.view.frame.size];

    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = SKSceneScaleModeAspectFit;
    scene.backgroundColor = [SKColor colorWithRed:0.12 green:0.14 blue:0.15 alpha:1];

    [self.view presentScene:scene];

    self.view.showsFPS = YES;
    self.view.showsNodeCount = YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
