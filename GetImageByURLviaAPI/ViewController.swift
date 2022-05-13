//
//  ViewController.swift
//  GetImageByURLviaAPI
//
//  Created by Mac on 13.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    // При динамическом изменении ширины imageView
    var imageWidth = ""
    // При динамическом изменении высоты imageView
    var imageHeight = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Для изменения полученных значений типа double в String
        let height = imageView.bounds.height
        self.imageHeight = String(format: "%.0f", Double(height))
        let width  = imageView.bounds.width
        self.imageWidth = String(format: "%.0f", Double(width))
        
    }

    @IBAction func getImageButtonPressed(_ sender: UIButton) {
        // 1) Получаем API
        let API = "https://picsum.photos/" + imageWidth + "/" + imageHeight
        // 2) Создание URL
        guard let apiURL = URL(string: API) else {
            fatalError("Some Error")
        }
        // 3) Инициализировать сессию
        let session = URLSession(configuration: .default)
        // 4) Создать запрос dataTask
        let task = session.dataTask(with: apiURL) { (data, response, error ) in
            // 5) Обработать полученные данные
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                // data = .jpg
                self.imageView.image = UIImage(data: data)
            }
        }
        // Запустить запрос
        task.resume()
        
    }
    
}

