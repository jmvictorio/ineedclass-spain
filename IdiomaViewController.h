//
//  IdiomaViewController.h
//  iNeedClass
//
//  Created by Jesus Victorio on 15/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IdiomaViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
    
    NSMutableArray *array;
    NSMutableArray *identificador;
        
    UIPickerView *idioma;
    NSString *materiaApasar;
    
    IBOutlet UIActivityIndicatorView *activity;
    IBOutlet UIView *vistacarga;
    
}

@property(nonatomic, strong)IBOutlet UIPickerView *idioma;

@property (nonatomic, retain) NSString *tipo;

@property (nonatomic, retain) NSString *poblacion;
@property (nonatomic, retain) NSString *provincia;


@end
