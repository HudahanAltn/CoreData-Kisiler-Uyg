//
//  ViewControllerKisiEkle.swift
//  CoreData Kisiler Uyg
//
//  Created by Hüdahan Altun on 19.09.2022.
//

import UIKit

class ViewControllerKisiEkle: UIViewController {

    let contexxtKisiEkle = appDelegatee.persistentContainer.viewContext
    
    @IBOutlet weak var kisiAdTextField: UITextField!
    
    @IBOutlet weak var kisiTelTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func KisiEkle(_ sender: Any) {
        
        let eklenecekkisi = Kisiler(context: contexxtKisiEkle)
        
        if let kad = kisiAdTextField.text, let ktel = kisiTelTextField.text{
            
            eklenecekkisi.kisi_ad = kad
            eklenecekkisi.kisi_tel = ktel
            
            
            let alertcontroller = UIAlertController(title: "Başarılı", message: "Kişi ekleme başarılı", preferredStyle: .alert)
            
            let tamam = UIAlertAction(title: "Tamam", style: .default)
            
            alertcontroller.addAction(tamam)
            
            self.present(alertcontroller, animated: true)
            
        }else{
            
            let alertcontroller = UIAlertController(title: "Başarısız", message: "Kişi ekleme Başarısız", preferredStyle: .alert)
            
            let tamam = UIAlertAction(title: "Tamam", style: .default)
            
            alertcontroller.addAction(tamam)
            
            self.present(alertcontroller, animated: true)
        }
        
        appDelegatee.saveContext()
    }
    
}
