//
//  Field.m
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/26/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSField.h"

@implementation RSField

-(id) initWithProperties : (int) temperature and: (int) pressure and: (int) wind{
    self = [super init];
    self.temperature=temperature;
    self.pressure=pressure;
    self.wind=wind;
    self.sprites = [[NSMutableArray alloc] initWithArray:@[]];
    return self;
}

//-(void) addSprite:(RSSprite*) sprite{
 //   [self.sprites addObject:sprite];
//}

@end
