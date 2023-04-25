//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Julie Lu on 21/2/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var costFloat: Float?
    var splitPeople: Int?
    var splitPct: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = "$" + String(costFloat!)
        settingsLabel.text = "Split between \(splitPeople!) people, with \(splitPct!)% tip"
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var settingsLabel: UILabel!
    
    @IBAction func recalculatePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
