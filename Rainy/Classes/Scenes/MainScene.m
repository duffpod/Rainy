//
//  MyScene.m
//  Rainy
//
//  Created by Paul Semionov on 23.05.14.
//  Copyright (c) 2014 Paul Semionov. All rights reserved.
//

#import "MainScene.h"

@interface MainScene()

@property (nonatomic, assign) NSInteger intensity;

@end

@implementation MainScene

- (instancetype)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    
    if(self) {
        
        self.intensity = 3;
        
    }
    
    return self;
    
}

- (void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
    
    [self spawnRaindropAt:location];
    
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    for(int i = 0;i < self.intensity;i++) {
        
        [self rain];
        
    }
    
}

- (void)rain {
    
    NSInteger x = [self randomFrom:0 to:self.size.width];
    NSInteger startY = self.size.height + 4;
    NSInteger y = [self randomFrom:startY to:startY + 20];
    
    [self spawnRaindropAt:CGPointMake(x, y)];
    
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

- (NSInteger)randomFrom:(NSInteger)from to:(NSInteger)to {
    
    return (arc4random_uniform((u_int32_t)to) % (to - from)) + from;
    
}

@end
