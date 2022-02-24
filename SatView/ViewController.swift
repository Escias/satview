//
//  ViewController.swift
//  SatView
//
//  Created by Jimmy Lai on 23/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let test = ApiSat.apiSat.getByName(name: "HST")
        print("nous sommes maintenant ici : ")
        print(test)
    }


}

