//
//  ViewController.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

enum Direction {
    case north
    case east
    case west
    case south
}


class ViewController: UIViewController {
    
    let apiController = APIController()
    var state:[GameState] = [] {
        didSet{
            infiniteGrid?.infiniteDataSource.roomsSet!.insert(position)
        }
    }
    
    var direction = Direction.north
    var position = GridCoordinates(x: 0, y: 0)
    var roadPosition = GridCoordinates(x: 0, y: 0)
    
    var infiniteGrid: InfiniteGrid?
    let uiBgColor = #colorLiteral(red: 0.9691255689, green: 0.9698591828, blue: 0.9692392945, alpha: 1)
    
    let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))

    @IBOutlet var descriptionView: UIView!
    @IBOutlet var controlStack: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.infiniteGrid = InfiniteGrid(hostView: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        infiniteGrid?.infiniteDataSource.roomsSet = [GridCoordinates(x: 0, y: 0)]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        infiniteGrid?.scrollToCenter()
        
        setupUI()
        
        // Validate bearer token
        if apiController.bearer == nil {
            performSegue(withIdentifier: "LoginViewModalSegue", sender: self)
        } else {
            
        }
        
    }
    
    func setupUI(){
        
        // Add start adventure (initialize) button
        startButton.layer.cornerRadius = 8.0
        startButton.backgroundColor = .black
        startButton.setTitle("Start Adventure", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        self.view.addSubview(startButton)
        startButton.center = self.view.center
        
        // Add room description view and position bottom-left
        descriptionView.backgroundColor = uiBgColor
        descriptionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.7, height: self.view.frame.height * 0.1)
        self.view.addSubview(descriptionView)
        descriptionView.center = CGPoint(x: self.view.center.x - 120, y: (self.view.center.y + self.view.frame.height * 0.4))
        descriptionView.layer.cornerRadius = 8.0
        
        // Add and position player controls
        controlStack.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        let controlBgView = UIView(frame: CGRect(x: (self.view.frame.width - controlStack.frame.width) - 20,
                                                 y: (self.view.frame.height - controlStack.frame.height) - 20,
                                                 width: controlStack.frame.width,
                                                 height: controlStack.frame.height))
        controlBgView.backgroundColor = uiBgColor
        controlBgView.layer.cornerRadius = 8.0
        self.view.addSubview(controlBgView)
        self.view.addSubview(controlStack)
        controlStack.center = CGPoint(x: controlBgView.center.x, y: controlBgView.center.y)
        
    }
    
    func updateUI(){
        guard let currentState = state.last else { fatalError() }
        
        // Add a username, room title, and player list label
        let nameLabel = UILabel(frame: CGRect(x: 40, y: 24, width: 200, height: 60))
        nameLabel.textAlignment = .center
        nameLabel.text = currentState.name
        nameLabel.backgroundColor = uiBgColor
        nameLabel.font = nameLabel.font.withSize(24)
        nameLabel.layer.cornerRadius = 8.0
        nameLabel.layer.masksToBounds = true
        self.view.addSubview(nameLabel)
        
        let roomLabel = UILabel(frame: CGRect(x: self.view.center.x - 150, y: 24, width: 300, height: 60))
        roomLabel.textAlignment = .center
        roomLabel.text = currentState.title
        roomLabel.backgroundColor = uiBgColor
        roomLabel.font = roomLabel.font.withSize(24)
        roomLabel.layer.cornerRadius = 8.0
        roomLabel.layer.masksToBounds = true
        self.view.addSubview(roomLabel)
        
        let playersLabel = UILabel(frame: CGRect(x: self.view.frame.width - 340, y: 24, width: 300, height: 120))
        playersLabel.textAlignment = .right
        playersLabel.numberOfLines = 0
        playersLabel.text = "Players: " + "\n" + (currentState.players?.joined(separator: "\n"))!
        playersLabel.backgroundColor = .clear
        playersLabel.font = playersLabel.font.withSize(18)
        playersLabel.textColor = .white
        self.view.addSubview(playersLabel)
        
        let roomDescription = currentState.description
        descriptionLabel.text = roomDescription
        startButton.isEnabled = false
        startButton.isHidden = true
        print("This is the update UI func")
    }
    
    // MARK: - Action Handlers
    
    @objc func startButtonTapped(sender: UIButton!) {
        apiController.initialize { (result) in
            if let gameState = try? result.get() {
                DispatchQueue.main.async {
                    print(gameState.description)
                    self.state.append(gameState)
                    self.updateUI()
                }
            }
        }
    }

    @IBAction func upButtonTapped(_ sender: UIButton) {
        // if current room description contains "north" execute, else return
        direction = Direction.north
        calculateMovement()
    }
    @IBAction func downButtonTapped(_ sender: UIButton) {
        direction = Direction.south
        calculateMovement()
    }
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        direction = Direction.east
        calculateMovement()
    }
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        direction = Direction.west
        calculateMovement()
    }
    
    // MARK: - Helper Functions
    
    func calculateMovement() {
        // based on button pressed alter var position
        let xPos = position.x
        let yPos = position.y
        switch direction {
        case .north:
            position = GridCoordinates(x: xPos, y: yPos - 2)
            roadPosition = GridCoordinates(x: xPos, y: yPos - 1)
        case .south:
            position = GridCoordinates(x: xPos, y: yPos + 2)
            roadPosition = GridCoordinates(x: xPos, y: yPos + 1)
        case .east:
            position = GridCoordinates(x: xPos + 2, y: yPos)
            roadPosition = GridCoordinates(x: xPos + 1, y: yPos)
        case .west:
            position = GridCoordinates(x: xPos - 2, y: yPos)
            roadPosition = GridCoordinates(x: xPos - 1, y: yPos)
        }
        
        // Add new position to rooms array then reload grid to display change
        infiniteGrid?.infiniteDataSource.roomsSet?.insert(position)
        infiniteGrid?.infiniteDataSource.roadSet.insert(roadPosition)
        infiniteGrid?.infiniteDataSource.playerCoordinates = position
        infiniteGrid?.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "LoginViewModalSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.apiController = apiController
            }
        }
    }
    

}
