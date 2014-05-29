//
//  MyScene.m
//  Rainy
//
//  Created by Paul Semionov on 23.05.14.
//  Copyright (c) 2014 Paul Semionov. All rights reserved.
//
//  http://www.andreygordeev.com/posts/lightning
//

#import "MainScene.h"

@interface MainScene()

@property (nonatomic, assign) NSInteger intensity;

- (void)flash;
- (void)rain;
- (void)spawnRaindropAt:(CGPoint)location;
- (NSInteger)randomFrom:(NSInteger)from to:(NSInteger)to;
- (CGPoint)center;

@end

@implementation MainScene

- (instancetype)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    
    if(self) {
        
        self.intensity = 3;
        
    }
    
    return self;
    
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    [self rain];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self flash];
        
        
        SKShapeNode *yourline = [SKShapeNode node];
        CGMutablePathRef pathToDraw = CGPathCreateMutable();
        CGPathMoveToPoint(pathToDraw, NULL, 0, 0);
        CGPathAddLineToPoint(pathToDraw, NULL, self.center.x, self.center.y);
        yourline.path = pathToDraw;
        [yourline setStrokeColor:[SKColor redColor]];
        [self addChild:yourline];
        yourline.glowWidth = 5.0f;
        
    });
    
}

#pragma mark --
#pragma mrak - Flash

- (void)flash {
    
    SKSpriteNode *flashNode = [[SKSpriteNode alloc] initWithColor:[SKColor colorWithWhite:1.0f alpha:0.0f] size:self.size];
    flashNode.position = self.center;
    
    [self addChild:flashNode];
    
    SKAction *flashWhite = [SKAction colorizeWithColor:[SKColor colorWithWhite:1.0f alpha:1.0f] colorBlendFactor:0.0f duration:0.01f];
    SKAction *pause = [SKAction waitForDuration:0.1f withRange:0.02f];
    SKAction *flashTransparent = [SKAction colorizeWithColor:[SKColor colorWithWhite:1.0f alpha:0.0f] colorBlendFactor:0.0f duration:0.1f];
    SKAction *idle = [SKAction waitForDuration:15.0f withRange:10.0f];
    SKAction *sequence = [SKAction sequence:@[idle, flashWhite, pause, flashTransparent]];

    SKAction *flash = [SKAction repeatActionForever:sequence];
    
    [flashNode runAction:flash];
    
}

#pragma mrak --
#pragma mark - Rain

- (void)rain {
    
    for(int i = 0;i < self.intensity;i++) {
        
        NSInteger x = [self randomFrom:0 to:self.size.width];
        NSInteger startY = self.size.height + [self randomFrom:4 to:44];
        NSInteger y = [self randomFrom:startY to:startY + 20];
        
        [self spawnRaindropAt:CGPointMake(x, y)];
        
    }
    
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

#pragma mark --
#pragma mark - Helpers

- (NSInteger)randomFrom:(NSInteger)from to:(NSInteger)to {
    
    return (arc4random_uniform((u_int32_t)to) % (to - from)) + from;
    
}

- (CGPoint)center {
    
    return CGPointMake(self.size.width / 2, self.size.height / 2);
    
}

@end
