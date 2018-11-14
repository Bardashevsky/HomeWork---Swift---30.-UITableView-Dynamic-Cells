//
//  ViewController.swift
//  HomeWork - Swift - 30. UITableView Dynamic Cells
//
//  Created by Oleksandr Bardashevskyi on 11/12/18.
//  Copyright © 2018 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Global variables
    
    var arrayOfArrays = [[(String, Int)]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // отступ сверху
        let insets = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
        
        var studentArray = [(String, Int)]()
        var perfectStudent = [(String, Int)]()
        var goodStudent = [(String, Int)]()
        var midleStudent = [(String, Int)]()
        var badStudent = [(String, Int)]()
        
        for _ in 1...100 {
            studentArray.append(("\(randomName()) \(randomName())", randomMark()))
        }
        for (name, mark) in studentArray {
            if mark == 2 {
                badStudent.append((name, mark))
            } else if mark == 3 {
                midleStudent.append((name, mark))
            } else if mark == 4  {
                goodStudent.append((name, mark))
            } else if mark == 5  {
                perfectStudent.append((name, mark))
            }
        }
        let sortedbadStudent = badStudent.sorted {
            $1.0 > $0.0
        }
        let sortedmidleStudent = midleStudent.sorted {
            $1.0 > $0.0
        }
        let sortedgoodStudent = goodStudent.sorted {
            $1.0 > $0.0
        }
        let sortedperfectStudent = perfectStudent.sorted {
            $1.0 > $0.0
        }
        self.arrayOfArrays = [sortedperfectStudent, sortedgoodStudent, sortedmidleStudent, sortedbadStudent]
    }
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrayOfArrays.count + 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section < self.arrayOfArrays.count ? self.arrayOfArrays[section].count : 10
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Excellent Students"
        } else if section == 1 {
            return "Good Students"
        } else if section == 2 {
            return "Midle Students"
        } else if section == 3 {
            return "Bad Students"
        } else if section == 4 {
            return "Colors"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //MARK: - Students
        let identifire = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifire)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: identifire)
        }
        if indexPath.section < 4 {
            let studentNames = self.arrayOfArrays[indexPath.section]
            cell?.textLabel?.text = studentNames[indexPath.row].0
            let mark = studentNames[indexPath.row].1
            cell?.detailTextLabel?.text = String(mark)
        
            switch mark {
            case 2:
                cell?.backgroundColor = UIColor.red
            case 3:
                cell?.backgroundColor = UIColor.orange
            case 4:
                cell?.backgroundColor = UIColor.yellow
            case 5:
                cell?.backgroundColor = UIColor.green
            default:
                break
            }
        }
        //MARK: - Colors
        let identifire2 = "cell2"
        var cell2 = tableView.dequeueReusableCell(withIdentifier: identifire2)
        
        if cell2 == nil {
            cell2 = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: identifire2)
        }
        cell2?.backgroundColor = randomColor()
        var (red, green, blue, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        cell2?.backgroundColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        cell2?.textLabel?.text = "Red = \(formatString(places: red)), Green = \(formatString(places: green)), Blue = \(formatString(places: blue))"
        
        
        return indexPath.section < 4 ? cell! : cell2!
    }
    //MARK: - Functions
    
    func formatString(places:CGFloat) -> String{
        let aStr = String(format: "%05.3f", places)
        return aStr
    }
    func randomColor () -> UIColor{
        let r = CGFloat(arc4random()%256) / 255
        let g = CGFloat(arc4random()%256) / 255
        let b = CGFloat(arc4random()%256) / 255
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    func randomMark () -> Int {
        let mark = Int(arc4random()%4) + 2
        return mark
    }
    func randomName () -> String {
        
        func randomLoud () -> Int {
            return Int(arc4random()%21)
        }
        func randomVowels () -> Int {
            return Int(arc4random()%5)
        }
        func randomAlphabet () -> Int {
            return Int(arc4random()%26)
        }
        var name = ""
        var arrayLoud = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"]
        var arrayVowels = ["a", "e", "i", "o", "u"]
        var arrayAlphabet = [String]()
        arrayAlphabet += arrayVowels
        arrayAlphabet += arrayLoud
        
        for i in 2..<10 {
            if i == 2 {
                name.append(arrayAlphabet[randomAlphabet()])
            }
            if (name.hasPrefix("a") || name.hasPrefix("e") || name.hasPrefix("i") || name.hasPrefix("o") || name.hasPrefix("u")) {
                if i % 2 == 0 {
                    name.append(arrayLoud[randomLoud()])
                } else if i%2 == 1 {
                    name.append(arrayVowels[randomVowels()])
                }
            } else {
                if i % 2 == 1 {
                    name.append(arrayLoud[randomLoud()])
                } else if i%2 == 0 {
                    name.append(arrayVowels[randomVowels()])
                }
            }
            
        }
        return name.capitalized
    }
}

