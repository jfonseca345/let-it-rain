//
//  RSButton.h
//  Rain Society
//
//  Created by Jucelio Fonseca on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "RSContainer.h"

@interface RSButton: RSContainer
//What block button will execute when touched
@property (copy) void (^handler)(void);

//Init button with text
-(id)initWithText:(NSString*) text;
//set text for button
-(void) setText: (NSString*) text;
//Get Label from button to allow modifications
-(SKLabelNode*) getLabel;

@end
