//
//  GameScene.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 24/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "GameScene.h"
#import "RSMap.h"
#import "ECity.h"
#import "ELake.h"
#import "EMountain.h"
#import "EForest.h"
#import "ECloud.h"



@interface GameScene () <SKPhysicsContactDelegate> {
    SKSpriteNode* t1;
    SKSpriteNode* t2;
    SKSpriteNode* t3;
    SKSpriteNode* t4;
    SKLabelNode* _scoreLabelNode;
    
}
@property (nonatomic) RSMap* Mappon;
@property (nonatomic,strong) SKSpriteNode* backgroundImage;
@end




@implementation GameScene



-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
    self.backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
    [self.backgroundImage setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [self.backgroundImage setSize:self.frame.size];
    [self addChild:self.backgroundImage];
    
    self.Mappon = [[RSMap alloc] initWithWidth:CGRectGetWidth(self.frame) Height:CGRectGetHeight(self.frame)];
    [self.Mappon createFields:3 and:2];
    
    [self setBackgroundColor:[UIColor greenColor]];
    
    //Configura sprite cidade
    ECity *city = [[ECity alloc] initWithPosition:CGPointMake(0, 0)];
    // valores definidos por meio de testes
    [city setSizes:0.8 andLocation:CGPointMake( CGRectGetMaxX( self.frame )-city.frame.size.width/2 + 25, CGRectGetMinY(self.frame)+city.frame.size.height-40)];
    [self addChild:city];
    [self.Mappon addSprite:city inField:2 and:0];
    
    //Configura sprite Montanha
    EMountain *mountain = [[EMountain alloc] initWithPosition:CGPointMake(0,0)];
    mountain.position = CGPointMake( (CGRectGetMaxX( self.frame )/2 + 35), CGRectGetMinY(self.frame)+mountain.frame.size.height-60);
     // valores definidos por meio de testes
    [self addChild:mountain];
    [self.Mappon addSprite:mountain inField:1 and:0];
    
    //Configura sprite Lago
    ELake *lake = [[ELake alloc] initWithPosition:CGPointMake(0, 0)];
    [lake setSizes:0.5 andLocation:CGPointMake( CGRectGetMinX( self.frame )+lake.frame.size.width/2-40, CGRectGetMinY(self.frame)+lake.frame.size.height+30)]; // valores definidos por meio de testes
    [self addChild:lake];
    [self.Mappon addSprite:lake inField:0 and:0];
    
    //Configura sprite Floresta
    EForest *forest = [[EForest alloc ] initWithPosition:CGPointMake(0,0)];
    // valores definidos por meio de testes
    [forest setSizes:1.5 andLocation:CGPointMake( CGRectGetMinX( self.frame )+forest.frame.size.width-20, CGRectGetMinY(self.frame)+forest.frame.size.height+110)];
    [self addChild:forest];
    
    [self.Mappon addSprite:forest inField:0 and:0];
    
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
        if (touchedNode == self.backgroundImage){
            RSField * fieldon = [self.Mappon touchedField:location];
            [fieldon showPopup:self];
            
            /*SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"nuvem"];
            sprite.zPosition=100;
            sprite.xScale = 1;
            sprite.yScale = 1;
            sprite.position = location;
            sprite.physicsBody = [SKPhysicsBody bodyWithTexture:[SKTexture textureWithImageNamed:@"nuvem"] size:sprite.frame.size];
            sprite.physicsBody.allowsRotation=NO;
            sprite.physicsBody.dynamic=NO;
            sprite.physicsBody.allowsRotation=NO;*/
            //if(fieldon.lake==YES && fieldon.temperature>=5){
           //     [self addChild:sprite];
            //    SKAction *rise = [SKAction moveToY:600 duration: 3];
             //   [sprite runAction:rise];
            //}
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self.Mappon updateFields];
}

@end
