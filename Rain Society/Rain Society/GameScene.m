//
//  GameScene.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 24/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

- (SKSpriteNode *)Campo
{
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(64,32)];
    
    
    SKAction *hover = [SKAction sequence:@[
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:100 y:50.0 duration:1.0],
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:-100.0 y:-50 duration:1.0]]];
    [hull runAction: [SKAction repeatActionForever:hover]];
    
    return hull; }



-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.xScale = 0.25;
        sprite.yScale = 0.12;
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
