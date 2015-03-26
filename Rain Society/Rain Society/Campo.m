//
//  Campo.m
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/26/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "Campo.h"

@implementation Campo

//-(id) init{
//}

///Permite ao usuário criar um vento que oferece velocidade à nuvem
-(void) ventoConfig : (int) velocidadeX{
    CGFloat y = _nuvem.velocity.dy;
    [_nuvem setVelocity:CGVectorMake(velocidadeX, y)];
    [self setRegiao:[[SKRegion alloc]initWithSize:CGSizeMake(10, 10)] ];
    //self setPosition:CGSizeMake(<#CGFloat width#>, <#CGFloat height#>);
}


///define o objeto alocado no Campo (ex: obstáculo, nuvem, etc...)
/*-(void) interacaoObjeto : (NSString *) tipo{
    if(tipo == @"Vento"){
        [self]
    }
}*/
@end
