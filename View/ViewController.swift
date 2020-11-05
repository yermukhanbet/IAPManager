//
//  ViewController.swift
//  IAPHandler
//
//  Created by HANTEOGLOBAL on 11/5/20.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        button.setTitle("Buy", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        view.addSubview(button)
        view.backgroundColor = .white
    }
    @objc func buttonTouched(){
        IAPManager.shared.fetchProducts(yourId: ProductID)
    }
}

