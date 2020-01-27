//
//  ViewController.swift
//  YtApiPractice
//
//  Created by 志賀大河 on 2020/01/26.
//  Copyright © 2020 志賀大河. All rights reserved.
//

import UIKit
import SegementSlide

class ViewController: SegementSlideViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        reloadData()
        scrollToSlide(at: 0, animated: true)
    }
    
    override var headerView: UIView? {
        
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleToFill
        headerView.image = UIImage(named: "header")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerHeight:CGFloat
        if #available(iOS 11.0, *) {
            headerHeight = view.frame.height/4 + view.safeAreaInsets.top
        }else{
            headerHeight = view.frame.height/4 + topLayoutGuide.length
        }
        
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        return headerView
        
    }
    
    override var titlesInSwitcher: [String]{
        
        
        return["イブラ","天気予報","News","スペイン語","English","プログラミング"]
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        switch index {
        case 0:
            return Page1ViewController()
        case 1:
            return Page2ViewController()
        case 2:
            return Page3ViewController()
        case 3:
            return Page4ViewController()
        case 4:
            return Page5ViewController()
        case 5:
            return Page5ViewController()
        default:
            return Page1ViewController()
        }
        
        
    }
    
    
}

