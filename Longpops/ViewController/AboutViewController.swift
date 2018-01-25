//
//  AboutViewController.swift
//  Sticky Reminders
//
//  Created by martin on 15.11.17.
//

import UIKit

class AboutViewController: TemplateViewController {
    
    private var twitterContainerView: UIView
    private var websiteContainerView: UIView
    private var backButtonContainerView: UIView
    private var versionContainerView: UIView
    
    var twitterButton: UIButton
    var twitterImage: UIImageView
    var websiteButton: UIButton
    var websiteImage: UIImageView
    var backButton: UIButton
    var twitterURL: URL
    var websiteURL: URL
    var versionLabel: UILabel
    
    override init() {
        self.twitterContainerView = UIView()
        self.websiteContainerView = UIView()
        self.backButtonContainerView = UIView()
        self.versionContainerView = UIView()
        
        self.twitterButton = UIButton(type: .system)
        self.twitterImage = UIImageView()
        self.websiteImage = UIImageView()
        self.websiteButton = UIButton(type: .system)
        self.backButton = UIButton()
        self.twitterURL = URL(string: "https://twitter.com/mrtnlst")!
        self.websiteURL = URL(string: "https://martinlist.org")!
        self.versionLabel = UILabel()
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255, green: 145/255, blue: 97/255, alpha: 1.0)
        
