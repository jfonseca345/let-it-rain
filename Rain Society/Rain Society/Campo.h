//
//  Campo.h
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/26/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Campo : SKFieldNode

@property int temperatura;
@property int pressao;
@property SKPhysicsBody *nuvem;
@property SKPhysicsBody *objeto;
@property (nonatomic, strong) SKRegion *regiao;

-(void) tempConfig : (int) novaTemp;
-(void) presConfig : (int) novaPressao;
-(void) ventoConfig : (int) velocidade;

-(void) interacaoObjeto : (NSString *) tipo;


@end
