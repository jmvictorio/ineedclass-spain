//
//  MateriaViewController.h
//  iNeedClass
//
//  Created by Jesus Victorio on 24/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MateriaViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
    
    NSMutableArray *array;
    NSMutableArray *identificador;
    
    NSString *tipoApasar;
    UIPickerView *tipos;
    
    IBOutlet UIActivityIndicatorView *activity;
    IBOutlet UIView *vistacarga;
}


@property(nonatomic, strong)IBOutlet UIPickerView *tipos;

@property (nonatomic, retain) NSString *poblacion;
@property (nonatomic, retain) NSString *provincia;

@end
