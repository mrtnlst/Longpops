//
//  IntroViewController.swift
//  Longpops
//
//  Created by martin on 04.02.18.
//

import Foundation
import UIKit
import EventKit

class IntroViewController: TemplatePageViewController, UIScrollViewDelegate {

    var pageControlContainer: UIView
    var backButtonContainerView: UIView
    var descriptionContainerView: UIView
    
    var backButton: BackButton
    let scrollView: UIScrollView
    var colors: [UIColor]
    var introViews: [UIView]
    var frame: CGRect
    var pageControl: UIPageControl
    var numberOfPages: CGFloat
    var swipeDown: UISwipeGestureRecognizer
    var descriptionLabel: UILabel

    override init() {
        self.pageControlContainer = UIView()
        self.backButtonContainerView = UIView()
        self.descriptionContainerView = UIView()
        
        self.backButton = BackButton()
        self.scrollView = UIScrollView()
        self.colors = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
        self.introViews = [UIView]()
        self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.pageControl = UIPageControl()
        self.numberOfPages = 3
        self.swipeDown = UISwipeGestureRecognizer()
        self.descriptionLabel = UILabel()

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGestures()
        self.checkForIntro()
        self.setupViews()
        self.setupConstraints()
        self.setupPageControl()
        
        NotificationCenter.default.addObserver(self, selector: #selector(IntroViewController.checkPermission),
                                               name: NSNotification.Name(rawValue: "dismissed"), object: nil)
    }
    
    override func setupViews() {
        super.setupViews()
        
        // ContainerViews.
        self.descriptionContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.descriptionContainerView)
        
