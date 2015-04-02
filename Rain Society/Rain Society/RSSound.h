//
//  RSSound.h
//  Rain Society
//
//  Created by Henrique de Abreu Amitay on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

//Classe que representa o som

#import <Foundation/Foundation.h>

@interface RSSound : NSObject

///Se o som é BGM ou SFX
typedef enum tipos
{
    BGM,
    SFX
}TipoDeSom;


///Nome do som, dado arbitrariamente pelo desenvolvedor
@property (nonatomic,strong) NSString *nomeDoSom;

///Nome do arquivo de som
@property (nonatomic,strong) NSString *nomeDoArquivo;

///Extensao do arquivo de som
@property (nonatomic,strong) NSString *extensaoDoArquivo;

@property (nonatomic) TipoDeSom tipo;

@end
