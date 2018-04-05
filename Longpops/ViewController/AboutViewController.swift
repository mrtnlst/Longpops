//
//  AboutViewController.swift
//  Sticky Reminders
//
//  Created by martin on 15.11.17.
//

import UIKit

class AboutViewController: TemplatePageViewController {
    
    var twitterContainerView: UIView
    var websiteContainerView: UIView
    var backButtonContainerView: UIView
    var versionContainerView: UIView
    var descriptionContainerView: UIView
    
    var twitterButton: UIButton
    var twitterImage: UIImageView
    var websiteButton: UIButton
    var websiteImage: UIImageView
    var backButton: BackButton
    var twitterURL: URL
    var websiteURL: URL
    var versionLabel: UILabel
    var descriptionLabel: UILabel
    
    override init() {
        self.twitterContainerView = UIView()
        self.websiteContainerView = UIView()
        self.backButtonContainerView = UIView()
        self.versionContainerView = UIView()
        self.descriptionContainerView = UIView()
        
        self.twitterButton = UIButton(type: .system)
        self.twitterImage = UIImageView()
        self.websiteImage = UIImageView()
        self.websiteButton = UIButton(type: .system)
        self.backButton = BackButton()
        self.twitterURL = URL(string: "https://twitter.com/mrtnlst")!
        self.websiteURL = URL(string: "https://martinlist.org")!
        self.versionLabel = UILabel()
        self.descriptionLabel = UILabel()

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupViews()
        setupConstraints()
        setupGestures()
    }
    
    override func setupViews() {
        super.setupViews()
        
        // ContainerViews.
        self.descriptionContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.descriptionContainerView)
        
        self.twitterContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.twitterContainerView)
        
        self.websiteContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.websiteContainerView)
        
        self.backButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.backButtonContainerView)
        
        self.versionContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.versionContainerView)
        
        // HeadingLabel + DescriptionLabel
        self.headingLabel.text = NSLocalizedString("heading-label-about", comment: "Heading label.")
        
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.descriptionLabel.textColor = .white
        self.descriptionLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getRegularLabelSizeForDevice(), weight: .regular)
        self.descriptionLabel.lineBreakMode = .byWordWrapping
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textAlignment = .left
        self.descriptionLabel.text = NSLocalizedString("description-label-about", comment: "Description label.")
        self.descriptionContainerView.addSubview(self.descriptionLabel)

        
        // Twitter.
        self.twitterImage.image = UIImage(named: "Twitter-Logo")
        self.twitterImage.translatesAutoresizingMaskIntoConstraints = false
        self.twitterContainerView.addSubview(self.twitterImage)
        
        self.twitterButton.translatesAutoresizingMaskIntoConstraints = false
        self.twitterButton.setTitle("@mrtnlst", for: .normal)
        self.twitterButton.setTitleColor(.white, for: .normal)
        self.twitterButton.titleLabel?.font = UIFont.systemFont(ofSize: LayoutHandler.getLinkButtonSizeForDevice(), weight: .medium)
        self.twitterButton.addTarget(self, action: #selector(AboutViewController.twitterButtonPressed), for: .touchUpInside)
        self.twitterContainerView.addSubview(self.twitterButton)
        
        // Website.
        self.websiteImage.image = UIImage(named: "Browser")
        self.websiteImage.translatesAutoresizingMaskIntoConstraints = false
        self.websiteContainerView.addSubview(self.websiteImage)
        
        self.websiteButton.translatesAutoresizingMaskIntoConstraints = false
        self.websiteButton.setTitle(" martinlist.org", for: .normal)
        self.websiteButton.setTitleColor(.white, for: .normal)
        self.websiteButton.titleLabel?.font = UIFont.systemFont(ofSize: LayoutHandler.getLinkButtonSizeForDevice(), weight: .medium)
        self.websiteButton.addTarget(self, action: #selector(AboutViewController.websiteButtonPressed), for: .touchUpInside)
        self.websiteContainerView.addSubview(self.websiteButton)
        
        self.backButton.addTarget(self, action: #selector(AboutViewController.backButtonPressed), for: .touchUpInside)
        self.backButtonContainerView.addSubview(self.backButton)
        
        // Version.
        self.versionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.versionLabel.text = "Version 2.1"
        self.versionLabel.textColor = .white
        self.versionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        self.versionLabel.textAlignment = .center
        self.versionContainerView.addSubview(self.versionLabel)
    }

    func setupGestures() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let viewsDictionary: [String: Any] = [
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
            "backButtonSize": LayoutHandler.getBackButtonSizeForDevice(),
            "margin": LayoutHandler.getMarginForDevice(),
        ]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.descriptionContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.descriptionContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
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
                self.descriptionContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.headingContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                self.twitterContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.descriptionContainerView.bottomAnchor, multiplier: 1.0),
                
                self.websiteContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.twitterContainerView.bottomAnchor, multiplier: 1.0),

                self.backButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.websiteContainerView.bottomAnchor, multiplier: 1.0),
                
                self.versionContainerView.bottomAnchor.constraintEqualToSystemSpacingBelow(guide.bottomAnchor, multiplier: 0.5),
                ])
            
        }
        
        // MARK: Description Constraints
        self.descriptionContainerView.addConstraint(NSLayoutConstraint(item: self.descriptionLabel,
                                                                       attribute: .centerX,
                                                                       relatedBy: .equal,
                                                                       toItem: self.descriptionContainerView,
                                                                       attribute: .centerX,
                                                                       multiplier: 1.0,
                                                                       constant: 0.0))
        
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[descriptionLabel]-(margin)-|",
                                                                                    options: [],
                                                                                    metrics: metricsDictionary,
                                                                                    views: viewsDictionary))
        
        self.descriptionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[descriptionLabel]-|",
                                                                                    options: [],
                                                                                    metrics: [:],
                                                                                    views: viewsDictionary))
        
        // MARK: TwitterContainerView Constraints
        self.twitterContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[twitterImage(imageSize)]-[twitterButton]-(>=1)-|",
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
        
        // MARK: WebsiteContainerView Constraints
        self.websiteContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[websiteImage(imageSize)]-[websiteButton]-(>=1)-|",
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
        
        // MARK: BackButtonContainerView Constraints
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
        
        // MARK: VersionContainerView Constraints
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
    
    // MARK: Button Actions.
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
    
    // MARK: Gestures Handeling.
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.down {
            dismiss(animated: true, completion: nil)
        }
    }
}
