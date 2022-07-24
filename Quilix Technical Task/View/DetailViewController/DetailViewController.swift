//
//  DetailViewController.swift
//  Quilix Technical Task
//
//  Created by Евгений Агеенко on 23.07.22.
//

import UIKit

struct CoinViewModel {
    let currency: String?
    let coinRate: Double?
}

final class DetailViewController: UIViewController {
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var currencyLabel: UILabel!
    private let model: CoinViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init(model: CoinViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("model wasn't choosen")
    }
    
    //MARK: - UI Settings
    private func setupUI() {
        if let rate = model.coinRate {
            let rateString = String(format: "%.2f", rate)
            DispatchQueue.main.async { [weak self] in
                self?.rateLabel.text = "Rate: \(rateString)"
                self?.currencyLabel.text = self?.model.currency
            }
        }
        
        rateLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        currencyLabel.font = UIFont.systemFont(ofSize: 34, weight: .semibold)
    }
}

//MARK: - External methods
extension DetailViewController {
    func setupWithModel(model: CoinViewModel) {
        if let rate = model.coinRate {
            let rateString = String(format: "%.2f", rate)
            DispatchQueue.main.async { [weak self] in
                self?.rateLabel.text = "Rate: \(rateString)"
                self?.currencyLabel.text = model.currency
            }
            
        }
    }
}
