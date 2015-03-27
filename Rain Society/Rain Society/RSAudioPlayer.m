//
//  RSAudioPlayer.m
//  Rain Society
//
//  Created by Henrique de Abreu Amitay on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "RSSound.h"

@interface RSAudioPlayer()


@end


@implementation RSAudioPlayer


///Busca um som no SoundArray e o retorna
- (RSSound*) encontraSom: (NSString*) nomeDoSom
{
    RSSound *som;
    //Procuramos o som no nosso Array de som
    for(som in self.SoundArray)
    {
        if([som.nomeDoSom isEqualToString:nomeDoSom])
            break;
    }
    
    return som;
}

///Carrega um som no seu respectivo player
- (AVAudioPlayer*) carregaSom: (NSString*) nomeDoSom
{
    //Checamos se o som existe
    RSSound *som = [self encontraSom:nomeDoSom];
    
    //Caso exista, iremos inicializar em um player que dependera do seu tipo: BGM ou SFX
    if(som!=nil)
    {
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:som.nomeDoArquivo ofType:som.extensaoDoArquivo]; //Path do nosso som
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath]; //Criamos uma URL com nosso path
        
        switch (som.tipo)
        {
            case BGM:
                self.BGMPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil]; //Alocamos o player a ser usado
                [self.BGMPlayer prepareToPlay];
                return self.BGMPlayer;
            case SFX:
                self.SFXPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil]; //Alocamos o player a ser usado
                [self.SFXPlayer prepareToPlay];
                return self.SFXPlayer;
        }
    }
    return nil;
}

///Encontra, carrega e toca um som com volume que vai de 0.0 ate 1.0
- (void) tocaSom: (NSString*) nomeDoSom comVolume: (double) volume
{
    AVAudioPlayer *player =[self carregaSom: nomeDoSom];
    
    if(player!=nil)
    {
        player.volume = volume;
        [player play];
    }
}

///Altera o volume de todos os sons entre 0.0 e 1.0
- (void) setVolume: (int) volume{
    self.BGMPlayer.volume = volume;
    self.SFXPlayer.volume = volume;
}


///Para BGM, o booleano diz se o som deve resetar ou nao
- (void) stopBGM: (BOOL) reset
{
    [self.BGMPlayer stop];
    if(reset == YES)
    self.BGMPlayer.currentTime=0;
}

///Para e SFX, o booleano diz se o som deve resetar ou nao
- (void) stopSFX: (BOOL) reset
{
    
    [self.SFXPlayer stop];
    if(reset == YES)
    self.SFXPlayer.currentTime=0;
}

///Para os Sons de ambos os players, o booleano diz se o som deve resetar ou nao
- (void) stopSounds: (BOOL) reset
{
    [self stopBGM: reset];
    [self stopSFX: reset];
}

@end
