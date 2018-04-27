//
//  SecondTableViewController.swift
//  empty
//
//  Created by Krystian Kulawiak on 19/04/2018.
//  Copyright © 2018 Krystian Kulawiak. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import FirebaseDatabase
import RealmSwift
import PMAlertController




class SecondTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UINavigationControllerDelegate{
    
    private var myTableView: UITableView!
    var items: Results<Model>
    var check: Results<Model>
    var isFirstDownlad = true
    var selectedItem: [Model] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
        navigationItem.title = "Notatki"
        let addd = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(add))
        let savee = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItems = [addd,savee]
    }
    
    @objc func add(){
        var name = ""
        let alertVC = PMAlertController(title: "Dodaj wpis", description: "", image: nil, style: .alert)
        alertVC.addTextField { (textField) in
            textField?.placeholder = "name"
        }
        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
            
        }))
        
        alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
            name = (alertVC.textFields.first?.text)!
            self.addUser(name: name)
        }))
        
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.items = uiRealm.objects(Model.self).sorted(byKeyPath: "text", ascending: false)
        self.check = uiRealm.objects(Model.self)
        super.init(coder: aDecoder)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)  {
        self.items = uiRealm.objects(Model.self).sorted(byKeyPath: "text", ascending: false)
        self.check = uiRealm.objects(Model.self)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
        grabData()
        ifDelate()
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        let screan = UIScreen.main.bounds
        let color = UIColor(gradientStyle: UIGradientStyle.diagonal, withFrame: screan, andColors: [UIColor.flatSkyBlue,UIColor.flatWatermelon])
        view.backgroundColor = color
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = .clear
        myTableView.tableFooterView = UIView()
        self.view.addSubview(myTableView)
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
        choseItem(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        let item = items[indexPath.row]
        cell.textLabel!.text = item.text
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    func grabData(){
        let dataBaseRef = Database.database().reference()
        dataBaseRef.child("Model").child("first").observe( .value) { (snapshot) in
            //print(snapshot)
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                guard let dictionary = snap.value as? [String : AnyObject] else {
                    return
                }
                let name = dictionary["name"] as? String
                let zmienna = self.shouldAppend(text: snap.key, name: name!)
                if zmienna{
                    let UserToAdd = Model()
                    UserToAdd.id = snap.key
                    UserToAdd.text = name
                    UserToAdd.writeToRealm()
                    self.items = uiRealm.objects(Model.self).sorted(byKeyPath: "text", ascending: false)
                    self.myTableView.reloadData()
                }
            }
        }
    }
    func ifDelate(){
        var name = ""
        let dataBaseRef = Database.database().reference()
        dataBaseRef.child("Model").child("first").observeSingleEvent(of: .childRemoved, with: { (snapshot) in
            print(snapshot)
            let value = snapshot.value as? NSDictionary
            name = value?["name"] as? String ?? ""
            let tryDelate = self.shouldDelate(text: snapshot.key, name: name)
            tryDelate?.delate()
            self.items = uiRealm.objects(Model.self).sorted(byKeyPath: "text", ascending: false)
            self.myTableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func shouldAppend(text:String, name:String?) -> Bool{
        
        
        let predicate = NSPredicate(format:"id == %@ && text == %@",text,name!)
        self.check = uiRealm.objects(Model.self).filter(predicate)
        if check.count == 0{
            return true
        }
        else{
            let predicatetwo = NSPredicate(format:"id == %@ && text != %@",text,name!)
            self.check = uiRealm.objects(Model.self).filter(predicatetwo)
            if check.count == 0{
                return true
            }
        }
        return false
    }
    func shouldDelate(text:String, name:String?) -> Model?{
        let predicate = NSPredicate(format:"id == %@ && text == %@",text,name!)
        let tryFind = uiRealm.objects(Model.self).filter(predicate)
        if tryFind.count == 1{
            return tryFind.last
        }
        return nil
    }
    func addUser(name:String){
        let ref = Database.database().reference()
        let key = ref.child("Model").child("first").childByAutoId().key
        let post = ["name": name] as [String : Any]
        let childUpdates = ["/Model/first/\(key)": post]
        ref.updateChildValues(childUpdates)
    }
    
    func choseItem(row: Int){
        let item = items[row]
        selectedItem.append(item)
    }
    
    @objc func save(){
        let model = ListModel()
        model.id = "asdzxcczxaa"
        try! uiRealm.write {
            model.list.append(objectsIn: selectedItem)
            uiRealm.add(model)
        }
    }
}
