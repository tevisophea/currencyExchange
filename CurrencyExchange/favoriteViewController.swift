//
//  favoriteViewController.swift
//  CurrencyExchange
//
//  Created by user on 5/12/17.
//  Copyright © 2017 Tevisophea. All rights reserved.
//

import UIKit

class favoriteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: Properties
    @IBOutlet weak var favPicker: UIPickerView!
    
    let data = currencyEx.shared
    var selection: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.favPicker.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data.exchangeName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return data.exchangeName.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch row {
        case 0:
            self.selection = data.exchangeName[row]
        case 1:
            self.selection = data.exchangeName[row]
        case 2:
            self.selection = data.exchangeName[row]
        case 3:
            self.selection = data.exchangeName[row]
        case 4:
            self.selection = data.exchangeName[row]
        case 5:
            self.selection = data.exchangeName[row]
        case 6:
            self.selection = data.exchangeName[row]
        case 7:
            self.selection = data.exchangeName[row]
        default:
            self.selection = self.data.exchangeName[0]
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
