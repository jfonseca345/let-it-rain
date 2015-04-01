//
//  RSStepper.h
//  Rain Society
//
//  Created by Jucelio Fonseca on 26/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSContainer.h"

@interface RSStepper : RSContainer

//Init stepper with properties initial Value, min and max Value possible and amount to sum every step
-(id)initWithProperties:(int) initialValue andMinValue:(int)minValue andMaxValue:(int)maxValue andAmount:(int)amount;
//Change the buttons color
-(void) setButtonColor:(UIColor*) color;
//Set Value of Stepper
-(void)setValueLabel:(int) value;
//Get the Value of Label
-(int) getValueLabel;
@end
