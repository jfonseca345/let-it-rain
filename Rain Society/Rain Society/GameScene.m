//
//  GameScene.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 24/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "GameScene.h"
#import "RSMap.h"


@interface GameScene () <SKPhysicsContactDelegate> {
    SKSpriteNode* t1;
    SKSpriteNode* t2;
    SKSpriteNode* t3;
    SKSpriteNode* t4;
    SKLabelNode* _scoreLabelNode;
    
}
@property (nonatomic) RSMap* Mappon;
@end




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
    
    self.Mappon = [[RSMap alloc] initWithWidth:CGRectGetWidth(self.frame) Height:CGRectGetHeight(self.frame)];
    [self.Mappon createFields:3 and:2];
    
    [self setBackgroundColor:[UIColor greenColor]];
    
    //Configura sprite cidade
    SKSpriteNode *cidade = [SKSpriteNode spriteNodeWithImageNamed:@"cidade"];
    cidade.position = CGPointMake( CGRectGetMaxX( self.frame )-cidade.frame.size.width/2 + 25, CGRectGetMinY(self.frame)+cidade.frame.size.height-55); // valores definidos por meio de testes
    cidade.zPosition = 1;// posicona cidade à frente
    cidade.xScale=cidade.yScale=0.8;
    [self addChild:cidade];
    
    //Configura sprite Montanha
    SKSpriteNode *montanha = [SKSpriteNode spriteNodeWithImageNamed:@"montanha"];
    montanha.physicsBody = [SKPhysicsBody bodyWithTexture:[SKTexture textureWithImageNamed:@"montanha"] size:cidade.frame.size];
    montanha.position = CGPointMake( (CGRectGetMaxX( self.frame )/2 + 29), CGRectGetMinY(self.frame)+montanha.frame.size.height-80); // valores definidos por meio de testes
    montanha.zPosition = 1;
    montanha.physicsBody.dynamic=NO;
    montanha.xScale=montanha.yScale=1;
    [self addChild:montanha];
    
    //Configura sprite Lago
    SKSpriteNode *lago = [SKSpriteNode spriteNodeWithImageNamed:@"lago"];
    lago.position = CGPointMake( CGRectGetMinX( self.frame )+lago.frame.size.width/2-40, CGRectGetMinY(self.frame)+lago.frame.size.height+20); // valores definidos por meio de testes
    lago.zPosition = 1;// posicona cidade à frente
    lago.xScale=lago.yScale=0.5;
    [self addChild:lago];
    
    //Configura sprite Floresta
    SKSpriteNode *floresta = [SKSpriteNode spriteNodeWithImageNamed:@"floresta"];
    floresta.position = CGPointMake( CGRectGetMinX( self.frame )+floresta.frame.size.width-20, CGRectGetMinY(self.frame)+floresta.frame.size.height+70); // valores definidos por meio de testes
    floresta.zPosition = 0;// posicona cidade à frente
    floresta.xScale=floresta.yScale=1.5;
    [self addChild:floresta];
    [_Mappon.fields[0][0] setLake:YES];
    
    _scoreLabelNode = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
    _scoreLabelNode.position = CGPointMake( CGRectGetMidX( self.frame ), self.frame.size.height / 2 );
    _scoreLabelNode.text = [NSString stringWithFormat:@"Try your luck!"];
    [self addChild:_scoreLabelNode];

    /*
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
    */


    //fim da sandbox da Leticia

    [self addChild:myLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode* touchedNode = [self nodeAtPoint:location];
        RSField * fieldon = [self.Mappon touchedField:location];
        [fieldon showPopup:self];
        
        //NSLog(@"%@",fieldon);
        //NSLog(@"loccation:%f,%f", location.x,location.y);
        //SKSpriteNode *spriton = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:fieldon.region.size];
        //[spriton setAnchorPoint:CGPointMake(0,0)];
        //[spriton setPosition:fieldon.region.origin];
        //[self addChild:spriton];
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"nuvem"];
        sprite.zPosition=100;
        sprite.xScale = 1;
        sprite.yScale = 1;
        sprite.position = location;
        sprite.physicsBody = [SKPhysicsBody bodyWithTexture:[SKTexture textureWithImageNamed:@"nuvem"] size:sprite.frame.size];
        sprite.physicsBody.allowsRotation=NO;
        sprite.physicsBody.dynamic=NO;
        sprite.physicsBody.allowsRotation=NO;
        //SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
       // [sprite runAction:[SKAction repeatActionForever:action]];
        
       // [self addChild:sprite];
        //fieldon.temperature++;
        if(fieldon.lake==YES && fieldon.temperature>=5){
            [self addChild:sprite];
            SKAction *rise = [SKAction moveToY:600 duration: 3];
            [sprite runAction:rise];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */

}

@end
