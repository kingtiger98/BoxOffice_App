//
//  ViewController.swift
//  MovieHjh
//
//  Created by 황재하 on 4/5/23.
//

import UIKit

// 파싱을 위한 MovieData, BoxOfficeResult, DailyBoxOfficeList형 구조체 만들기
// 구조체의 이름은 자유롭게 설정해도 상관없음
// 주의!! : 지금 만드는 구조체들은 Codable 프로토콜 준수해야함 인코딩_디코딩 기능 지원
// 주의!! : 구조체들의 프로퍼티명들은 받아온 JSON 데이터와 일치해야함
struct MovieData : Codable { // MovieData 구조체 생성, Codable 채택
    let boxOfficeResult : BoxOfficeResult // JSON데이터의 동일한 이름으로 boxOfficeResult 프로퍼티 생성
}

struct BoxOfficeResult : Codable { // BoxOfficeResult 구조체 생성, Codable 채택
    // JSON데이터에서 boxOfficeResult의 키 값이 "boxofficeType", "showRange", "dailyBoxOfficeList"로 세 개가 있지만
    // 필요한 "dailyBoxOfficeList"만 프로퍼티로 생성
    let dailyBoxOfficeList : [DailyBoxOfficeList] // JSON데이터의 동일한 이름으로 dailyBoxOfficeList 프로퍼티 생성
    // JSON데이터에서 dailyBoxOfficeList가 배열이므로 자료형에 []로 감쌈
    
}

struct DailyBoxOfficeList : Codable { // DailyBoxOfficeList 구조체 생성, Codable 채택
    // JSON데이터의 dailyBoxOfficeList의 배열에서 원하는 데이터를 골라 프로퍼티로 만들어주면 됨!
    // 물론 배열의 이름과 동일하게 프로퍼티를 생성해야한다.
    let movieNm : String // 영화이름
    let audiCnt : String // 누적관객수
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
        
    // let name = ["영화이름1", "영화이름2", "영화이름3", "영화이름4", "영화이름5"]
    let movieURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=e0d922798fe4b71963bb0052e9c4ad6b&targetDt=20230404"
    
    var movieData : MovieData? // decodedData를 저장할 변수 선언
    
    
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
                if let JSONdata = data { // data가 옵셔널형임
                    // print(JSONdata, response!)
                    // print(JSONdata)
                    // let dataString = String(data: JSONdata, encoding: .utf8)
                    // print(dataString!) // 데이터를 스트링으로 찍어보기
                    
                    let decoder = JSONDecoder() // JSONDecoder() 인스턴스 생성
                    // error handling
                    do{
                        let decodedData = try decoder.decode(MovieData.self, from: JSONdata)
                        // 구조체안의 구조체를 타고 들어가 1등한 영화 이름과 당일관객수를 찍어보자
                        // print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
                        // print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].audiCnt)
                        
                        // movieData에 decodedData 넣어줌
                        self.movieData = decodedData
                        DispatchQueue.main.async { // 메인 스레드(main)에서 비동기처리(async) 되도록 DispatchQueue 객체로 수정
                            self.table.reloadData() // 테이블뷰를 다시 로드
                        }
                    }catch{
                        print(error)
                    }
                }
            }
            
            // 4단계 :  task 시작하기 ( task.resume() )
            task.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        return cell
    }
}
