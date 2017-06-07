//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

final class NetworkManager {
    static func fetchImage(completion: @escaping (UIImage?) -> Void) {
        let session = URLSession.shared
        let components = URLComponents(string: "http://lorempixel.com/200/300")!
        let request = URLRequest(url: components.url!)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in

            var image : UIImage?

            defer {
                completion(image)
            }

            if let error = error {
                print(#function, #line, "Error: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print(#line, "response is not 200")
                return
            }

            guard let data = data else {
                return
            }
            
            print(#line, data)
            image = UIImage(data: data)
            print(#line, image!)
            completion(image)
        }.resume()
    }
}



class MainViewController : UIViewController {

    var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .red

        view.addSubview(imageView)

        imageView.frame = view.frame
        imageView.contentMode = .scaleAspectFill
        fetchImage()
    }

    private func fetchImage() {
        NetworkManager.fetchImage {[weak self] (image: UIImage?) in
            guard let image = image else {
                print(#line, "no image")
                return
            }
            guard let weakSelf = self else {
                return
            }
            weakSelf.imageView.image = image
        }
    }
}

let mainVC = MainViewController()

PlaygroundPage.current.liveView = mainVC