        setupViews()
        setupConstraints()
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.twitterContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.twitterContainerView)
        
        self.websiteContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.websiteContainerView)
        
        self.backButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.backButtonContainerView)
        
        self.versionContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.versionContainerView)
        
        self.headingLabel.text = "About"
        
        self.descriptionLabel.text = "Longpops brings the concept of sticky notes to iOS. It's meant to be a fast way to create overdue Reminder items, that stay on your lock screen until they are marked as completed. \nDeveloped and designed by Martin List."
        
        self.twitterImage.image = UIImage(named: "Twitter-Logo")
        self.twitterImage.translatesAutoresizingMaskIntoConstraints = false
        self.twitterContainerView.addSubview(self.twitterImage)

        self.websiteImage.image = UIImage(named: "Browser")
        self.websiteImage.translatesAutoresizingMaskIntoConstraints = false
        self.websiteContainerView.addSubview(self.websiteImage)
        
        self.twitterButton.translatesAutoresizingMaskIntoConstraints = false
        self.twitterButton.setTitle("@mrtnlst", for: .normal)
        self.twitterButton.setTitleColor(.white, for: .normal)
        self.twitterButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.twitterButton.addTarget(self, action: #selector(AboutViewController.twitterButtonPressed), for: .touchUpInside)
        self.twitterContainerView.addSubview(self.twitterButton)

        self.websiteButton.translatesAutoresizingMaskIntoConstraints = false
        self.websiteButton.setTitle(" martinlist.org", for: .normal)
        self.websiteButton.setTitleColor(.white, for: .normal)
        self.websiteButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.websiteButton.addTarget(self, action: #selector(AboutViewController.websiteButtonPressed), for: .touchUpInside)
        self.websiteContainerView.addSubview(self.websiteButton)
        
        self.backButton.setImage(UIImage(named: "BackButton"), for: .normal)
        self.backButton.layer.shadowColor = UIColor.black.cgColor
        self.backButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.backButton.layer.shadowOpacity = 0.2
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.addTarget(self, action: #selector(AboutViewController.backButtonPressed), for: .touchUpInside)
        self.backButtonContainerView.addSubview(self.backButton)
        
        self.versionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.versionLabel.text = "Version 1.1"
        self.versionLabel.textColor = .white
        self.versionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.descriptionLabel.textAlignment = .center
        self.versionContainerView.addSubview(self.versionLabel)
    }

    override func setupConstraints() {
        super.setupConstraints()
        
        let viewsDictionary: [String: Any] = [
            "headingContainerView": self.headingContainerView,
            "descriptionContainerView": self.descriptionContainerView,
            "twitterContainerView": self.twitterContainerView,
            "websiteContainerView": self.websiteContainerView,
            "versionContainerView": self.versionContainerView,
            "backButtonContainerView": self.backButtonContainerView,
            "headingLabel": self.headingLabel,
            "descriptionLabel": self.descriptionLabel,
            "versionLabel": self.versionLabel,
            "twitterButton": self.twitterButton,
            "websiteButton": self.websiteButton,
            "backButton": self.backButton,
            "twitterImage": self.twitterImage,
            "websiteImage": self.websiteImage,
            ]
        
        let metricsDictionary: [String: Any] = [
            "imageSize": 25,
            "backButtonSize": 50,
        ]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.twitterContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.twitterContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.websiteContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.websiteContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),

            self.backButtonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.backButtonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.versionContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.versionContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                self.twitterContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.descriptionContainerView.bottomAnchor, multiplier: 1.0),
                
                self.websiteContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.twitterContainerView.bottomAnchor, multiplier: 1.0),

                self.backButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.websiteContainerView.bottomAnchor, multiplier: 1.0),
                
                self.versionContainerView.bottomAnchor.constraintEqualToSystemSpacingBelow(guide.bottomAnchor, multiplier: 0.5),
                ])
            
        }
        
        // MARK: Twitter Button Constraints

        self.twitterContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[twitterImage(imageSize)]-[twitterButton]-(>=1)-|",
                                                                                    options: [],
                                                                                    metrics: metricsDictionary,
                                                                                    views: viewsDictionary))
        
        self.twitterContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[twitterImage(imageSize)]-|",
                                                                                    options: [],
                                                                                    metrics: metricsDictionary,
                                                                                    views: viewsDictionary))
        self.twitterContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[twitterButton]-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        // MARK: Website Button Constraints
        
        self.websiteContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[websiteImage(imageSize)]-[websiteButton]-(>=1)-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        self.websiteContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[websiteImage(imageSize)]-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        self.websiteContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[websiteButton]-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        // MARK: Back Button Constraints
        self.backButtonContainerView.addConstraint(NSLayoutConstraint(item: self.backButton,
                                                                  attribute: .centerX,
                                                                  relatedBy: .equal,
                                                                  toItem: self.backButtonContainerView,
                                                                  attribute: .centerX,
                                                                  multiplier: 1.0,
                                                                  constant: 0.0))
        
        self.backButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[backButton(backButtonSize)]-(>=1)-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
        
        self.backButtonContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[backButton(backButtonSize)]-|",
                                                                               options: [],
                                                                               metrics: metricsDictionary,
                                                                               views: viewsDictionary))
        
        // MARK: Version Label Constraints
        self.versionContainerView.addConstraint(NSLayoutConstraint(item: self.versionLabel,
                                                                      attribute: .centerX,
                                                                      relatedBy: .equal,
                                                                      toItem: self.versionContainerView,
                                                                      attribute: .centerX,
                                                                      multiplier: 1.0,
                                                                      constant: 0.0))
        
        self.versionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[versionLabel]-(>=1)-|",
                                                                                   options: [],
                                                                                   metrics: metricsDictionary,
                                                                                   views: viewsDictionary))
        
        self.versionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[versionLabel]-|",
                                                                                   options: [],
                                                                                   metrics: metricsDictionary,
                                                                                   views: viewsDictionary))
    }
    
    @objc func twitterButtonPressed() {
        if #available(iOS 10.0, *) {
            let options = [UIApplicationOpenURLOptionUniversalLinksOnly : false]
            UIApplication.shared.open(self.twitterURL, options: options, completionHandler: nil)
        }
        else {
            _ = UIApplication.shared.openURL(self.twitterURL)
        }
    }
    
    @objc func websiteButtonPressed() {
        if #available(iOS 10.0, *) {
        let options = [UIApplicationOpenURLOptionUniversalLinksOnly : false]
            UIApplication.shared.open(self.websiteURL, options: options, completionHandler: nil)
        }
        else {
            _ = UIApplication.shared.openURL(self.websiteURL)
        }
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
