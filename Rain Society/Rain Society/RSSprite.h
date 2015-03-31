//
//  RSSprite.h
//  FisicaTest
//
//  Created by Henrique de Abreu Amitay on 30/03/15.
//  Copyright (c) 2015 Henrique de Abreu Amitay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"


@interface RSSprite : SKSpriteNode

//Nome da Imagem do Sprite
@property (nonatomic, strong) NSString* spriteName;

//Particle
@property (nonatomic, strong) SKEmitterNode *particle;

//Booleano que auxilia no toogle da emissao de particulas
@property (nonatomic) BOOL isItEmiting;

///Metodo construtor. OBS: Nao seta a particle, deve ser feito manualmente
- (RSSprite*) initWithImageNamed:(NSString*)name;

///Altera a geometria do sprite
- (void) setSizes: (CGFloat) scale andLocation: (CGPoint) location;

///Move o sprite ate um ponto
- (void) moveSprite: (CGPoint) point;

///Sprite aparece gradualmente
- (void) fadeIn;

///Sprite some gradualmente
- (void) fadeOut;

///Comeca emissao de particulas
- (void) emitParticleNamed: (NSString*)name;

///Para emissao de particulas
- (void) stopEmiting;
@end
