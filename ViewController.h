//
//  ViewController.h
//  iNeedClass
//
//  Created by Jesus Victorio on 10/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ViewController : UIViewController{
    NSArray *rows;
}

@property (retain, nonatomic) NSArray *rows;

- (IBAction)compartir:(id)sender;

-(NSArray *)leerConsultaMysql:(int)opcion texto:(NSString *)string;

-(NSArray *)leerConsultaMysql2:(int)opcion texto:(NSString *)string texto2:(NSString *)string2;

@end
