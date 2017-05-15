//
//  ViewController.swift
//  CurrencyExchange
//
//  Created by user on 5/12/17.
//  Copyright © 2017 Tevisophea. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var homePicker: UIPickerView!
    @IBOutlet weak var foreignPicker: UIPickerView!
    @IBOutlet weak var currencyExchange: UILabel!
    @IBOutlet weak var currencyInput: UITextField!

    
    //singleton 
    let data = currencyEx.shared
    
    //create variables to display the home and foreign selections
    var homePick: [String] = [String]()
    var foreignPick: [String] = [String]()
    var homeCurr: String?
    var forCurr: String?
    var exchangeCurr: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    // Do any additional setup after loading the view, typically from a nib.
        
        self.homePicker.delegate = self
        self.homePicker.dataSource = self
        self.foreignPicker.delegate = self
        self.foreignPicker.dataSource = self
        
        homePick = ["US Dollar", "Japanese Yen", "British Pound", "Chinese Yuan", "Cambodian Riel", "Thailand Baht"]
        
        foreignPick = ["US Dollar", "Japanese Yen", "British Pound", "Chinese Yuan", "Cambodian Riel", "Thailand Baht"]
        
        //fetch exchange rate from Yahoo Finance
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return homePick.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return homePick[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if pickerView.tag == 0 {
            homeCurr = String((homePick[row]))
            forCurr = String((foreignPick[row]))
            //currencyExchange.text = homeCurr
            //currencyExchange.text = forCurr
            if (homeCurr == "US Dollar") && (forCurr == "US Dollar") {
                exchangeCurr = "USDUSD"
                
            }
            else if (homeCurr == "US Dollar") && (forCurr == "Japanese Yen") {
                exchangeCurr = "USDJPY"
                }
            else if (homeCurr == "US Dollar") && (forCurr == "Cambodian Riel") {
                exchangeCurr = "USDKHR"
                }
            else if (homeCurr == "US Dollar") && (forCurr == "Thailand Baht") {
                exchangeCurr = "USDTHB"
                }
            else  if (homeCurr == "Japanese Yen") && (forCurr == "US Dollar") {
                exchangeCurr = "JPYUSD"
            }
            else if (homeCurr == "Japanese Yen") && (forCurr == "Japanese Yen") {
                exchangeCurr = "JPYJPY"
            }
            else if (homeCurr == "Japanese Yen") && (forCurr == "Cambodian Riel") {
                exchangeCurr = "JPYKHR"
            }
            else if (homeCurr == "Japanese Yen") && (forCurr == "Thailand Baht") {
                exchangeCurr = "JPYTHB"
                }
            else  if (homeCurr == "Cambodian Riel") && (forCurr == "US Dollar") {
                exchangeCurr = "KHRUSD"
            }
            else if (homeCurr == "Cambodian Riel") && (forCurr == "Japanese Yen") {
                exchangeCurr = "KHRJPY"
            }
            else if (homeCurr == "Cambodian Riel") && (forCurr == "Cambodian Riel") {
                exchangeCurr = "KHRKHR"
            }
            else if (homeCurr == "Cambodian Riel") && (forCurr == "Thailand Baht") {
                exchangeCurr = "KHRTHB"
                }
            else if (homeCurr == "Thailand Baht") && (forCurr == "US Dollar") {
                exchangeCurr = "THBUSD"
            }
            else if (homeCurr == "Thailand Baht") && (forCurr == "Japanese Yen") {
                exchangeCurr = "THBJPY"
            }
            else if (homeCurr == "Thailand Baht") && (forCurr == "Cambodian Riel") {
                exchangeCurr = "THBKHR"
            }
            else if (homeCurr == "Thailand Baht") && (forCurr == "Thailand Baht") {
                exchangeCurr = "THBTHB"
                }
            }
        }
    
    @IBAction func convertButton(_ sender: Any) {
        let userInput = Float(self.currencyInput.text!)!
        let currRate = self.data.exchangeDict[exchangeCurr!]!
        let currRated = userInput * currRate
        let currRatedFinal = String.localizedStringWithFormat("%.2f %@",currRated,"")
        currencyExchange.text! = currRatedFinal
    }
    
    func getData()
    {
        let myYQL = YQL()
        let queryString = "select * from yahoo.finance.xchange where pair in (\"USDUSD\", \"USDJPY\", \"USDKHR\", \"USDTHB\",\"JPYUSD\", \"JPYJPY\", \"JPYKHR\", \"JPYTHB\", \"KHRUSD\", \"KHRJPY\", \"KHRKHR\", \"KHRTHB\",\"THBUSD\", \"THBJPY\", \"THBKHY\", \"THBTHB\")"
        
        myYQL.query(queryString){ jsonDict in
            let queryDict = jsonDict["query"] as! [String: Any]
            let resultDict = queryDict["results"]! as! [String:Any]
            let rateDict = resultDict["rate"]! as! [[String: Any]]
            //let rateList = queryDict["rate"] as! [String: Any]
            //let quoteAttay = resultDict["quote"] as! [String: Any]
            
            //print(rateDict["rate"]!)
            //print(queryDict["count"]!)
            //print(queryDict["results"]!)
            
            var index = 0
            
            for _ in 0..<16
            {
                let exName = rateDict[index]["id"] as! String
                
                if let exRate = rateDict[index]["rate"]! as? String
                {
                    let exRateFloat = Float(exRate)
                    
                    self.data.rates.append(exRateFloat!)
                    self.data.exchangeDict[exName]  = exRateFloat!
                }
                index = index + 1
            }
        }
    }
}
