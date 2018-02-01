//
//  TemplateViewController.swift
//  Longpops
//
//  Created by martin on 14.01.18.
//

import Foundation
import UIKit

class TemplateViewController: UIViewController, UITextFieldDelegate {
    
    var headingContainerView: UIView
    var descriptionContainerView: UIView
    var gradientLayer: CAGradientLayer
    
    var headingLabel: UILabel
    var descriptionLabel: UILabel
    
    init() {
        self.headingContainerView = UIView()
        self.descriptionContainerView = UIView()
        self.gradientLayer = CAGradientLayer()
        self.headingLabel = UILabel()
        self.descriptionLabel = UILabel()

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createBackgroundGradient()
        self.setupViews()
        self.setupConstraints()
    }
    
    func setupViews() {
        
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
    
    func setupConstraints() {
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
    
    func createBackgroundGradient() {
        let bottomColor = UIColor(red:0.83, green:0.08, blue:0.35, alpha:1.0).cgColor
        let topColor = UIColor(red:0.98, green:0.69, blue:0.23, alpha:1.0).cgColor
        
        self.gradientLayer.frame = self.view.frame
        self.gradientLayer.colors = [topColor, bottomColor]
        self.gradientLayer.locations = [0.1,1.0]
        self.view.layer.insertSublayer(self.gradientLayer, at: 0)
    }
    
    
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
