//
//  PoblacionViewController.h
//  iNeedClass
//
//  Created by Jesus Victorio on 14/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoblacionViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>{
    
    NSMutableArray *array;
    NSMutableArray *identificador;
    UIPickerView *poblacion;
    NSString *poblacionApasar;
    IBOutlet UIActivityIndicatorView *activity;
    IBOutlet UIView *vistacarga;
}

@property(nonatomic, strong)IBOutlet UIPickerView *poblacion;

@property (nonatomic, retain) NSString *TextoPasar;

@end
