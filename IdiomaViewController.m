//
//  IdiomaViewController.m
//  iNeedClass
//
//  Created by Jesus Victorio on 15/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "IdiomaViewController.h"
#import "ProfesoresViewController.h"
#import "MateriaViewController.h"
#import "ViewController.h"

@interface IdiomaViewController (){
    NSArray *parapicker;
}

@end

@implementation IdiomaViewController
@synthesize poblacion, provincia, idioma, tipo;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //inicialización de variables
    
    materiaApasar=@"";
    
    array=[[NSMutableArray alloc]init];
    identificador=[[NSMutableArray alloc]init];
    
    ViewController *vistafuncional = [[ViewController alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       //do something expensive
                       parapicker=[vistafuncional leerConsultaMysql2:3 texto:poblacion texto2:tipo];
                       
                       //int cont=0;
                       for (int cont=0;cont<[parapicker count];cont++) {
                           
                           [identificador addObject:[[parapicker objectAtIndex:cont] objectForKey:@"id"]];
                           
                           NSString *prov=[[parapicker objectAtIndex:cont] objectForKey:@"nombre"];
                           prov=[prov stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
                           prov=[prov stringByReplacingOccurrencesOfString:@"%30" withString:@"ñ"];
                           
                           [array addObject:prov];
                           
                       }
                       //dispatch back to the main (UI) thread to stop the activity indicator
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          [activity stopAnimating];
                                          activity.hidden=YES;
                                          [idioma reloadAllComponents];
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
    materiaApasar=[[NSString alloc]initWithString:[identificador objectAtIndex:row]];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"aTipo"]) {
        MateriaViewController *segundoView = [segue destinationViewController];
        segundoView.poblacion = poblacion;
        segundoView.provincia = provincia;
    }
    if ([[segue identifier] isEqualToString:@"paProfesores"]) {
        ProfesoresViewController *segundoView = [segue destinationViewController];
        if([materiaApasar isEqual:@""]){
            materiaApasar=[[NSString alloc]initWithString:[identificador objectAtIndex:0]];
        }
        //NSLog(@"idmateria: %@", materiaApasar);
        segundoView.tipo=tipo;
        segundoView.idioma = materiaApasar;
        segundoView.poblacion = poblacion;
        segundoView.provincia = provincia;
    }
}


@end
