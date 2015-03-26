//
//  RSContainer.m
//  GameZAM
//
//  Created by Jucelio Fonseca on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSContainer.h"

@implementation RSContainer

-(id)initWithColor:(UIColor*)color{
    
    RSContainer* container = [[RSContainer alloc] init];
    [container setUserInteractionEnabled:true];
    [container setColor:color];
    
    return container;
}

-(id)init{
    self = [super init];
    [self setUserInteractionEnabled:true];
    
    return self;
}
@end