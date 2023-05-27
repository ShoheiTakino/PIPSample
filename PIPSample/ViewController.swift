//
//  ViewController.swift
//  PIPSample
//
//  Created by 滝野翔平 on 2023/05/27.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBAction
    
    @IBAction private func tappedPresentNextButton() {
        let vc = PIPViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

