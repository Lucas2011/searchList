//
//  ViewController.swift
//  20190729-XiLi-NYCSchools
//
//  Created by Lucas on 7/29/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating{
    
    let searchController = UISearchController(searchResultsController: nil)
    var dataArray = [String]()
    var seachArray = [String]()

    var satDict = NSMutableDictionary()

    lazy var talbView:UITableView = {
        let talbView = UITableView(frame: self.view.bounds)
        talbView.backgroundColor = UIColor.white
        talbView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        talbView.delegate = self
        talbView.dataSource = self
        return talbView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupUI()
    }

    
    
    private func setupUI(){
        loadData()
        setupSearchNav()
        setupCollectionView()
    }
    
    
   private func setupSearchNav(){
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.title = "Search School"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func setupCollectionView(){
        self.view.addSubview(talbView)
    }

    internal func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespaces) else { return }
       
        if text.isEmpty {
            self.dataArray = self.seachArray
            talbView.reloadData()
        }
        
        if text.count > 0 {
            self.dataArray   = self.dataArray.filter { $0.contains(text) }
            talbView.reloadData()

        }
    }
    

    private func loadData() {
            NetworkTools.shared.request(url: "") { (array, nil) in
            self.dataArray = array ?? []
            self.seachArray = self.dataArray
            DispatchQueue.main.async {
                self.talbView.reloadData()
                
            }
            
        }
        
        NetworkTools.shared.delateRequest { (dict, nil) in
            self.satDict = dict!
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = talbView.dequeueReusableCell(withIdentifier: "id", for: indexPath    )
        cell.textLabel?.text = self.dataArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        let str = self.dataArray[indexPath.row]
        let name = String(str.suffix(6))
        let detail  = self.satDict[name as Any] as?Model
        var satString = ""
        if detail == nil {
            
             satString = "\nWebsite: \(detail?.website ?? "")\nPlease check website for more information"

        }else
        {
             satString = "\nSAT Math Avg: \(detail?.sat_math_avg_score ?? "")\nSAT Writing Avg: \(detail?.sat_critical_reading_avg_score ?? "")\nSAT Critical Writing Avg: \(detail?.sat_writing_avg_score ?? "")\n"

        }

        tempMessage(messageTitle: detail?.school_name ?? "", messageAlert: satString, messageStyle: .alert, alertActionStyle: .default, completionHandler: {})
    }

    
    
    
    
    func tempMessage(messageTitle: String, messageAlert: String, messageStyle: UIAlertController.Style, alertActionStyle: UIAlertAction.Style, completionHandler: @escaping () -> Void)
    {
        let alert = UIAlertController(title: messageTitle, message: messageAlert, preferredStyle: messageStyle)
        
        let confirmAction = UIAlertAction(title: "Got it", style: alertActionStyle) { _ in
            completionHandler()
        }
        
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }
    
}

