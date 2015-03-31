//
//  ELake.h
//  Rain Society
//
//  Created by Jucelio Fonseca on 31/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSSprite.h"
#import "RSMap.h"
#import "ECloud.h"
@interface ELake : RSSprite
//Property that show if is possible to spawn a cloud or not
@property (nonatomic) BOOL spawnCloud;

-(id) initWithPosition: (CGPoint) position;

@end
