//
//  GameScene.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 24/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "GameScene.h"
#import "RSField.h"
@implementation GameScene

- (SKSpriteNode *)Campo
{
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(64,32)];
    
    
    SKAction *hover = [SKAction sequence:@[
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:100 y:50.0 duration:1.0],
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:-100.0 y:-50 duration:1.0]]];
    [hull runAction: [SKAction repeatActionForever:hover]];
    
    return hull;

}



-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
    
    //myLabel.text = @"Hello, World!";
    //myLabel.fontSize = 65;
    //myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
    //                               CGRectGetMidY(self.frame));
    //Leticia brincando com a cena
    [self setBackgroundColor:[UIColor whiteColor]];
    SKSpriteNode *cidade = [SKSpriteNode spriteNodeWithImageNamed:@"city"];
    cidade.physicsBody = [SKPhysicsBody bodyWithTexture:[SKTexture textureWithImageNamed:@"city"] size:cidade.frame.size];
    cidade.position = CGPointMake( 870, 150);
    cidade.zPosition = 50;
    cidade.physicsBody.dynamic=NO;
    [self addChild:cidade];
    
    RSField *T0= [[RSField alloc] init];
    [T0 setWindWithVelocity:0];
    T0.wind.exclusive=NO;
    [self addChild:T0];
    
    RSField *T1= [[RSField alloc] initWithColor:[UIColor redColor] size:(CGSizeMake(500, 500))];
    [self addChild:T1];
    [T1 setRegion: CGPointMake(500,500) with:500 and:500];
    [T1 setPressure:1];
    [T1 setWindWithVelocity:1];
    T1.wind.exclusive=YES;
    
    RSField *T2= [[RSField alloc] initWithColor:[UIColor blueColor] size:(CGSizeMake(500, 500))];
    [self addChild:T2];
    [T2 setRegion: CGPointMake(600,500) with:500 and:500];
    [T2 setPressure:0.6];
    //[T2 setWindWithVelocity:-3];
    T2.wind.exclusive=YES;
    


    //fim da sandbox da Leticia

    [self addChild:myLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Cloud"];
        sprite.zPosition=100;
        sprite.xScale = 1;
        sprite.yScale = 1;
        sprite.position = location;
        sprite.physicsBody = [SKPhysicsBody bodyWithTexture:[SKTexture textureWithImageNamed:@"Cloud"] size:sprite.frame.size];
        sprite.physicsBody.dynamic=YES;
        sprite.physicsBody.allowsRotation=NO;
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */

}

@end
