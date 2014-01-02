//
//  InscripcionViewController.h
//  iNeedClass
//
//  Created by Jesus Victorio on 13/04/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InscripcionViewController : UIViewController<UIWebViewDelegate>{
    
    IBOutlet UIWebView *formulario;
    IBOutlet UIActivityIndicatorView *activity;
   

}

@property(nonatomic, readonly) IBOutlet UIWebView *formulario;


@end
