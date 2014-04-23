//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Dylan Jhaveri on 4/23/14.
//  Copyright (c) 2014 Dylan Jhaveri. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView()

@property (nonatomic, strong) BNRLine *currentLine;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    
    if(self){
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    
    return self;
}

- (void)strokeLine:(BNRLine *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;

    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)drawRect:(CGRect)rect
{
    // Draw finished lines in blakc
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines) {
        [self strokeLine:line];
    }
    
    if(self.currentLine){
        //if there is a line currently being drawwn, do so in red
        [[UIColor redColor] set];
        [self strokeLine:self.currentLine];
    }
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    
    //Get location of the touch in the view's coordinate system
    CGPoint location = [t locationInView:self];
    self.currentLine = [[BNRLine alloc] init];
    self.currentLine.begin = location;
    self.currentLine.end = location;
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    
    CGPoint location = [t locationInView:self];
    self.currentLine.end = location;
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    [self.finishedLines addObject:self.currentLine];
    
    self.currentLine = nil;
    
    [self setNeedsDisplay];
}

@end