        self.backButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.backButtonContainerView)
        
        self.scrollView.delegate = self
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.pageControlContainer.addSubview(scrollView)
        
        // HeadingLabel = DescriptionLabel.
        self.headingLabel.text = NSLocalizedString("heading-label-intro", comment: "Intro label heading.")
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.descriptionLabel.textColor = .white
        self.descriptionLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getRegularLabelSizeForDevice(), weight: .regular)
        self.descriptionLabel.lineBreakMode = .byWordWrapping
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.text = NSLocalizedString("description-label-intro", comment: "Intro description label.")
        self.descriptionContainerView.addSubview(self.descriptionLabel)
        
        // PageControl.
        self.pageControlContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.pageControlContainer)
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.numberOfPages = Int(numberOfPages)
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 97.0/255, green: 208.0/255, blue: 255.0/255, alpha: 1.0)
        self.pageControlContainer.addSubview(pageControl)

        // BackButton.
        self.backButton.addTarget(self, action: #selector(SettingsViewController.backButtonPressed), for: .touchUpInside)
        self.backButtonContainerView.addSubview(self.backButton)
    }
    
    func setupGestures() {
        self.swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture))
        self.swipeDown.direction = .down
        self.view.addGestureRecognizer(self.swipeDown)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let viewsDictionary: [String: Any] = [
            "descriptionLabel": self.descriptionLabel,
            "scrollView": self.scrollView,
            "pageControlContainer": self.pageControlContainer,
            "pageControl": self.pageControl,
            "backButton": self.backButton,
            ]
        
        let metricsDictionary: [String: Any] = [
            "margin": LayoutHandler.getMarginForDevice(),
            "scrollViewHeight": LayoutHandler.getIntroPageScrollViewHeightForDevice(),
            "backButtonSize": LayoutHandler.getBackButtonSizeForDevice()
            ]
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            self.descriptionContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.descriptionContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.pageControlContainer.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.pageControlContainer.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            self.backButtonContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            self.backButtonContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            ])
        
            NSLayoutConstraint.activate([
                self.descriptionContainerView.topAnchor.constraint(equalToSystemSpacingBelow: self.headingContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                self.pageControlContainer.topAnchor.constraint(equalToSystemSpacingBelow: self.descriptionContainerView.bottomAnchor, multiplier: LayoutHandler.getMultiplierForDevice()),
                self.backButtonContainerView.topAnchor.constraint(equalToSystemSpacingBelow: self.pageControlContainer.bottomAnchor, multiplier: 1.0),
                ])
        
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
        
        // MARK: PageControlContainer Constraints
        
        self.pageControlContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[scrollView]-|",
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
        
        // MARK: BackButtonContainer Constraints
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
        
        let margin = LayoutHandler.getPageControlMargin()
        
        for index in 0..<Int(numberOfPages) {
            
            self.frame.origin.x = (self.scrollView.frame.size.width - margin) * CGFloat(index)
            self.frame.size.height = CGFloat(LayoutHandler.getIntroPageScrollViewHeightForDevice())
            self.frame.size.width = self.scrollView.frame.size.width - margin
            
            let subView = UIView(frame: self.frame)

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
        self.scrollView.contentSize = CGSize(width: (self.scrollView.frame.size.width - margin) * numberOfPages, height: self.scrollView.frame.size.height)
        self.pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
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
        tutorialLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getIntroLabelSizeForDevice(), weight: .regular)
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
        
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[simpleTaskImage(width)]-(5)-[tutorialLabel]-|",
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
        
        let permissionContainerView = UIView()
        permissionContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let permissionExplanationLabel = UILabel()
        permissionExplanationLabel.text = NSLocalizedString("permission-explanation-label", comment: "Permission explanation label.")
        permissionExplanationLabel.textColor = .white
        permissionExplanationLabel.font = UIFont.systemFont(ofSize: LayoutHandler.getIntroLabelSizeForDevice(), weight: .regular)
        permissionExplanationLabel.textAlignment = .center
        permissionExplanationLabel.numberOfLines = 0
        permissionExplanationLabel.translatesAutoresizingMaskIntoConstraints = false
        permissionContainerView.addSubview(permissionExplanationLabel)
        
        let askPermissionButton = DefaultButton(title: NSLocalizedString("intro-permission-button-title",
                                                 comment: "Permission Button."))
        askPermissionButton.translatesAutoresizingMaskIntoConstraints = false
        askPermissionButton.addTarget(self, action: #selector(IntroViewController.checkPermission), for: .touchUpInside)
        permissionContainerView.addSubview(askPermissionButton)
        
        subView.addSubview(permissionContainerView)
        
        self.scrollView.addSubview(subView)
        
        let viewsDictionary: [String: Any] = [
            "askPermissionButton": askPermissionButton,
            "permissionExplanationLabel": permissionExplanationLabel,
            "permissionContainerView": permissionContainerView,
            ]
        
        let metricsDictionary: [String: Any] = [
            "space": 20,
            ]
        
        subView.addConstraint(NSLayoutConstraint(item: permissionContainerView,
                                                                 attribute: .centerY,
                                                                 relatedBy: .equal,
                                                                 toItem: subView,
                                                                 attribute: .centerY,
                                                                 multiplier: 1.0,
                                                                 constant: 0.0))
        
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[permissionContainerView]|",
                                                                              options: [],
                                                                              metrics: metricsDictionary,
                                                                              views: viewsDictionary))
        
        subView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=1)-[permissionContainerView]-(>=1)-|",
                                                              options: [],
                                                              metrics: metricsDictionary,
                                                              views: viewsDictionary))
        
        permissionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[askPermissionButton]-|",
                                                              options: [],
                                                              metrics: metricsDictionary,
                                                              views: viewsDictionary))
        
        permissionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[permissionExplanationLabel]-|",
                                                              options: [],
                                                              metrics: metricsDictionary,
                                                              views: viewsDictionary))
        
        permissionContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[askPermissionButton]-(space)-[permissionExplanationLabel]-|",
                                                              options: [],
                                                              metrics: metricsDictionary,
                                                              views: viewsDictionary))
        
    }
    
    // MARK: Permission Handling
    
    @objc override func checkPermission() {
        self.eventStore = EKEventStore()
        self.eventStore.requestAccess(to: EKEntityType.reminder) { (granted, error) -> Void in
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissed"), object: nil)
                if !self.isBeingDismissed {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func checkForIntro() {
        let defaults = UserDefaults.standard
        let showIntro = defaults.bool(forKey: "showIntro2.1")
        
        if !showIntro {
            self.backButton.isHidden = true
            self.swipeDown.isEnabled = false
            defaults.set(true, forKey: "showIntro2.1")
            self.numberOfPages = 4
        }
    }
    
    // MARK: Button Actions.
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        self.dismissIntroViewController()
    }
    
    @objc func backButtonPressed() {
        self.dismissIntroViewController()
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
    
    // MARK: Helper Methods
    func dismissIntroViewController() {
        let defaults = UserDefaults.standard
        let showIntro = defaults.bool(forKey: "showIntro2.1")
        
        if !showIntro {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissed"), object: nil)
        }
        
        if !self.isBeingDismissed {
            dismiss(animated: true, completion: nil)
        }
    }
}

