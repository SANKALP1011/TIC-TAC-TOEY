//
//  GameViewController.swift
//  TIC-TAC-TOEY
//
//  Created by Sankalp Pandey on 13/07/21.
//

import UIKit

class GameViewController: UIViewController {
    var name: String!
    var lastValue = "o"
    var playerChoices: [BOX] = []
    var computeChoices: [BOX] = []
    @IBOutlet weak var imagevIEW2: UIView!
    
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var BOX1: UIImageView!
    @IBOutlet weak var BOX2: UIImageView!
    @IBOutlet weak var BOX3: UIImageView!
    @IBOutlet weak var BOX4: UIImageView!
    @IBOutlet weak var BOX5: UIImageView!
    @IBOutlet weak var BOX6: UIImageView!
    @IBOutlet weak var BOX7: UIImageView!
    @IBOutlet weak var BOX8: UIImageView!
    @IBOutlet weak var BOX9: UIImageView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
         improveUI()
        nameLabel.text = name
        createTap(on: BOX1, type: .one)
        createTap(on: BOX2, type: .two)
        createTap(on: BOX3, type: .tnree)
        createTap(on: BOX4, type: .four)
        createTap(on: BOX5, type: .five)
        createTap(on: BOX6, type: .six)
        createTap(on: BOX7, type: .seven)
        createTap(on: BOX8, type: .eight)
        createTap(on: BOX9, type: .nine)
    }
 
    func createTap(on imageView: UIImageView, type box: BOX){
        let tap = UITapGestureRecognizer(target: self, action: #selector(boxClicked(_:)))
        tap.name = box.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
         
    }
    
    @objc func boxClicked(_ sender: UITapGestureRecognizer){
        let selectedBox = getBox(from: sender.name!)
        makeChoice(selectedBox)
        playerChoices.append(BOX(rawValue: sender.name!)!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.computerPlay()
        }
        scoreLabel.text = ""
    }
    
    func computerPlay(){
        var availableSpaces = [UIImageView]()
        var availabelboxes = [BOX]()
        for name in BOX.allCases{
            let box = getBox(from: name.rawValue)
            if box.image == nil {
                availableSpaces.append(box)
                availabelboxes.append(name)
            }
        }
        guard availabelboxes.count > 0 else{
            return
        }
        let randomIndex = Int.random(in: 0 ..< availableSpaces.count)
        makeChoice(availableSpaces[randomIndex])
        computeChoices.append(availabelboxes[randomIndex])
        ifWon()
    }
    
    func makeChoice(_ selectedBox: UIImageView){
        guard selectedBox.image == nil else{
            return
        }
        if lastValue == "x"{
            selectedBox.image = #imageLiteral(resourceName: "icons8-circled")
            lastValue = "o"
        }
        else{
            selectedBox.image = #imageLiteral(resourceName: "icons8-multiply")
            lastValue = "x"
        }
    }
    
    func ifWon(){
        var correct = [[BOX]]()
        
        let topRow: [BOX] = [.one , .two , .tnree]
        let midrow: [BOX] = [.four , .five , .six]
        let bottomRow: [BOX] = [.seven , .eight , .nine]
        
        let firstCol: [BOX] = [.one , .four , .seven]
        let secondCol: [BOX] = [.two , .five , .eight]
        let thirdCol: [BOX] = [.tnree , .six , .nine]
        
        let forwardSlash: [BOX] = [.one , .five , .nine]
        let backwardSlash: [BOX] = [.tnree, .five , .seven]
        
        correct.append(topRow)
        correct.append(midrow)
        correct.append(bottomRow)
        correct.append(firstCol)
        correct.append(secondCol)
        correct.append(thirdCol)
        correct.append(backwardSlash)
        correct.append(forwardSlash)
        
        for valid in correct{
            let userchoices = playerChoices.filter { valid.contains($0)}.count
            let computetChoice = computeChoices.filter{ valid.contains($0)}.count
            
            if userchoices == valid.count{
                scoreLabel.text = "YOU WON !!!"
                resetGame()
            }
            else if computetChoice == valid.count{
                scoreLabel.text = "YOU LOOSE !!!"
                resetGame()
            }
            else if computeChoices.count + playerChoices.count == 9{
                scoreLabel.text = "GAME DRAW!!!"
                resetGame()
            }
        }
        
    
    }
    
    func resetGame(){
        for name in BOX.allCases{
            let box = getBox(from: name.rawValue)
            box.image = nil
        }
        lastValue = "o"
        playerChoices = []
        computeChoices = []
        
    }
    
    func getBox(from name: String) -> UIImageView{
        let box = BOX(rawValue: name) ?? .one
        switch box {
        case .one:
        return BOX1
        case .two:
            return BOX2
        case .tnree:
            return BOX3
        case .four:
            return BOX4
        case .five:
            return BOX5
        case .six:
            return BOX6
        case .seven:
            return BOX7
        case .eight:
            return BOX8
        case .nine:
            return BOX9
            
        }
    }
    
    func improveUI(){
        imagevIEW2.layer.cornerRadius = 20
        imagevIEW2.layer.shadowOpacity = 0.4
        imagevIEW2.layer.shadowColor = UIColor.black.cgColor
        imagevIEW2.layer.shadowRadius = 20
        imagevIEW2.layer.shadowOffset = .zero
        gameView.layer.cornerRadius = 20
        gameView.layer.shadowOpacity = 0.4
        gameView.layer.shadowColor = UIColor.black.cgColor
        gameView.layer.shadowRadius = 20
        gameView.layer.shadowOffset = .zero
        
    }
    

   
    

}
enum BOX: String , CaseIterable{
    case one, two, tnree, four, five, six, seven, eight, nine
}
