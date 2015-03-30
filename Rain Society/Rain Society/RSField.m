//
//  Field.m
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/26/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSField.h"

@implementation RSField

-(id) initWithTemperature : (int) temperature Pressure: (int) pressure Wind: (int) wind{
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

- (NSString *)description
{
    return [NSString stringWithFormat:@"temperature,pressure, wind,region: (%d, %d, %d, (%f,%f,%f,%f))", self.temperature, self.pressure, self.wind, self.region.origin.x, self.region.origin.y, self.region.size.width,self.region.size.height];
}


@end
