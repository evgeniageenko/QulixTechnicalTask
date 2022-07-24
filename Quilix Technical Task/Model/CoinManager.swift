//
//  CoinManager.swift
//  Quilix Technical Task
//
//  Created by Евгений Агеенко on 22.07.22.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(model: [CoinModel])
    func didFailWithError(error: Error)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "3DDD8215-0611-4421-AB68-6929D1D62C30"
  
    func getCoinPrice() {
          let urlString = "\(baseURL)/?apikey=\(apiKey)"

          if let url = URL(string: urlString) {
              
              let session = URLSession(configuration: .default)
              let task = session.dataTask(with: url) { (data, response, error) in
                  if error != nil {
                      self.delegate?.didFailWithError(error: error!)
                      return
                  }
                  if let safeData = data {
                      if let bitcoinPrice = self.parseJSON(safeData) {
                          delegate?.didUpdatePrice(model: bitcoinPrice)
                      }
                  }
              }
              task.resume()
          }
      }
    
    
    func parseJSON(_ data: Data) -> [CoinModel]?  {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let coinArray = decodedData.rates?.compactMap({CoinModel(name: $0.asset_id_quote ?? "", rate: $0.rate ?? 0)})
            
            return coinArray
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
