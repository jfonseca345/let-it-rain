//
//  Field.m
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/26/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSField.h"

@implementation RSField


-(void)setWind:(int) velocity{
    vector_float3 speed = {velocity,_ySpeed,0};
    _wind = [SKFieldNode velocityFieldWithVector:speed];
}

-(void) setRegion: (CGPoint) origin with:(int) dx and:(int) dy{
    _wind.position=origin;
    [_wind.region initWithSize: CGSizeMake((CGFloat)dx, (CGFloat)dy)];
}

-(void) verifyPressure{
    if(_pressure<20) _ySpeed=_pressure/2;
}
@end
