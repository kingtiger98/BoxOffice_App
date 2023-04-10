//
//  DetailViewController.swift
//  MovieHjh
//
//  Created by 황재하 on 4/10/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var receiveName: UILabel!
    
    var receivedName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveName.text = receivedName!
        
        // Do any additional setup after loading the view.
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
