//
//  AboutViewController.swift
//  Sticky Reminders
//
//  Created by martin on 15.11.17.
//

import UIKit

class AboutViewController: UIViewController {    
    
    @IBOutlet weak var twitterButton: UIStackView!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var twitterURL = URL(string: "https://twitter.com/mrtnlst")
    var websiteURL = URL(string: "https://martinlist.org")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    fileprivate func setupViews() {
        self.view.backgroundColor = UIColor(red: 255/255, green: 145/255, blue: 97/255, alpha: 1.0)
        
        self.backButton.setImage(UIImage(named: "BackButton"), for: .normal)
        self.backButton.layer.shadowColor = UIColor.black.cgColor
        self.backButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.backButton.layer.shadowOpacity = 0.2
    }

    @IBAction func twitterButtonPressed(_ sender: Any) {
        let options = [UIApplicationOpenURLOptionUniversalLinksOnly : false]
        UIApplication.shared.open(twitterURL!, options: options, completionHandler: nil)
    }
    
    @IBAction func websiteButtonPressed(_ sender: Any) {
        let options = [UIApplicationOpenURLOptionUniversalLinksOnly : false]
        UIApplication.shared.open(websiteURL!, options: options, completionHandler: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
