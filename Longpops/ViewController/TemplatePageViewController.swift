//
//  TemplatePageViewController.swift
//  Longpops
//
//  Created by martin on 09.03.18.
//

import UIKit

class TemplatePageViewController: TemplateViewController {
    
    var headingContainerView: UIView
    var descriptionContainerView: UIView
    
    var headingLabel: UILabel
    var descriptionLabel: UILabel
    
    override init() {
        self.headingContainerView = UIView()
        self.descriptionContainerView = UIView()
        self.headingLabel = UILabel()
        self.descriptionLabel = UILabel()
        
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setupViews() {
        
        self.headingContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.headingContainerView)
        
        self.descriptionContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.descriptionContainerView)
        
        self.headingLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.headingLabel.text = "Template"
        self.headingLabel.textColor = .white
        self.headingLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getHeadingFontSizeForDevice(), weight: .semibold)
        self.headingContainerView.addSubview(self.headingLabel)
        
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.descriptionLabel.text = "This is a template."
        self.descriptionLabel.textColor = .white
        self.descriptionLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getRegularLabelSizeForDevice(), weight: .regular)
        self.descriptionLabel.lineBreakMode = .byWordWrapping
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textAlignment = .center
        self.descriptionContainerView.addSubview(self.descriptionLabel)
    }
    
    override func setupConstraints() {
        let viewsDictionary: [String: Any] = [
            "headingContainerView": self.headingContainerView,
            "descriptionContainerView": self.descriptionContainerView,
            "headingLabel": self.headingLabel,
            "descriptionLabel": self.descriptionLabel,
            ]
        
        let metricsDictionary: [String: Any] = [
            "margin": LayoutHandler.getMarginForDevice(),
            ]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.headingContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.headingContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.descriptionContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.descriptionContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                self.headingContainerView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                
                self.descriptionContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.headingContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
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
                                                                                options: .alignAllLastBaseline,
                                                                                metrics: [:],
                                                                                views: viewsDictionary))
        
        self.headingContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[headingLabel]-|",
                                                                                options: [],
                                                                                metrics: [:],
                                                                                views: viewsDictionary))
        
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
