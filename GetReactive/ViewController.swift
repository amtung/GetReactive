//
//  ViewController.swift
//  GetReactive
//
//  Created by Annie Tung on 2/12/18.
//  Copyright © 2018 Groop Internet Platform inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()
    var citiesToShow = [String]()
    let arrayOfCities = ["New York", "Hong Kong", "London", "Tokyo", "Seoul"]
    let arrayOfNames = Variable(["Annie"])

    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] query in // we want to be notified for every new value
                self.citiesToShow = self.arrayOfCities.filter { $0.hasPrefix(query) }
                self.tableView.reloadData()
            }).disposed(by: disposeBag)

        arrayOfNames.asObservable()
            .filter { value in
                return value.count == 1
            }
            //.debug()
            .map { value in
                return "user is: \(value)"
            }
            .subscribe(onNext: { value in
                print(value)
            }).disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrayOfNames.value = ["Annie", "Ben"]
        arrayOfNames.value = ["Cassie", "Dan"]
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        arrayOfNames.value = ["Emily"]
    }

    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesToShow.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = citiesToShow[indexPath.row]
        return cell
    }
}

