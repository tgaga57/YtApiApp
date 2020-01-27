//
//  Page1ViewController.swift
//  YtApiPractice
//
//  Created by 志賀大河 on 2020/01/26.
//  Copyright © 2020 志賀大河. All rights reserved.
//

import UIKit
import SegementSlide
import Alamofire
import SwiftyJSON
import SDWebImage

class Page6ViewController: UITableViewController,SegementSlideContentScrollViewDelegate {
    
    var youtubeData = YoutubeData()
    
    var videoIDArray = [String]()
    var publishedAtArray = [String]()
    var titleArray = [String]()
    var imageURLStringArray = [String]()
    var youtubeURLArray = [String]()
    var channelTitleArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //　データを取ってくる
        getData()
        // Do any additional setup after loading the view.
    }
    
    @objc var scrollView: UIScrollView{
        
        return tableView
    }
    
    // セクションの数
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //
    //    }
    //
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            cell.selectionStyle = .none
            let profileImageURL = URL(string: self.imageURLStringArray[indexPath.row] as String)!
            
            cell.imageView?.sd_setImage(with: profileImageURL, completed: {(image, error,_,_) in
                if error == nil {
                    cell.setNeedsLayout()
                }
            })
            
            
            cell.textLabel?.text = self.titleArray[indexPath.row]
//            cell.detailTextLabel?.text = self.publishedAtArray[indexPath.row]
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.numberOfLines = 5
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    //　セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.size.height/5
    }
    
    func getData() {
        
        var text = "https://www.googleapis.com/youtube/v3/search?key=AIzaSyBK_hJnj10ZhuF2nO9OcLptvAgsl2A-YEk&q=Programming&part=snippet&maxResults=20&order=date"
        // 日本語で検索しても大丈夫なようにした
        let url = text.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!
        
        // requestを送る
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {(responce) in
            
            // Json解析
            // 40個返ってくるのでfor文で入れていく
            
            print(responce)
            
            switch responce.result{
                
            case .success:
                
                for i in 0...19{
                    
                    let json:JSON = JSON(responce.data as Any)
                    // videoId
                    let videoId = json["items"][i]["id"]["videoId"].string
                    
                    // publishedAt
//                    let publishedAt = json["items"][i]["snippet"]["publishedAt"].string
                    
                    // title
                    let title = json["items"][i]["snippet"]["title"].string
                    
                    // imageUrlString
                    let imageURLString = json["items"][i]["snippet"]["thumbnails"]["default"]["url"].string
                    
                    // youtubeのurl作成
                    let youtubeURL = "https://www.youtube.com/watch?v=\(videoId)"
                    
                    let channelTittle = json["items"][i]["snippet"]["channelTitle"].string
                    
                    
                    self.videoIDArray.append(videoId!)
//                    self.publishedAtArray.append(publishedAt!)
                    self.imageURLStringArray.append(imageURLString!)
                    self.youtubeURLArray.append(youtubeURL)
                    self.channelTitleArray.append(channelTittle!)
                    self.titleArray.append(title!)
                    
                }
                
                break
                
            case .failure(let error):
                print(error)
                break
            }
            
            self.tableView.reloadData()
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexNumber = indexPath.row
        let webViewController = WebViewController()
        let url = youtubeURLArray[indexNumber]
        UserDefaults.standard.set(url, forKey: "url")
        present(webViewController, animated: true, completion: nil)
    }
    
}

