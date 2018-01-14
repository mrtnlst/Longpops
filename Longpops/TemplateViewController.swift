//
//  TemplateViewController.swift
//  Longpops
//
//  Created by martin on 14.01.18.
//

import Foundation
import UIKit

class TemplateViewController: UIViewController {
    
    private var headingContainerView: UIView
    private var descriptionContainerView: UIView
    private var textFieldContainerView: UIView
    private var buttonContainerView: UIView
    private var permissionLabelContainerView: UIView
    
    var headingLabel: UILabel
    var descriptionLabel: UILabel
    
    init() {
        self.headingContainerView = UIView()
        self.descriptionContainerView = UIView()
        self.textFieldContainerView = UIView()
        self.buttonContainerView = UIView()
        self.permissionLabelContainerView = UIView()
        self.headingLabel = UILabel()
        self.descriptionLabel = UILabel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 255.0/255.0, green: 105.0/255.0, blue: 97.0/255.0, alpha: 1.0)
        self.setupViewController()
        self.setupConstraints()
    }
    
    fileprivate func setupViewController() {
        
        self.headingContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.headingContainerView.backgroundColor = .blue
        self.view.addSubview(self.headingContainerView)
        
        self.descriptionContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionContainerView.backgroundColor = .green
        self.view.addSubview(self.descriptionContainerView)
        
        self.headingLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.headingLabel.text = "Template"
        self.headingLabel.textColor = .white
        self.headingLabel.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        self.headingContainerView.addSubview(self.headingLabel)

        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.descriptionLabel.text = "Create overdue Reminders, that stay on your lock screen."
        self.descriptionLabel.textColor = .white
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.descriptionLabel.lineBreakMode = .byWordWrapping
        self.descriptionLabel.numberOfLines = 3
        self.descriptionLabel.textAlignment = .center
        self.descriptionContainerView.addSubview(self.descriptionLabel)
    }
    
    fileprivate func setupConstraints() {
        let viewsDictionary: [String: Any] = [
            "headingContainerView": self.headingContainerView,
            "descriptionContainerView": self.descriptionContainerView,
            "textFieldContainerView": self.textFieldContainerView,
            "buttonContainerView": self.buttonContainerView,
            "permissionLabelContainerView": self.permissionLabelContainerView,
            "headingLabel": self.headingLabel,
            "descriptionLabel": self.descriptionLabel,]
        
        let metricsDictionary: [String: Any] = [
            "headingContainerViewHeight": 50,
            "headingContainerViewWidth": 300
        ]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.headingContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.headingContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.descriptionContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.descriptionContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                self.headingContainerView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),

                self.descriptionContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.headingContainerView.bottomAnchor, multiplier: 1.0),
                ])
            
        }
        
// MARK: HeadingLabel Constraints
        self.headingContainerView.addConstraint(NSLayoutConstraint(item: self.headingLabel, attribute: .centerX, relatedBy: .equal, toItem: self.headingContainerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        self.headingContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[headingLabel]-(>=1)-|", options: [], metrics: metricsDictionary, views: viewsDictionary))
        
        self.headingContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[headingLabel]-|", options: [], metrics: metricsDictionary, views: viewsDictionary))

// MARK: DescriptionLabel Constraints
        self.descriptionContainerView.addConstraint(NSLayoutConstraint(item: self.descriptionLabel, attribute: .centerX, relatedBy: .equal, toItem: self.descriptionContainerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[descriptionLabel]-(>=1)-|", options: [], metrics: metricsDictionary, views: viewsDictionary))
        
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[descriptionLabel]-|", options: [], metrics: metricsDictionary, views: viewsDictionary))
        
      
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
