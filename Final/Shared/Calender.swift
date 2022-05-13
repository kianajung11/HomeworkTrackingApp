//
//  Calender.swift
//  Final
//
//  Created by Kiana Jung on 5/8/22.
//

import EventKit
import EventKitUI
import UIKit

class Calender: UIViewController, EKEventViewDelegate{
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc func didTapAdd(){
        let vc = EKEventViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        <#code#>
    }
}
