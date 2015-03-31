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

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
    
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

    [self addChild:myLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode* touchedNode = [self nodeAtPoint:location];
        RSField * fieldon = [self.Mappon touchedField:location];
        [fieldon showPopup:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"nuvem"];
        sprite.zPosition=100;
        sprite.xScale = 1;
        sprite.yScale = 1;
        sprite.position = location;
        sprite.physicsBody = [SKPhysicsBody bodyWithTexture:[SKTexture textureWithImageNamed:@"nuvem"] size:sprite.frame.size];
        sprite.physicsBody.allowsRotation=NO;
        sprite.physicsBody.dynamic=NO;
        sprite.physicsBody.allowsRotation=NO;
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
