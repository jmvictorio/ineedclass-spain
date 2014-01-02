//
//  ProvinciaViewController.h
//  iNeedClass
//
//  Created by Jesus Victorio on 14/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProvinciaViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
    
    NSMutableArray *array;
    NSMutableArray *identificador;
    UIPickerView *provincia;
    NSString *valorPasado;
    IBOutlet UIActivityIndicatorView *activity;
    IBOutlet UIView *vistacarga;
     
}

@property(nonatomic, strong)IBOutlet UIPickerView *provincia;


@end
