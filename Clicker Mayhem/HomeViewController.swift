//
//  HomeViewController.swift
//  Clicker Mayhem
//
//  Created by Randy Le on 2/27/19.
//  Copyright © 2019 Project Koisa. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController{

    // MARK: IBOutlet
    @IBOutlet weak var enemyImage: UIImageView!
    @IBOutlet weak var EnemyLabel: UILabel!
    @IBOutlet weak var StageLabel: UILabel!
    @IBOutlet weak var GoldLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var DPSLabel: UILabel!
    
    // MARK: Properties
    let backgroundImageView = UIImageView()
    var index : Int = 0
    var enemies : [String] = ["beast", "berserker", "frog brawler", "ghost", "gold skeleton", "jaguar", "racoon warrior", "skeleton", "swarm of flies", "warrior", "zombie"]
    var enemyLevel : Int = 0
    var enemyHealth : Int = 10
    var enemyMaxHealth : Int = 10
    
    var player = AVAudioPlayer()
    var deathPlayer = AVAudioPlayer()
    var bgMusic = AVAudioPlayer()
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the main background
        setBackground()
        nextButton.isEnabled = false
        previousButton.isEnabled = false
        // Get Initial Enemy Image
        setEnemyBackground()
        DPSLabel.text = "DPS: \(InformationStats.DPS)"
        EnemyLabel.text = ("\(enemies[index]) (Lvl \(enemyLevel)): \n \(enemyHealth) / \(enemyMaxHealth)")
        // Background music
        playBackGroundMusic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DPSLabel.text = "DPS: \(InformationStats.DPS) - \(InformationStats.DPS + InformationStats.weaponDamage)"
    }

    // MARK: IBAction Functions
    @IBAction func attackButtonClicked(_ sender: UITapGestureRecognizer) {
        playAttackSound()
        enemyHealth = enemyHealth - getDamage()
        InformationStats.numOfClicks = InformationStats.numOfClicks + 1
        InformationStats.gold = InformationStats.gold + InformationStats.goldPerClick
        isEnemyDead()
        updateGold()
        updateEnemyLabel()
    }

    @IBAction func previousButtonClicked(_ sender: Any) {
        if(InformationStats.stage == 0){
            previousButton.isEnabled = false
        }
        else{
            InformationStats.stage = InformationStats.stage - 1
            updateEnemyStatus()
            updateStage()
        }
        nextButton.isEnabled = true
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if(InformationStats.stage == InformationStats.maxStage){
            nextButton.isEnabled = false
        }
        else{
            previousButton.isEnabled = true
            InformationStats.stage = InformationStats.stage + 1
            updateEnemyStatus()
            updateStage()
            }
    }
    
    // MARK: Functions
    func setBackground(){
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "background")
        view.sendSubviewToBack(backgroundImageView)
    }
    
    // CHECK IF ENEMY IS DEAD
    func isEnemyDead(){
        if(enemyHealth <= 0){
            playEnemyDefeatSound()
            // Increase stage level
            InformationStats.stage = InformationStats.stage + 1
            
            // Random Generate Gold
            let multiplier = Int.random(in: 1 ... 3)
            let bonus = Int.random(in: 0 ... 50)
            InformationStats.gold = InformationStats.gold + ( (25 * (enemyLevel + 1)) + (enemyLevel * bonus * multiplier))
            
            previousButton.isEnabled = true

            updateEnemyStatus()
            updateGold()
            updateStage()
        }
    }
    
    // GET NEW ENEMY
    func updateEnemyStatus(){
        
        // Random Enemy Type
        index = Int.random(in: 0 ... 10)
        
        let enemyRandom = Int.random(in: -1 ... 10)
        let randomEnemyHP = Int.random(in: 1 ... 3)
        enemyLevel = InformationStats.stage + enemyRandom
        if (enemyLevel < 0){
            enemyLevel = 0
        }
        
        enemyMaxHealth = Int(pow(Double(enemyLevel) , 2.0) + 10)
        enemyHealth = enemyMaxHealth
        
        if(randomEnemyHP == 1){
            EnemyLabel.textColor = UIColor.white
        }
        else if(randomEnemyHP == 2){
            EnemyLabel.textColor = UIColor.blue
        }
        else if (randomEnemyHP == 3){
            EnemyLabel.textColor = UIColor.red
        }
        
        setEnemyBackground()
        updateEnemyLabel()
    }
    // CHANGE ENEMY IMAGE
    func setEnemyBackground(){
        enemyImage.image = UIImage(named: enemies[index])
    }
    // UUPDATE ENEMY LABEL
    func updateEnemyLabel(){
        EnemyLabel.text = ("\(enemies[index]) (Lvl \(enemyLevel)): \n \(enemyHealth) / \(enemyMaxHealth)")
    }
    
    func updateGold(){
        GoldLabel.text = ("Gold: \(InformationStats.gold)")
    }
    
    func updateStage(){
        StageLabel.text = ("Stage: \(InformationStats.stage)")
        
        if(InformationStats.stage > InformationStats.maxStage){
            InformationStats.maxStage = InformationStats.stage
        }
    }
    func getDamage() -> Int{
        let maxDamage: Int = InformationStats.DPS + InformationStats.weaponDamage
        let multiplier: Int = Int.random(in: 1 ... InformationStats.agilityMultiplier)
        var damage: Int = Int.random(in: InformationStats.DPS ... maxDamage)
        damage = damage * multiplier
        
        return damage
    }
    
    func playAttackSound(){
        if let path = Bundle.main.path(forResource: "Sword2", ofType: "mp3"){
            let url = URL(fileURLWithPath: path)
            print(url)
            do{
                player = try AVAudioPlayer(contentsOf: url)
                player.play()
            } catch let error{
                print(error.localizedDescription)
            }
        }

    }
    
    func playEnemyDefeatSound(){
        if let path = Bundle.main.path(forResource: "roblox-death-sound-effect", ofType: "mp3"){
            let url = URL(fileURLWithPath: path)
            print(url)
            
            do{
                deathPlayer = try AVAudioPlayer(contentsOf: url)
                deathPlayer.play()
            } catch let error{
                print(error.localizedDescription)
            }

        }
    }
    
    func playBackGroundMusic(){
        if let path = Bundle.main.path(forResource: "Fantasy_Game_Background_Looping", ofType: "mp3"){
            let url = URL(fileURLWithPath: path)
            print(url)
            
            do{
                bgMusic = try AVAudioPlayer(contentsOf: url)
                bgMusic.prepareToPlay()
                bgMusic.numberOfLoops = -1
                bgMusic.play()
            }
            catch let error{
                print(error.localizedDescription)
            }

        }
    }

    
}
