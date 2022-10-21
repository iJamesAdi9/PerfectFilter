//
//  ViewController.swift
//  PerfectFilter
//
//  Created by Wachiravit Teerasarn on 22/10/2565 BE.
//

import UIKit
import Fakery

class ViewController: UIViewController {
    
    // MARK: Properties
    
    private var originalData: [Infomation]? = [
        Infomation(name: "한국 韓國", email: "some@mail.com", address: "KR", tel: "222-22"),
        Infomation(name: "조선 朝鮮", email: "some@mail.com", address: "KR", tel: "222-22"),
        Infomation(name: "재현", email: "some@mail.com", address: "KR", tel: "222-22"),
        Infomation(name: "새 공", email: "some@mail.com", address: "KR", tel: "222-22"),
        Infomation(name: "ประยุทธ์", email: "some@mail.com", address: "TH", tel: "222-22"),
        Infomation(name: "ประวิตร", email: "some@mail.com", address: "TH", tel: "222-22"),
        Infomation(name: "นินจา", email: "some@mail.com", address: "TH", tel: "222-22"),
        Infomation(name: "こうき", email: "some@mail.com", address: "JP", tel: "222-22"),
        Infomation(name: "げ", email: "some@mail.com", address: "JP", tel: "222-22"),
        Infomation(name: "ご", email: "some@mail.com", address: "JP", tel: "222-22"),
    ]
    private var displayData: [Infomation] = []
    private let infomationCell: String = "InfomationCell"
    private var keyword: String = ""
    private var searchKeyword: String {
        set {
            keyword = newValue
            
            if newValue != "" {
                displayData = originalData?.filter { $0.name.range(of: newValue, options: [.regularExpression, .caseInsensitive]) != nil } ?? []
            } else {
                displayData = originalData ?? []
            }
        }
        
        get {
            return keyword
        }
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMockData()
    }
    
    private func createMockData() {
        let fakery = Faker(locale: "en")
        
        for _ in 0...30 {
            originalData?.append(Infomation(name: fakery.name.name(), email: fakery.internet.email(), address: fakery.address.city(), tel: fakery.phoneNumber.cellPhone()))
        }
        
        displayData = originalData ?? []
        tableView.reloadData()
    }
    
    private func filter(text: String) {
        searchKeyword = text
        
        if keyword != "" && displayData.isEmpty {
            // Show empty views
        } else {
            tableView.reloadData()
        }
    }
    
    // MARK: - SetupCell
    private func setupInfomationCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: infomationCell, for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let name = displayData[indexPath.row].name
        content.text = name
        
        cell.contentConfiguration = content
        
        return cell
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter(text: searchText)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupInfomationCellAt(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(displayData[indexPath.row])
    }
}
