//
//  ViewController.swift
//  StretchMyHeader
//
//  Created by atfelix on 2017-06-06.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var headlines = [
        NewsItem(category: .world, headline: "Climate change protests, divestments meet fossil fuels realities"),
        NewsItem(category: .europe, headline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"),
        NewsItem(category: .middleEast, headline: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
        NewsItem(category: .africa, headline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
        NewsItem(category: .asiaPacific, headline: "Despite UN ruling, Japan seeks backing for whale hunting"),
        NewsItem(category: .americas, headline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"),
        NewsItem(category: .world, headline: "South Africa in $40 billion deal for Russian nuclear reactors"),
        NewsItem(category: .europe, headline: "'One million babies' created by EU student exchanges")
    ]

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - TableView data source methods


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        let newsItem = headlines[indexPath.row]
        cell.categoryLabel.text = newsItem.category.rawValue
        cell.categoryLabel.textColor = newsItem.color
        cell.headlineLabel.text = newsItem.headline

        return cell
    }
}
