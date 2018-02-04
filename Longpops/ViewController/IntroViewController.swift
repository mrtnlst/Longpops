//
//  IntroViewController.swift
//  Longpops
//
//  Created by martin on 04.02.18.
//

import Foundation
import UIKit

class IntroViewController: TemplateViewController, UIScrollViewDelegate {

    let pageControlContainer: UIView
    let scrollView = UIScrollView()
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var pageControl : UIPageControl = UIPageControl()

    override init() {
        self.pageControlContainer = UIView()
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupConstraints()
        self.setupPageControl()
    }

    
    override func setupViews() {
        super.setupViews()
        
        self.headingLabel.text = "Intro"
        self.descriptionLabel.text = "This is an intro"
        
        self.pageControlContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.pageControlContainer)
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.numberOfPages = colors.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 97.0/255, green: 208.0/255, blue: 255.0/255, alpha: 1.0)
        self.pageControlContainer.addSubview(pageControl)
        
        self.scrollView.delegate = self
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.pageControlContainer.addSubview(scrollView)
       
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let viewsDictionary: [String: Any] = [
            "headingContainerView": self.headingContainerView,
            "descriptionContainerView": self.descriptionContainerView,
            "headingLabel": self.headingLabel,
            "descriptionLabel": self.descriptionLabel,
            "scrollView": self.scrollView,
            "pageControlContainer": self.pageControlContainer,
            "pageControl": self.pageControl,
            ]
        
        let metricsDictionary: [String: Any] = [
            "margin": LayoutHandler.getMarginForDevice(),
            ]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.pageControlContainer.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.pageControlContainer.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            ])
        
            NSLayoutConstraint.activate([
                self.pageControlContainer.topAnchor.constraintEqualToSystemSpacingBelow(self.descriptionContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                ])
        
        self.pageControlContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[scrollView]-|",
                                                                                    options: [],
                                                                                    metrics: metricsDictionary,
                                                                                    views: viewsDictionary))
        
        self.pageControlContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[pageControl]-(margin)-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        self.pageControlContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView(300)]-[pageControl]-|",
                                                                                    options: [],
                                                                                    metrics: [:],
                                                                                    views: viewsDictionary))
     self.view.layoutIfNeeded()
    }
    
    func setupPageControl() {
        for index in 0..<4 {
            
            self.frame.origin.x = (self.scrollView.frame.size.width - 32) * CGFloat(index)
            self.frame.size.height = 300
            self.frame.size.width = self.scrollView.frame.size.width - 32
            
            let subView = UIView(frame: self.frame)
            subView.backgroundColor = self.colors[index]
            self.scrollView.addSubview(subView)
        }
        self.scrollView.isPagingEnabled = true
        self.scrollView.contentSize = CGSize(width: (self.scrollView.frame.size.width - 32) * 4, height: self.scrollView.frame.size.height)
        self.pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
    }
    
    // MARK : PageControl Actions
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        self.scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}

