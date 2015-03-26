//
//  RSButton.h
//  GameZAM
//
//  Created by Jucelio Fonseca on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "RSContainer.h"

@interface RSButton: RSContainer

-(id)initWithText:(NSString*) text;
-(void) setText: (NSString*) text;
-(SKLabelNode*) getLabel;

@end
