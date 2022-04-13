//
//  StartViewController.swift
//  Project4_HackingWithSwift
//
//  Created by Victoria Treue on 19/8/21.
//

import UIKit

class StartViewController: UITableViewController {
    
    private var websites = [Website]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Set Up
        tableView.separatorColor = .systemTeal
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Adding Websites
        websites = [Website(website: "queensland.com", title: "Queensland"), Website(website: "newsouthwales.com", title: "New South Wales"), Website(website: "westernaustralia.com", title: "Western Australia"), Website(website: "tasmania.com", title: "Tasmania"), Website(website: "southaustralia.com", title: "South Australia"), Website(website: "northernterritory.com", title: "Northern Territory")]
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: "websiteVC") as! DetailViewController
        vc.website = websites[indexPath.row].website
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}


// MARK: Website Model

struct Website {
    var website: String
    var title: String
}
