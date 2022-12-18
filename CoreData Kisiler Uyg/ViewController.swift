//
//  ViewController.swift
//  CoreData Kisiler Uyg
//
//  Created by Hüdahan Altun on 19.09.2022.
//

import UIKit
import CoreData

let appDelegatee = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {

    let contexxt = appDelegatee.persistentContainer.viewContext
    
    @IBOutlet weak var tableViewKisi: UITableView!
    @IBOutlet weak var searchBarr: UISearchBar!
    
    var KisilerListesi:[Kisiler] = [Kisiler] ()
    
    var aramaYapılıyormu = false
    var aramaKelimesi:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tümKisileriAl()
       
        
        tableViewKisi.delegate = self
        tableViewKisi.dataSource = self
        searchBarr.delegate = self
        
        searchBarr.autocapitalizationType = .none
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if aramaYapılıyormu{
            
            
            aramaYap(kisi_ad: aramaKelimesi!)
            
        }else{
            
            tümKisileriAl()
            
        }
        
        tableViewKisi.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexx = sender as? Int{
            
            
            if segue.identifier == "toDetay"{
                
                let gidilecekVC = segue.destination as! ViewControllerKisiDetay
                
                gidilecekVC.KisiDetay = KisilerListesi[indexx]
                
            }
            
            if segue.identifier == "toGunc"{
                
                let gidilecekVC = segue.destination as! ViewControllerKisiGunc
                
                gidilecekVC.KisiGünc = KisilerListesi[indexx]
                
            }
        }
        
    }
    
    func tümKisileriAl(){
        
        do{
            
            KisilerListesi = try contexxt.fetch(Kisiler.fetchRequest())
            
        }catch{
            
            print("kisiler getirilemedi")
            
        }
    }

    
    func aramaYap (kisi_ad:String){
        
        let fetchRequest:NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "kisi_ad CONTAINS %@", kisi_ad)
        
        do{
            
            KisilerListesi = try contexxt.fetch(fetchRequest)
            
        }catch{
            
            print("kisiler getirilemedi")
            
        }
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return KisilerListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Kisi = KisilerListesi[indexPath.row]
        let cell = tableViewKisi.dequeueReusableCell(withIdentifier: "h1",for:indexPath) as! TableViewCellKisi
        
        cell.labelKisi.text = "\(Kisi.kisi_ad!) - \(Kisi.kisi_tel!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){
            
            (contextualAction,view,boolValue) in
            
            let silinecekKisi = self.KisilerListesi[indexPath.row]
            
            self.contexxt.delete(silinecekKisi)
            
            appDelegatee.saveContext()
            
            if self.aramaYapılıyormu{
                
                
                self.aramaYap(kisi_ad: self.aramaKelimesi!)
                
            }else{
                
                self.tümKisileriAl()
                
            }
            
            self.tableViewKisi.reloadData()
            
        }
        
        let güncelleAction = UIContextualAction(style: .normal, title: "Güncelle"){
            
            (contextualAction,view,boolValue) in
            
            self.performSegue(withIdentifier: "toGunc", sender: indexPath.row)
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [silAction,güncelleAction])
    }
}

extension ViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("aranan sonuc: \(searchText)")
        
        
        aramaKelimesi = searchText
        
        if searchText == ""{
            
            aramaYapılıyormu = false
            
            tümKisileriAl()
            tableViewKisi.reloadData()
            
        }else{
            
            aramaYapılıyormu = true
            
            aramaYap(kisi_ad: aramaKelimesi!)
            
            tableViewKisi.reloadData()
        }
       
    }
}
