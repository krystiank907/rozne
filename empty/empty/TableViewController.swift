//
//  TableViewController.swift
//  empty
//
//  Created by Krystian Kulawiak on 16/04/2018.
//  Copyright © 2018 Krystian Kulawiak. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import FirebaseDatabase
import RealmSwift
import PMAlertController




class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UINavigationControllerDelegate{
    
    private var myTableView: UITableView!
    var items: Results<User>
    var check: Results<User>
    var isFirstDownlad = true

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
        navigationItem.title = "Notatki"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(add))
    }
    
    @objc func add(){
        var name = ""
        var age = 0
        let alertVC = PMAlertController(title: "Dodaj wpis", description: "", image: nil, style: .alert)
        alertVC.addTextField { (textField) in
            textField?.placeholder = "name"
        }
        alertVC.addTextField { (textFieldsecond) in
            textFieldsecond?.placeholder = "age"
        }
        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
            
        }))
        
        alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
            age = Int((alertVC.textFields.last?.text)!)!
            name = (alertVC.textFields.first?.text)!
            self.addUser(name: name ,age: age)
        }))
        
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {

        self.items = uiRealm.objects(User.self).sorted(byKeyPath: "name", ascending: false)
        self.check = uiRealm.objects(User.self).sorted(byKeyPath: "name", ascending: false)
        super.init(coder: aDecoder)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)  {
        self.items = uiRealm.objects(User.self).sorted(byKeyPath: "name", ascending: false)
        self.check = uiRealm.objects(User.self).sorted(byKeyPath: "name", ascending: false)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
        grabData()
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        let item = items[indexPath.row]
        cell.textLabel!.text = item.name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    func grabData(){
        let dataBaseRef = Database.database().reference()
        dataBaseRef.child("users").observe( .value) { (snapshot) in
            print(snapshot)
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                guard let dictionary = snap.value as? [String : AnyObject] else {
                    return
                }
                let name = dictionary["name"] as? String
                var age = dictionary["Age"] as? Int
                if age == nil{
                    age = 0
                }
                let zmienna = self.shouldAppend(text: snap.key, name: name!, age: age!)
                if zmienna{
                    let UserToAdd = User()
                    UserToAdd.id = snap.key
                    UserToAdd.name = name
                    UserToAdd.age.value = age
                    UserToAdd.writeToRealm()
                    self.items = uiRealm.objects(User.self).sorted(byKeyPath: "name", ascending: false)
                    self.myTableView.reloadData()
                }
            }
        }
    }
    func shouldAppend(text:String, name:String?, age: Int?) -> Bool{
        
        
        let predicate = NSPredicate(format:"id == %@ && name == %@ && age == %d",text,name!,age!)
        self.check = uiRealm.objects(User.self).filter(predicate)
        if check.count == 0{
            return true
        }
        else{
            let predicatetwo = NSPredicate(format:"id == %@ && name == %@ && age != %d",text,name!,age!)
            self.check = uiRealm.objects(User.self).filter(predicatetwo)
            if check.count == 0{
                return true
            }else{
                let predicatenext = NSPredicate(format:"id == %@ && age == %d && name != %@",text,age!,name!)
                self.check = uiRealm.objects(User.self).filter(predicatenext)
                if check.count == 0{
                    return true
                }
            }
        }
        return false
    }
    func addUser(name:String, age:Int){
        let ref = Database.database().reference()
        let key = ref.child("users").childByAutoId().key
        let post = ["name": name,
                    "Age": age] as [String : Any]
        let childUpdates = ["/users/\(key)": post]
        ref.updateChildValues(childUpdates)
    }
}
