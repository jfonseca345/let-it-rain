//
//  RSAudioPlayer.h
//  Rain Society
//
//  Created by Henrique de Abreu Amitay on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "RSSound.h"

@interface RSAudioPlayer : NSObject

//Players para BGM e SFX, criamos dois players diferentes para que possamos tocar os dois ao mesmo tempo
@property (nonatomic,strong) AVAudioPlayer* BGMPlayer;
@property (nonatomic,strong) AVAudioPlayer* SFXPlayer;

//Array que salvara o nome, endereco, extensao e tipo de todos os nossos arquivos de som
@property (nonatomic,strong) NSArray* SoundArray;

///Busca um som no SoundArray e o retorna
- (RSSound*) encontraSom: (NSString*) nomeDoSom;

///Carrega um som no seu respectivo player
- (AVAudioPlayer*) carregaSom: (NSString*) nomeDoSom;

///Encontra, carrega e toca um som com volume que vai de 0.0 ate 1.0
- (void) tocaSom: (NSString*) nomeDoSom comVolume: (double) volume;

///Para os Sons de ambos os players
- (void) paraTodosSons;

@end
