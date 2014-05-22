//
//  MyScene.m
//  Rainy
//
//  Created by Paul Semionov on 23.05.14.
//  Copyright (c) 2014 Paul Semionov. All rights reserved.
//

#import "MainScene.h"

@interface MainScene()

@end

@implementation MainScene

- (void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
    
    [self spawnRaindropAt:location];
    
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    NSInteger x = [self randomXFrom:0 to:self.size.width];
    
    [self spawnRaindropAt:CGPointMake(x, self.size.height + 4)];
    
}

- (void)spawnRaindropAt:(CGPoint)location {
    
    __block SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"raindrop-small"];
    
    sprite.position = location;
    
    CGFloat dropLocation = 0 - sprite.size.height / 2;
    
    SKAction *action = [SKAction moveToY:dropLocation duration:0.5f];
    
    [sprite runAction:action completion:^{
        [sprite removeFromParent];
    }];
    
    [self addChild:sprite];
    
}

- (NSInteger)randomXFrom:(NSInteger)from to:(NSInteger)to {
    
    return (arc4random_uniform((u_int32_t)to) % (to - from)) + from;
    
}

@end
