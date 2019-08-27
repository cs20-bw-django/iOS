//
//  ViewController.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var infiniteGrid: InfiniteGrid?

    @IBOutlet var descriptionView: UIView!
    @IBOutlet var controlStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.infiniteGrid = InfiniteGrid(hostView: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        infiniteGrid?.infiniteDataSource.roomsArray = [GridCoordinates(x: 0, y: 0), GridCoordinates(x: 2, y: 0), GridCoordinates(x: 0, y: 2), GridCoordinates(x: -2, y: 0), GridCoordinates(x: 0, y: -2)]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        infiniteGrid?.scrollToCenter()
        
        setupUI()
        
    }
    
    func setupUI(){
        
        let margins = view.layoutMarginsGuide
        
        // Add room description view and position bottom-left
        descriptionView.backgroundColor = #colorLiteral(red: 0.3246651888, green: 0.3246651888, blue: 0.3246651888, alpha: 1)
        descriptionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.7, height: self.view.frame.height * 0.1)
        self.view.addSubview(descriptionView)
        descriptionView.center = CGPoint(x: self.view.center.x - 120, y: (self.view.center.y + self.view.frame.height * 0.4))
        descriptionView.layer.cornerRadius = 8.0
        
        // Add and position player controls
        
        
        controlStack.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        let controlBgView = UIView(frame: CGRect(x: self.view.frame.width - controlStack.frame.width, y: self.view.frame.height - controlStack.frame.height, width: controlStack.frame.width, height: controlStack.frame.height))
        controlBgView.backgroundColor = .white
        controlBgView.layer.cornerRadius = 8.0
        self.view.addSubview(controlBgView)
        self.view.addSubview(controlStack)
        controlStack.backgroundColor = .white
        controlStack.center = CGPoint(x: controlBgView.center.x, y: controlBgView.center.y)
//
//        controlStack.translatesAutoresizingMaskIntoConstraints = false
//        controlStack.topAnchor.constraint(equalTo: margins.bottomAnchor, constant: -controlStack.frame.height).isActive = true
//        controlStack.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0).isActive = true
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
