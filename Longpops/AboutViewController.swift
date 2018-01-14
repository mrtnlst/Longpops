//
//  AboutViewController.swift
//  Sticky Reminders
//
//  Created by martin on 15.11.17.
//

import UIKit

class AboutViewController: UIViewController {
    
    private var headingContainerView: UIView
    private var descriptionContainerView: UIView
    private var twitterContainerView: UIView
    private var websiteContainerView: UIView
    private var backButtonContainerView: UIView
    
    var twitterButton: UIButton
    var twitterImage: UIImageView
    var websiteButton: UIButton
    var websiteImage: UIImageView
    var backButton: UIButton
    var headingLabel: UILabel
    var descriptionLabel: UILabel
    var twitterURL: URL
    var websiteURL: URL
    
    init() {
        self.headingContainerView = UIView()
        self.descriptionContainerView = UIView()
        self.twitterContainerView = UIView()
        self.websiteContainerView = UIView()
        self.backButtonContainerView = UIView()
        
        self.twitterButton = UIButton(type: .system)
        self.twitterImage = UIImageView()
        self.websiteImage = UIImageView()
        self.websiteButton = UIButton(type: .system)
        self.backButton = UIButton()
        self.headingLabel = UILabel()
        self.descriptionLabel = UILabel()
        self.twitterURL = URL(string: "https://twitter.com/mrtnlst")!
        self.websiteURL = URL(string: "https://martinlist.org")!
        
        super.init(nibName: nil, bundle: nil)
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
    
    fileprivate func setupViews() {
        self.headingContainerView.translatesAutoresizingMaskIntoConstraints = false
//        self.headingContainerView.backgroundColor = .blue
        self.view.addSubview(self.headingContainerView)
        
        self.descriptionContainerView.translatesAutoresizingMaskIntoConstraints = false
//        self.descriptionContainerView.backgroundColor = .orange
        self.view.addSubview(self.descriptionContainerView)
        
        self.twitterContainerView.translatesAutoresizingMaskIntoConstraints = false
//        self.twitterContainerView.backgroundColor = .green
        self.view.addSubview(self.twitterContainerView)
        
        self.websiteContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.websiteContainerView)
        
        self.backButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.backButtonContainerView)
        
        self.headingLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.headingLabel.text = "About"
        self.headingLabel.textColor = .white
        self.headingLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        self.headingContainerView.addSubview(self.headingLabel)
        
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.descriptionLabel.text = "Longpops brings the concept of sticky notes to iOS. It's meant to be a fast way to create overdue Reminder items, that stay on your lock screen until they are marked as completed. \nDeveloped and designed by Martin List."
        self.descriptionLabel.textColor = .white
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.descriptionLabel.lineBreakMode = .byWordWrapping
        self.descriptionLabel.numberOfLines = 6
        self.descriptionLabel.textAlignment = .left
        self.descriptionContainerView.addSubview(self.descriptionLabel)
        
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
    }

    func setupConstraints() {
        let viewsDictionary: [String: Any] = [
            "headingContainerView": self.headingContainerView,
            "descriptionContainerView": self.descriptionContainerView,
            "twitterContainerView": self.twitterContainerView,
            "websiteContainerView": self.websiteContainerView,
            "backButtonContainerView": self.backButtonContainerView,
            "headingLabel": self.headingLabel,
            "descriptionLabel": self.descriptionLabel,
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
            self.headingContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.headingContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.descriptionContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.descriptionContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.twitterContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.twitterContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.websiteContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.websiteContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),

            self.backButtonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.backButtonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                self.headingContainerView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
                
                self.descriptionContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.headingContainerView.bottomAnchor, multiplier: 1.0),
                
                self.twitterContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.descriptionContainerView.bottomAnchor, multiplier: 1.0),
                
                self.websiteContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.twitterContainerView.bottomAnchor, multiplier: 1.0),
//
                self.backButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.websiteContainerView.bottomAnchor, multiplier: 1.0),
                ])
            
        }
        
        // MARK: Heading Constraints
        
        self.headingContainerView.addConstraint(NSLayoutConstraint(item: self.headingLabel,
                                                                   attribute: .centerX,
                                                                   relatedBy: .equal,
                                                                   toItem: self.headingContainerView,
                                                                   attribute: .centerX,
                                                                   multiplier: 1.0,
                                                                   constant: 0.0))
        
        self.headingContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[headingLabel]-(>=1)-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        self.headingContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[headingLabel]-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        // MARK: Description Constraints
        
        self.descriptionContainerView.addConstraint(NSLayoutConstraint(item: self.descriptionLabel,
                                                                       attribute: .centerX,
                                                                       relatedBy: .equal,
                                                                       toItem: self.descriptionContainerView,
                                                                       attribute: .centerX,
                                                                       multiplier: 1.0,
                                                                       constant: 0.0))
        
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[descriptionLabel]-(>=1)-|",
                                                                                    options: [],
                                                                                    metrics: metricsDictionary,
                                                                                    views: viewsDictionary))
        
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[descriptionLabel]-|",
                                                                                    options: [],
                                                                                    metrics: metricsDictionary,
                                                                                    views: viewsDictionary))
        
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
