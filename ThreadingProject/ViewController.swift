//
//  ViewController.swift
//  ThreadingProject
//
//  Created by neodiyadin on 26.11.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    let urlString = ["https://cdn.mappr.co/wp-content/uploads/2023/07/amsterdam-canals.jpeg","https://image-assets.eu-2.volcanic.cloud/api/v1/assets/images/ff16583bd0f0254cbe869c8d0bb78adc?webp_fallback=png"]
    
    var data = Data()
    var tracker = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.urlString[self.tracker])!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data)
            }
        }
        
        imageView.image = UIImage(data: data)
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(changeImage))
        
    }
    
    @objc func changeImage() {
        
        if tracker == 0 {
            tracker += 1
        } else {
            tracker -= 1
        }
        
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.urlString[self.tracker])!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data)
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "threading test"
        return cell
    }


}

