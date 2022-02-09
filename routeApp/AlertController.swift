//
//  AlertController.swift
//  routeApp
//
//  Created by Андрей Чистяков on 08.02.2022.
//

import UIKit


extension UIViewController {
    
    func alertAddAdress( title: String, placeholder: String, completion: @escaping(String)-> Void ){
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
         
        let alertOk = UIAlertAction(title: "Ok", style: .default){ (action) in
            
            guard let tfValue = alertController.textFields?.first?.text else { return }
            
            completion(tfValue)
        }
        
        let alertClose = UIAlertAction(title: "Cancel", style: .cancel){ (_) in
            
        }
        
        
        alertController.addTextField { (tf) in
            tf.placeholder = placeholder
        }
        alertController.addAction(alertOk)
        alertController.addAction(alertClose)
        
        present(alertController, animated: true, completion: nil)
    }
    
        
    func alertError(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.addAction(alertOk)
        
        present(alertController, animated: true, completion: nil)
    }
}
