//
//  DetailViewController.swift
//  MovieHjh
//
//  Created by 황재하 on 4/10/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBAction func searchMV(_ sender: UIButton) {
        guard let url = URL(string: "https://m.naver.com"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func watchMV(_ sender: UIButton) {
        guard let url = URL(string: "https://m.youtube.com"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBOutlet weak var receiveName: UILabel!
    @IBOutlet weak var receiveRank: UILabel!
    @IBOutlet weak var receiveDay: UILabel!
    @IBOutlet weak var receiveAudi: UILabel!
    @IBOutlet weak var receiveAudiTotal: UILabel!
    @IBOutlet weak var receiveMony: UILabel!
    @IBOutlet weak var receiveMonyTotal: UILabel!
    
    // 받아온 데이터를 저장할 변수 선언
    var receivedName : String?
    var receivedRank : String?
    var receivedDay : String?
    var receivedAudi : String?
    var receivedAudiTotal : String?
    var receivedMony : String?
    var receivedMonyTotal : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 받아온 데이터를 강제 언래핑
        receiveName.text = "🎬\(receivedName!)"
        receiveRank.text = "전일 박스오피스 순위 :  \(receivedRank!)위"
        receiveDay.text = "영화 개봉일 :  \(receivedDay!)"
        receiveAudi.text = "전일 관객수 :  \(stringSeperator(receivedAudi!))명"
        receiveAudiTotal.text = "누적 관객수 :  \(stringSeperator(receivedAudiTotal!))명"
        receiveMony.text = "전일 매출액 :  \(stringSeperator(receivedMony!))원"
        receiveMonyTotal.text = "누적 매출액 :  \(stringSeperator(receivedMonyTotal!))원"
        
    }
    
    // 숫자 문자열 사이 "," 추가 함수
    func stringSeperator(_ num: String) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let number = Int(num) {
                return formatter.string(from: NSNumber(value: number)) ?? ""
            }
            return num
    }
    
    
    
}
