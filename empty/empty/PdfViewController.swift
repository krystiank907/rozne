//
//  PdfViewController.swift
//  empty
//
//  Created by Krystian Kulawiak on 24/05/2018.
//  Copyright © 2018 Krystian Kulawiak. All rights reserved.
//

import UIKit
import Foundation
import PDFExporter

class PdfViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {

    @IBOutlet var tableView: UITableView!
     let PDFRenderer: PDFPrintPageRenderer = PDFPrintPageRenderer()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let emptyNib = UINib(nibName: "CellTableViewCell", bundle: nil)
        self.tableView.register(emptyNib, forCellReuseIdentifier: "CellTableViewCellIdentifier")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
        let pdf = UIBarButtonItem(title: "PDF", style: .done, target: self, action: #selector(pdfGenerate))
        navigationItem.leftBarButtonItem = pdf
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableViewCellIdentifier") as! CellTableViewCell
        cell.nameLabel.text = "cxvxvxdfsgvxcvdrsrsdf cxv"
        return cell
    }
    
    func ceratePdf(){
        //PDFRenderer.paperInset = UIEdgeInsetsMake(0, 100.0, 10.0, 80.0)
        PDFRenderer.paperSize = PDFPaperSizeISOA4
        let printView = view
        printView?.bounds = CGRect(x: 0, y: 0, width: 594, height: 842)
        printView?.contentMode = .scaleToFill
        PDFRenderer.contentView = view
        PDFRenderer.shouldSliceViews = true
        PDFRenderer.isScalingContent = true
    }
    
    @objc func pdfGenerate(){
        ceratePdf()
        let previewPdfVC = PreviewPDFViewController(pdfRenderer: PDFRenderer)
        navigationController?.pushViewController(previewPdfVC, animated: true)
    }
}
