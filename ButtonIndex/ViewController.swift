//
//  ViewController.swift
//  ButtonIndex
//
//  Created by Renee Alves on 30/10/17.
//  Copyright © 2017 rra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let gray = UIColor(red: 155.0/255.0, green: 154.0/255.0, blue: 154.0/255.0, alpha: 1.0)
    let somegray = UIColor(red: 131.0/255.0, green: 131.0/255.0, blue: 131.0/255.0, alpha: 1.0)
    let purple = UIColor(red: 140.0/255.0, green: 35.0/255.0, blue: 142.0/255.0, alpha: 1.0)
    
    let alphabet: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S", "T","U","V","X","W","Y","Z"]
    
    let alphabetToNumber: [String:Int] = ["A":1,"B":2,"C":3,"D":4,"E":5,"F":6,"G":7,"H":8,"I":9,"J":10,"K":11,"L":12,"M":13,"N":14,"O":15,"P":16,"Q":17,"R":18,"S":19, "T":20,"U":21,"V":22,"X":23,"W":24,"Y":25,"Z":26]

    var alphabetView: UIView!
    
    var activeButton = 0
    
    var datasource: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alphabetViewFrame = CGRect(x: 710.0, y: 191.0, width: 30.0, height: 780.0)
        alphabetView = UIView(frame: alphabetViewFrame)
        
        var y: CGFloat = 0.0
        
        for i in 0..<alphabet.count {
            
            datasource.append("\(alphabet[i]) Alberto Roberto Mendonça")
            
            let button = UIButton(frame: CGRect(x: 0.0, y: y, width: 30.0, height: 30.0))
            button.tag = i
            
            if i == 0 {
                
                button.setTitleColor(UIColor.white, for: .normal)
                button.backgroundColor = UIColor.purple
                
            } else {
                
                button.setTitleColor(gray, for: .normal)
                button.backgroundColor = UIColor.white
            }
            
            button.layer.cornerRadius = 6
            button.setTitle(alphabet[i], for: .normal)
            button.titleLabel?.font = UIFont(name: "AvenirNext-Demibold", size: 14.0)
            button.addTarget(self, action: #selector(self.didTapButton(sender:)), for: .touchUpInside)
            
            alphabetView.addSubview(button)
            
            y += 30.0
        }
        
        self.view.addSubview(alphabetView)
    }

    @objc func didTapButton (sender: UIButton) {
        
        for subview in alphabetView.subviews {
            
            if let button = subview as? UIButton {
                
                if button.tag == activeButton {
                    
                    button.setTitleColor(gray, for: .normal)
                    button.backgroundColor = UIColor.white
                    break
                }
            }
        }
        
        activeButton = sender.tag
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor.purple
        
        for i in 0..<datasource.count {
            
            let string = datasource[i]
            
            if String(describing: string.characters.first!).uppercased() == sender.titleLabel?.text {
                
                let indexPath = IndexPath(row: i, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customerCell") as? CustomerCell
        
        cell?.customerName.text  = "\(datasource[indexPath.row])"
        cell?.companyName.text   = "Aline produtos"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alphabet.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if tableView.isDragging{
            
            if let customerCell = cell as? CustomerCell {
                
                let customerName = customerCell.customerName.text!
                
                let firstLetter = String(describing: customerName.characters.first!).uppercased()
                
                for subview in alphabetView.subviews {
                    
                    if let button = subview as? UIButton {
                        
                        if button.titleLabel?.text == firstLetter {
                            
                            button.setTitleColor(UIColor.white, for: .normal)
                            button.backgroundColor = UIColor.purple
                            activeButton = button.tag
                            
                        } else {
                            
                            button.setTitleColor(gray, for: .normal)
                            button.backgroundColor = UIColor.white
                        }
                    }
                }
            }
        }
    }
}

