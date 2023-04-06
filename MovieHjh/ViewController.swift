//
//  ViewController.swift
//  MovieHjh
//
//  Created by 황재하 on 4/5/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    let movieURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=e0d922798fe4b71963bb0052e9c4ad6b&targetDt=20230404"
    
    let name = ["영화이름1", "영화이름2", "영화이름3", "영화이름4", "영화이름5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        // 1단계 : URL만들기
        getData()
    }
    
    func getData() {
        if let url = URL(string: movieURL){
            // 2단계 : URL Session 만들기
            let session = URLSession(configuration: .default)
            
            // 3단계 : URL Session 인스턴스에게 task주기
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let JSONdata = data {
                    print(JSONdata, response!)
                    let dataString = String(data: JSONdata, encoding: .utf8)
                    print(dataString!)
                }
            }
            // 4단계 :  task 시작하기 ( task.resume() )
            task.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        cell.movieName.text = name[indexPath.row]
        
        return cell
    }
    

}
