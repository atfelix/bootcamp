//
//  QuotesViewController.swift
//  QuotePro
//
//  Created by atfelix on 2017-06-07.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, QuoteDelegate {

    @IBOutlet weak var tableView: UITableView!
    var quotes = [Quote]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = quotes[indexPath.row].quoteText
        cell.detailTextLabel?.text = quotes[indexPath.row].quoteAuthor
        cell.imageView?.image = quotes[indexPath.row].photo

        return cell
    }

    func saveQuote(quoteString: String?, quoteAuthor: String?, image: UIImage?) {
        quotes.append(Quote(quoteText: quoteString, quoteAuthor: quoteAuthor, photo: image))
        navigationController?.popViewController(animated: true)
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddQuoteSegue" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.delegate = self
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
