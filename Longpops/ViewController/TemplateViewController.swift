//
//  TemplateViewController.swift
//  Longpops
//
//  Created by martin on 14.01.18.
//

import Foundation
import UIKit
import EventKit

class TemplateViewController: UIViewController, UITextFieldDelegate {
    
    var gradientLayer: CAGradientLayer
    var eventStore: EKEventStore
    
    init() {
        self.gradientLayer = CAGradientLayer()
        self.eventStore = EKEventStore()

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createBackgroundGradient()
    }
    
    func setupViews() {}
    
    func setupConstraints() {}
    
    func createBackgroundGradient() {
        let bottomColor = UIColor(red:0.83, green:0.08, blue:0.35, alpha:1.0).cgColor
        let topColor = UIColor(red:0.98, green:0.69, blue:0.23, alpha:1.0).cgColor
        
        self.gradientLayer.frame = self.view.frame
        self.gradientLayer.colors = [topColor, bottomColor]
        self.gradientLayer.locations = [0.1,1.0]
        self.view.layer.insertSublayer(self.gradientLayer, at: 0)
    }
    
    @objc func checkPermission() {}
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        self.gradientLayer.frame = self.view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
