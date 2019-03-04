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
    
    let strengthCostBase = 10
    let armorCostBase = 1000
    let weaponCostBase = 10000
    let agilityCostBase = 500000
    
    var strengthCost: Int = 10
    var armorCost: Int = 1000
    var weaponCost: Int = 10000
    var agilityCost: Int = 500000
    
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
        strengthUpgrade = strengthUpgrade + 1

        // Strength Damage Formula Here
        InformationStats.DPS = (2 * (strengthUpgrade + 1))
        
        // Update
        updateStrengthCost()
        checkIfBuyable()
    }
    
    @IBAction func weaponButtonClicked(_ sender: Any) {
        InformationStats.gold = InformationStats.gold - weaponCost
        weaponUpgrade = weaponUpgrade + 1

        
        // Weapon Formula
        InformationStats.weaponDamage = InformationStats.weaponDamage + 5
        
        // Update
        updateWeaponCost()
        checkIfBuyable()
    }
    @IBAction func armorButtonClicked(_ sender: Any) {
        InformationStats.gold = InformationStats.gold - armorCost
        armorUpgrade = armorUpgrade + 1

        // Armor Formula
        InformationStats.goldPerClick = (armorUpgrade + 1)
        
        // Update
        updateArmorCost()
        checkIfBuyable()
    }
    @IBAction func agilityButtonClicked(_ sender: Any) {
        InformationStats.gold = InformationStats.gold - agilityCost
        agilityCost = agilityCost + 1
        
        // Agility Formula
        InformationStats.agilityMultiplier = InformationStats.agilityMultiplier + 1
        
        // Update
        updateAgilityCost()
        checkIfBuyable()
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
        strengthCost = Int(strengthCostBase * Int(pow(1.15, Double(strengthUpgrade))))
        updateDisplay()
    }
    func updateWeaponCost(){
        weaponCost = Int(weaponCostBase * Int(pow(1.15, Double(weaponUpgrade))))
        updateDisplay()
    }
    func updateArmorCost(){
        armorCost = Int(armorCostBase * Int(pow(1.15, Double(armorUpgrade))))
        updateDisplay()
    }
    func updateAgilityCost(){
        agilityCost = Int(agilityCostBase * Int(pow(1.15, Double(agilityUpgrade))))
        updateDisplay()
    }
    
    func updateDisplay(){
        goldLabel.text = "Gold: \(InformationStats.gold)"
        strengthCostLabel.text = "Cost: \(strengthCost)"
        weaponCostLabel.text = "Cost: \(weaponCost)"
        armorCostLabel.text = "Cost: \(armorCost)"
        agilityCostLabel.text = "Cost: \(agilityCost)"
    }
}
