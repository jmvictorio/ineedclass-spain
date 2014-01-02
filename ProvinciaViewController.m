//
//  ProvinciaViewController.m
//  iNeedClass
//
//  Created by Jesus Victorio on 14/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "ProvinciaViewController.h"
#import "PoblacionViewController.h"
#import "ViewController.h"

@interface ProvinciaViewController (){
    NSArray *parapicker;
}
@end

@implementation ProvinciaViewController
@synthesize provincia;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [activity startAnimating];
    
    ViewController *vistafuncional = [[ViewController alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       //do something expensive
                       parapicker=[vistafuncional leerConsultaMysql:1 texto:@""];
                       valorPasado=@"";
                       array=[[NSMutableArray alloc]init];
                       identificador=[[NSMutableArray alloc]init];
                       
                       //int cont=0;
                       for (int cont=0;cont<[parapicker count];cont++) {
                           
                           [identificador addObject:[[parapicker objectAtIndex:cont] objectForKey:@"idprovincia"]];
                           
                           [array addObject:[[parapicker objectAtIndex:cont] objectForKey:@"provincia"]];
                           
                       }
                       
                       //dispatch back to the main (UI) thread to stop the activity indicator
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          [activity stopAnimating];
                                          activity.hidden=YES;
                                          [provincia reloadAllComponents];
                                          [vistacarga setHidden:YES];
                                                                                });
                   });
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//PICKER METODOS

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    valorPasado=[[NSString alloc]initWithString:[identificador objectAtIndex:row]];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [array count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [array objectAtIndex:row];
}

//PASAR DATOS

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"poblacion"]) {
        PoblacionViewController *segundoView = [segue destinationViewController];
        if([valorPasado isEqual:@""]){
            valorPasado=[[NSString alloc]initWithString:[identificador objectAtIndex:0]];
        }
        segundoView.TextoPasar = valorPasado;

    }
}



@end
