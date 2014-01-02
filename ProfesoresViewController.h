//
//  ProfesoresViewController.h
//  iNeedClass
//
//  Created by Jesus Victorio on 17/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>

@interface ProfesoresViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>{
    
    IBOutlet UIView *datosIntercambio;
    IBOutlet UIView *vistaClases;
    IBOutlet UIView *vistaIntercambios;
    
    IBOutlet UITableView *tableView;
    IBOutlet UIView *datos;
    IBOutlet UIView *academia;
    
    IBOutlet UIImageView *leyenda;
    IBOutlet UIImageView *leyendaIntercambio;
    
    IBOutlet UIBarButtonItem *profesores;
    
    NSMutableArray *nombres;
    NSMutableArray *identificador;
    NSMutableArray *precios;
    NSMutableArray *tipos;
    NSMutableArray *identificadorUsuarioIntercambios;
    NSMutableArray *identificadorRelacionIntercambios;
    NSMutableArray *materiaIntercambio1;
    NSMutableArray *materiaIntercambio2;
    NSMutableArray *nombresIntercambio;
    
    NSString *usuarioApasar;
    NSString *relacionApasar;
    NSString *materiaIntercambio;
    
    //Academias
    IBOutlet UILabel *mailAcademia;
    IBOutlet UITextView *comentariosAcademia;
    IBOutlet UILabel *telefonoAcademia;
    IBOutlet UILabel *nombreAcademia;
    IBOutlet UILabel *precioAcademia;
    IBOutlet UIButton *llamarA;
    
    //Particular
    IBOutlet UILabel *usuarioLabel;
    IBOutlet UILabel *titulacionLabel;
    IBOutlet UITextView *comentariosLabel;
    IBOutlet UILabel *nivelLabel;
    IBOutlet UILabel *precioLabel;
    IBOutlet UILabel *etiquetaNivel;
    IBOutlet UIButton *llamarP;
    
    IBOutlet UIImageView *imagenDeFondo;
    
    //intercambios
    IBOutlet UILabel *demandaIntercambio;
    IBOutlet UITextView *comentariosIntercambio;
    IBOutlet UILabel *ofertaIntercambio;
    IBOutlet UIButton *llamarI;
    
    IBOutlet UITabBar *tabbar;
    IBOutlet UITabBarItem *tabIntercambios;
    IBOutlet UITabBarItem *tabClasesParticulares;
    
    IBOutlet UIActivityIndicatorView *activity;

}

@property (nonatomic, retain) NSString *provincia;

@property (nonatomic, retain) NSString *poblacion;

@property (nonatomic, retain) NSString *idioma;

@property (nonatomic, retain) NSString *tipo;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *profesores;

- (IBAction)compartir:(id)sender;

- (IBAction)enviarMail:(id)sender;

- (IBAction)llamarIntercambios:(id)sender;

- (IBAction)pulsaFavoritos:(id)sender;

@end
