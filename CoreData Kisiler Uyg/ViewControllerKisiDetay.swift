//
//  ViewControllerKisiDetay.swift
//  CoreData Kisiler Uyg
//
//  Created by Hüdahan Altun on 19.09.2022.
//

import UIKit

class ViewControllerKisiDetay: UIViewController {

    
    @IBOutlet weak var kisiAdLabel: UILabel!
    
    @IBOutlet weak var kisiTelLAbel: UILabel!
    
    var KisiDetay:Kisiler?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let k = KisiDetay{
            
            kisiAdLabel.text = k.kisi_ad
            kisiTelLAbel.text = k.kisi_tel
        }
    }
    

}
