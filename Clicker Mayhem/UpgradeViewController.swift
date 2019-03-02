//
//  UpgradeViewController.swift
//  Clicker Mayhem
//
//  Created by Randy Le on 2/28/19.
//  Copyright © 2019 Project Koisa. All rights reserved.
//

import UIKit

class UpgradeViewController: UIViewController {
    
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var strengthCostLabel: UILabel!
    @IBOutlet weak var weaponCostLabel: UILabel!
    @IBOutlet weak var armorCostLabel: UILabel!
    @IBOutlet weak var agilityCostLabel: UILabel!
    @IBOutlet weak var strengthButton: UIButton!
    @IBOutlet weak var weaponButton: UIButton!
    @IBOutlet weak var armorButton: UIButton!
    @IBOutlet weak var agilityButton: UIButton!
    
    
    var gold: Int = 0
    var DPS: Int = 0
    var strengthUpgrade: Int = 0
    var weaponUpgrade: Int = 0
    var armorUpgrade: Int = 0
    var agilityUpgrade: Int = 0
    var magicUpgrade: Int = 0
    
    var strengthCost: Int = 100
    var weaponCost: Int = 100
    var armorCost: Int = 100
    var agilityCost: Int = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Display the gold onto view
        updateDisplay()
        checkIfBuyable();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateDisplay()
        checkIfBuyable()
    }

    @IBAction func strengthButtonClicked(_ sender: Any) {
        InformationStats.gold = InformationStats.gold - strengthCost
        
        // Strength Damage Formula Here
        InformationStats.DPS = InformationStats.DPS + (2 * strengthUpgrade + 1)
        
        strengthUpgrade = strengthUpgrade + 1
        
        updateStrengthCost()
        updateDisplay()
        checkIfBuyable()
    }
    
    @IBAction func weaponButtonClicked(_ sender: Any) {
        InformationStats.gold = InformationStats.gold - weaponCost
        InformationStats.DPS = InformationStats.DPS + (5 * weaponUpgrade + 1)
        
        weaponUpgrade = weaponUpgrade + 1
        
        
    }
    @IBAction func armorButtonClicked(_ sender: Any) {
    }
    @IBAction func agilityButtonClicked(_ sender: Any) {
    }

    
    func checkIfBuyable(){
        if(InformationStats.gold < strengthCost){
            strengthButton.isEnabled = false
        }else{
            strengthButton.isEnabled = true
        }
        if(InformationStats.gold < weaponCost){
            weaponButton.isEnabled = false
        }else{
            weaponButton.isEnabled = true
        }
        if(InformationStats.gold < armorCost){
            armorButton.isEnabled = false
        }else{
            armorButton.isEnabled = true
        }
        if(InformationStats.gold < agilityCost){
            agilityButton.isEnabled = false
        }else{
            agilityButton.isEnabled = true
        }
    }
    
    func updateStrengthCost(){
        strengthCost = 100 + (strengthUpgrade * strengthCost)
        
        strengthCostLabel.text = "Cost: \(strengthCost)"
    }
    
    func updateDisplay(){
        goldLabel.text = "Gold: \(InformationStats.gold)"
    }
}
