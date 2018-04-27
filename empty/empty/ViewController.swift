//
//  ViewController.swift
//  empty
//
//  Created by Krystian Kulawiak on 16/04/2018.
//  Copyright © 2018 Krystian Kulawiak. All rights reserved.
//

import UIKit
import ChameleonFramework

class ViewController: UIViewController, UINavigationControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
        navigationItem.title = "Menu"
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.bookmarks, target: self, action: #selector(action))
        let plus = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(actionsecond))
        navigationItem.rightBarButtonItems = [button,plus]
    }
    
    @objc func action(){
        let vc = TableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func actionsecond(){
        let vc = SecondTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController{
    
    func setupView(){
        let myView = UIView()
        let screan = UIScreen.main.bounds
        let color = UIColor(gradientStyle: UIGradientStyle.diagonal, withFrame: screan, andColors: [UIColor.flatSkyBlue,UIColor.flatWatermelon])
        color.flatten()
        myView.backgroundColor = color
        self.view.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
        let viewsDictionary:[String : Any] = ["myView":myView]
        let constraints: [NSLayoutConstraint] = [
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[myView]|", options: [], metrics: nil, views: viewsDictionary),
             NSLayoutConstraint.constraints(withVisualFormat: "V:|[myView]|", options: [], metrics: nil, views: viewsDictionary),
             ].flatMap{$0}
        NSLayoutConstraint.activate(constraints)
        
        view.layoutIfNeeded()
    }
    
}

