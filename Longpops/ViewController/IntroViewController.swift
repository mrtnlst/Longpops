//
//  IntroViewController.swift
//  Longpops
//
//  Created by martin on 04.02.18.
//

import Foundation
import UIKit
import EventKit

class IntroViewController: TemplateViewController, UIScrollViewDelegate {

    private var pageControlContainer: UIView
    private var backButtonContainerView: UIView

    var backButton: UIButton
    let scrollView: UIScrollView
    var colors: [UIColor]
    var introViews: [UIView]
    var frame: CGRect
    var pageControl: UIPageControl
    var eventStore: EKEventStore!
    var numberOfPages: CGFloat

    override init() {
        self.pageControlContainer = UIView()
        self.backButtonContainerView = UIView()
        
        self.backButton = UIButton()
        self.scrollView = UIScrollView()
        self.colors = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
        self.introViews = [UIView]()
        self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.pageControl = UIPageControl()
        self.numberOfPages = 3
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkForIntro()
        self.setupViews()
        self.setupConstraints()
        self.setupPageControl()
        self.setupGestures()
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.headingLabel.text = NSLocalizedString("heading-label-intro", comment: "Intro label heading.")
        self.descriptionLabel.text = NSLocalizedString("description-label-intro", comment: "Intro description label.")
        
        self.pageControlContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.pageControlContainer)
        
