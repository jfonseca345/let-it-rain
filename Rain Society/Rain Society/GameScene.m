//
//  GameScene.m
//  Rain Society
//
//  Created by Jucelio Fonseca on 24/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "GameScene.h"
#import "RSMap.h"
#import "RSButton.h"
#import "ECity.h"
#import "ELake.h"
#import "EMountain.h"
#import "EForest.h"
#import "ECloud.h"
#import "RSAudioPlayer.h"

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

-(void) startGame{
    //SKView * skView = (SKView *)self.view;
    self.backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"background2"];
    [self.backgroundImage setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [self.backgroundImage setSize:CGSizeMake(self.size.width,self.size.height-140)];
    [self addChild:self.backgroundImage];
    
    self.Mappon = [[RSMap alloc] initWithWidth:CGRectGetWidth(self.frame) Height:CGRectGetHeight(self.frame)];
    [self.Mappon createFields:3 and:2];
    self.Mappon.scene=self;
    
    //Seta os sons
    [self.Mappon.audioPlayer tocaSom:@"Fundo" comVolume:0.1];
    
    //Particulas
    SKEmitterNode* particle;
    NSString *particlePath = [[NSBundle mainBundle] pathForResource:@"TinyBits" ofType:@"sks"];
    particle = [NSKeyedUnarchiver unarchiveObjectWithFile:particlePath];
    particle.targetNode = self;
    particle.position = CGPointMake(0,(-1)*self.frame.size.height/2);
    
    //Comecamos a emitir
    [self addChild: particle];
    

    
    //Configura sprite cidade
    ECity *city = [[ECity alloc] initWithPosition:CGPointMake(0, 0)];
    // valores definidos por meio de testes
    [city setSizes:0.9 andLocation:CGPointMake( CGRectGetMaxX( self.frame )-city.frame.size.width/2 + 25, CGRectGetMinY(self.frame)+city.frame.size.height-30)];
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
    
    //Configura um botão para reset
    RSButton* restartButton = [[RSButton alloc] initWithText:@"R"];
    [restartButton setZPosition:200];
    [restartButton setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetHeight(self.frame)-150)];
    [restartButton setHandler:^{
        [self restartGame];
    }];
    [self addChild:restartButton];
    
    RSButton* menuButton = [[RSButton alloc] initWithText:@"R"];
    [menuButton setZPosition:200];
    [menuButton setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetHeight(self.frame)-150)];
    [menuButton setHandler:^{
        
    }];
    [self addChild:menuButton];

    
}
-(void) restartGame{
    [self removeAllChildren];
    [self.Mappon.audioPlayer stopBGM:YES];
    [self startGame];
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    [self startGame];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode* touchedNode = [self nodeAtPoint:location];
        if (!([touchedNode.name isEqualToString:@"lago"])&&!([touchedNode.name isEqualToString:@"nuvem"])){
            RSField * fieldon = [self.Mappon touchedField:location];
            [fieldon showPopup:self];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self.Mappon updateFields];
}

@end
