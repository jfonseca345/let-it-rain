//
//  RSSprite.m
//  FisicaTest
//
//  Created by Henrique de Abreu Amitay on 30/03/15.
//  Copyright (c) 2015 Henrique de Abreu Amitay. All rights reserved.
//

#import "RSSprite.h"

@implementation RSSprite

- (RSSprite*) initWithImageNamed:(NSString*)name
{
    //Inicializacao da sprite
    self = [super initWithImageNamed:name];
    self.spriteName = name;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.isItEmiting = NO;
    return self;
    
}

- (void) setSizes: (CGFloat) scale andLocation: (CGPoint) location
{
    //Seta as scales e posicoes
    self.xScale = scale;
    self.yScale = scale;
    self.position = location;
}
- (void) moveSprite: (CGPoint) point
{
    //Move ate um certo ponto
    SKAction *movement = [SKAction moveTo:point duration:1];
    [self runAction: movement];
    
}

- (void) fadeIn
{
    SKAction *fadeIn = [SKAction fadeInWithDuration:5];
    [self runAction: fadeIn];

}

- (void) fadeOut
{
    SKAction *fadeOut = [SKAction fadeOutWithDuration:3];
    [self runAction: fadeOut];
}

- (void) emitParticleNamed: (NSString*) name
{
    if(!self.isItEmiting)
    {
    //Definimos nosso emissor de particulas
    NSString *particlePath = [[NSBundle mainBundle] pathForResource:name ofType:@"sks"];
    self.particle = [NSKeyedUnarchiver unarchiveObjectWithFile:particlePath];
    self.particle.targetNode = self;
    self.particle.position = CGPointMake(0,(-1)*self.frame.size.height/2);
    
    //Comecamos a emitir
    [self addChild: self.particle];
    
    //Toogle no boolean
    self.isItEmiting = YES;
    }
}

-(void) stopEmiting
{
    
    if(self.isItEmiting)
    {
        //Removemos o emissor
        [self.particle removeFromParent];
        
        //Toogle no boolean
        self.isItEmiting = NO;
    }
}

@end
