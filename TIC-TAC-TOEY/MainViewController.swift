//
//  ViewController.swift
//  TIC-TAC-TOEY
//
//  Created by Sankalp Pandey on 13/07/21.
//

import UIKit


class MainViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var animationView: UIView!
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var cardView: UIView!
    
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         setupUI()
         
        
    }
    
    func setupUI(){
        
        animationView.layer.cornerRadius = 20
        animationView.layer.shadowOpacity = 0.4
        animationView.layer.shadowColor = UIColor.black.cgColor
        animationView.layer.shadowRadius = 20
        animationView.layer.shadowOffset = .zero
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowOpacity = 0.4
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 20
        cardView.layer.shadowOffset = .zero
        playButton.layer.cornerRadius = 20
        playButton.layer.shadowOpacity = 0.4
        playButton.layer.shadowColor = UIColor.black.cgColor
        playButton.layer.shadowRadius = 20
        playButton.layer.shadowOffset = .zero
        
    }
    
  
    
    
    @IBAction func playButtonPrresed(_ sender: UIButton) {
    performSegue(withIdentifier: "goToGame", sender: self )
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? GameViewController
        {
            destinationVC.name = nameText.text
        }
    }
}

