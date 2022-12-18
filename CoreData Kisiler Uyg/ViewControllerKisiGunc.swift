//
//  ViewControllerKisiGunc.swift
//  CoreData Kisiler Uyg
//
//  Created by Hüdahan Altun on 19.09.2022.
//

import UIKit

class ViewControllerKisiGunc: UIViewController {

    let contexxtKisiGunc = appDelegatee.persistentContainer.viewContext
    
    @IBOutlet weak var kisiAdTextfield: UITextField!
    
    @IBOutlet weak var kisiTelTextField: UITextField!
    
    var KisiGünc:Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let k = KisiGünc{
            
            kisiAdTextfield.text = k.kisi_ad
            kisiTelTextField.text = k.kisi_tel
        }
    }
    
    @IBAction func KisiGüncelle(_ sender: Any) {
        
        
        if let GüncellenecekKisi = KisiGünc,let kad = kisiAdTextfield.text, let ktel = kisiTelTextField.text{
            
            GüncellenecekKisi.kisi_ad = kad
            GüncellenecekKisi.kisi_tel = ktel
            
            
            let alertcontroller = UIAlertController(title: "Başarılı", message: "Kişi Güncelleme başarılı", preferredStyle: .alert)
            
            let tamam = UIAlertAction(title: "Tamam", style: .default)
            
            alertcontroller.addAction(tamam)
            
            self.present(alertcontroller, animated: true)
            
        }else{
            
            let alertcontroller = UIAlertController(title: "Başarısız", message: "Kişi güncelleme Başarısız", preferredStyle: .alert)
            
            let tamam = UIAlertAction(title: "Tamam", style: .default)
            
            alertcontroller.addAction(tamam)
            
            self.present(alertcontroller, animated: true)
        }
        
        
        appDelegatee.saveContext()
    }
    

}
