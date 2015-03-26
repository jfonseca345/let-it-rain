//
//  RSAudioPlayer.m
//  Rain Society
//
//  Created by Henrique de Abreu Amitay on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "RSSound.m"

@interface RSAudioPlayer()


@end


@implementation RSAudioPlayer

@synthesize BGMPlayer;
@synthesize SFXPlayer;


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

- (void) tocaSom: (NSString*) nomeDoSom comVolume: (double) volume
{
    AVAudioPlayer *player =[self carregaSom: nomeDoSom];
    
    if(player!=nil)
    {
        player.volume = volume;
        [player play];
    }
}

- (void) paraBGM
{
    [self.BGMPlayer stop];
    self.BGMPlayer.currentTime=0;
}

- (void) paraSFX
{
    
    [self.SFXPlayer stop];
    self.SFXPlayer.currentTime=0;
}

- (void) paraTodosSons
{
    [self paraBGM];
    [self paraSFX];
}

@end
