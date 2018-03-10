//
//  TemplatePageViewController.swift
//  Longpops
//
//  Created by martin on 09.03.18.
//

import UIKit

class TemplatePageViewController: TemplateViewController {
    
    var headingContainerView: UIView

    
    var headingLabel: UILabel
    
    override init() {
        self.headingContainerView = UIView()
        self.headingLabel = UILabel()
        
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
        
        self.headingLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.headingLabel.text = "Template"
        self.headingLabel.textColor = .white
        self.headingLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getHeadingFontSizeForDevice(), weight: .semibold)
        self.headingContainerView.addSubview(self.headingLabel)
    }
    
    override func setupConstraints() {
        let viewsDictionary: [String: Any] = [
            "headingContainerView": self.headingContainerView,
            "headingLabel": self.headingLabel,
            ]
        
        let metricsDictionary: [String: Any] = [:]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.headingContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.headingContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                self.headingContainerView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
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
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        self.headingContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[headingLabel]-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
