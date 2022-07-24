//
//  ViewController.swift
//  Quilix Technical Task
//
//  Created by Евгений Агеенко on 22.07.22.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSource = [CoinModel]()
    private var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        coinManager.getCoinPrice()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: CoinTableViewCell.self)
        
        updateUI()
    }
}

//MARK: - UI Settings
extension ViewController {
    func updateUI () {
        title = "Сhoose currency 👇"
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: CoinTableViewCell.self, for: indexPath)
        cell.setupWith(title: dataSource[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let modelsArray = dataSource.compactMap({CoinViewModel(currency: $0.name, coinRate: $0.rate)})
        let controller = DetailViewController(model: modelsArray[indexPath.row])
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didUpdatePrice(model: [CoinModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.dataSource = model
            self?.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
