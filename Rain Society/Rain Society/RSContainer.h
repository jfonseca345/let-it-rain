//
//  RSContainer.h
//  Rain Society
//
//  Created by Jucelio Fonseca on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface RSContainer : SKSpriteNode

//Attached object to container
@property (nonatomic) id attach;
//Create a container with color
-(id) initWithColor: (UIColor*) color;

@end