        self.backButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.backButtonContainerView)
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.numberOfPages = Int(numberOfPages)
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 97.0/255, green: 208.0/255, blue: 255.0/255, alpha: 1.0)
        self.pageControlContainer.addSubview(pageControl)
        
        self.scrollView.delegate = self
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.pageControlContainer.addSubview(scrollView)
       
        self.backButton.setImage(UIImage(named: "BackButton"), for: .normal)
        self.backButton.layer.shadowColor = UIColor.black.cgColor
        self.backButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.backButton.layer.shadowOpacity = 0.2
        self.backButton.alpha = 0.8
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.addTarget(self, action: #selector(SettingsViewController.backButtonPressed), for: .touchUpInside)
        self.backButtonContainerView.addSubview(self.backButton)
    }
    
    func setupGestures() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
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
            "backButtonContainerView": self.backButtonContainerView,
            "backButton": self.backButton,
            ]
        
        let metricsDictionary: [String: Any] = [
            "margin": LayoutHandler.getMarginForDevice(),
            "backButtonSize": LayoutHandler.getSaveButtonSizeForDevice(),
            "scrollViewHeight": LayoutHandler.getIntroPageScrollViewHeightForDevice(),
            ]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.pageControlContainer.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.pageControlContainer.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.backButtonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.backButtonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            ])
        
            NSLayoutConstraint.activate([
                self.pageControlContainer.topAnchor.constraintEqualToSystemSpacingBelow(self.descriptionContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                self.backButtonContainerView.topAnchor.constraintEqualToSystemSpacingBelow(self.pageControlContainer.bottomAnchor, multiplier: 1.0),
                ])
        
        self.pageControlContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[scrollView]-(margin)-|",
                                                                                    options: [],
                                                                                    metrics: metricsDictionary,
                                                                                    views: viewsDictionary))
        
        self.pageControlContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(margin)-[pageControl]-(margin)-|",
                                                                                options: [],
                                                                                metrics: metricsDictionary,
                                                                                views: viewsDictionary))
        
        self.pageControlContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView(scrollViewHeight)]-[pageControl]-|",
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
        
     self.view.layoutIfNeeded()
    }
    
    func setupPageControl() {
        
        for index in 0..<Int(numberOfPages) {
            
            self.frame.origin.x = (self.scrollView.frame.size.width - 32) * CGFloat(index)
            self.frame.size.height = CGFloat(LayoutHandler.getIntroPageScrollViewHeightForDevice())
            self.frame.size.width = self.scrollView.frame.size.width - 32
            
            let subView = UIView(frame: self.frame)
                subView.backgroundColor = .blue
            switch index {
            case 0:
                self.createSimpleTaskView(subView: subView)
            case 1:
                self.createAdvancedTaskView(subView: subView)
            case 2:
                self.createSettingsView(subView: subView)
            case 3:
                self.createPermissionIntroPage(subView: subView)
            default:
                break
            }
        }
        self.scrollView.isPagingEnabled = true
        self.scrollView.contentSize = CGSize(width: (self.scrollView.frame.size.width - 32) * numberOfPages, height: self.scrollView.frame.size.height)
        self.pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
    }
    
    func createSimpleTaskView(subView: UIView) {
        self.createIntroPageView(subView: subView, image: "SimpleTask", description: "tutorial-label-simpletask")
    }

    func createAdvancedTaskView(subView: UIView) {
        self.createIntroPageView(subView: subView, image: "AdvancedTask", description: "tutorial-label-advancedtask")
    }
    
    func createSettingsView(subView: UIView) {
        self.createIntroPageView(subView: subView, image: "Settings", description: "tutorial-label-settings")
    }
    
    func createIntroPageView(subView: UIView, image: String, description: String) {
        
        let simpleTaskImage = UIImageView()
        simpleTaskImage.image = UIImage(named: image)
        simpleTaskImage.translatesAutoresizingMaskIntoConstraints = false
        subView.addSubview(simpleTaskImage)
        
        let tutorialLabel = UILabel()
        tutorialLabel.text = NSLocalizedString(description, comment: "Tutorial label.")
        tutorialLabel.textColor = .white
        tutorialLabel.textAlignment = .left
        tutorialLabel.numberOfLines = 0
        tutorialLabel.translatesAutoresizingMaskIntoConstraints = false
        subView.addSubview(tutorialLabel)
        
        self.scrollView.addSubview(subView)
        
        
        let viewsDictionary: [String: Any] = [
            "simpleTaskImage": simpleTaskImage,
            "tutorialLabel": tutorialLabel,
            ]
        
        let metricsDictionary: [String: Any] = [
            "width": LayoutHandler.getIntroImageSizeForDevice().0,
            "height": LayoutHandler.getIntroImageSizeForDevice().1,
            ]
        
        subView.addConstraint(NSLayoutConstraint(item: simpleTaskImage,
                                                 attribute: .centerY,
                                                 relatedBy: .equal,
                                                 toItem: subView,
                                                 attribute: .centerY,
                                                 multiplier: 1.0,
                                                 constant: 0.0))
        
        subView.addConstraint(NSLayoutConstraint(item: tutorialLabel,
                                                 attribute: .centerY,
                                                 relatedBy: .equal,
                                                 toItem: subView,
                                                 attribute: .centerY,
                                                 multiplier: 1.0,
                                                 constant: 0.0))
        
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[simpleTaskImage(width)]-(>=5)-[tutorialLabel]-|",
                                                              options: [],
                                                              metrics: metricsDictionary,
                                                              views: viewsDictionary))
        
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[simpleTaskImage(height)]|",
                                                              options: [],
                                                              metrics: metricsDictionary,
                                                              views: viewsDictionary))
        
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=1)-[tutorialLabel]-(>=1)-|",
                                                              options: [],
                                                              metrics: metricsDictionary,
                                                              views: viewsDictionary))
        
    }
    
    func createPermissionIntroPage(subView: UIView) {
        
        let permissionExplanationLabel = UILabel()
        permissionExplanationLabel.text = NSLocalizedString("permission-explanation-label", comment: "Permission explanation label.")
        permissionExplanationLabel.textColor = .white
        permissionExplanationLabel.textAlignment = .center
        permissionExplanationLabel.numberOfLines = 0
        permissionExplanationLabel.translatesAutoresizingMaskIntoConstraints = false
        subView.addSubview(permissionExplanationLabel)
        
        let askPermissionButton = LongpopsButton(title: NSLocalizedString("intro-permission-button-title",
                                                 comment: "Permission Button."))
        askPermissionButton.translatesAutoresizingMaskIntoConstraints = false
        askPermissionButton.addTarget(self, action: #selector(IntroViewController.checkPermission), for: .touchUpInside)
        subView.addSubview(askPermissionButton)
        
        self.scrollView.addSubview(subView)
        
        let viewsDictionary: [String: Any] = [
            "askPermissionButton": askPermissionButton,
            "permissionExplanationLabel": permissionExplanationLabel,
            ]
        
        let metricsDictionary: [String: Any] = [
            "space": 20,
                ]
        
        subView.addConstraint(NSLayoutConstraint(item: askPermissionButton,
                                                 attribute: .centerX,
                                                 relatedBy: .equal,
                                                 toItem: subView,
                                                 attribute: .centerX,
                                                 multiplier: 1.0,
                                                 constant: 0.0))
        
        subView.addConstraint(NSLayoutConstraint(item: permissionExplanationLabel,
                                                 attribute: .centerX,
                                                 relatedBy: .equal,
                                                 toItem: subView,
                                                 attribute: .centerX,
                                                 multiplier: 1.0,
                                                 constant: 0.0))
        
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[askPermissionButton]-|",
                                                              options: [],
                                                              metrics: metricsDictionary,
                                                              views: viewsDictionary))
        
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=1)-[permissionExplanationLabel]-(>=1)-|",
                                                              options: [],
                                                              metrics: metricsDictionary,
                                                              views: viewsDictionary))
        
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=1)-[askPermissionButton]-(space)-[permissionExplanationLabel]-|",
                                                              options: [],
                                                              metrics: metricsDictionary,
                                                              views: viewsDictionary))
        
    }
    
    // MARK: Permission Handling
    
    @objc func checkPermission() {
        self.eventStore = EKEventStore()
        self.eventStore.requestAccess(to: EKEntityType.reminder) { (granted, error) -> Void in
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissed"), object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func checkForIntro() {
        let defaults = UserDefaults.standard
        let showIntro = defaults.bool(forKey: "showIntro")
        
        if !showIntro {
//            defaults.set(true, forKey: "showIntro")
            self.numberOfPages = 4
        }
    }
    
    // MARK: Button actions.
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissed"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func backButtonPressed() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissed"), object: nil)
        dismiss(animated: true, completion: nil)
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

