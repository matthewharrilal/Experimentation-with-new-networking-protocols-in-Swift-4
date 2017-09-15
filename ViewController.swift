//
//  ViewController.swift
//  FinalCopy
//
//  Created by Matthew Harrilal on 9/14/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let network = Network()
        print(network.networking())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


let session = URLSession.shared
struct Pokemon {
    let name: String
    init(name: String) {
        self.name = name
    }
    
}
extension Pokemon: Decodable {
    // Declaring Our Keys
    enum Keys: String, CodingKey {
        case name
        
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let name: String = try container.decode(String.self, forKey: .name)
        self.init(name: name)
    }
    
}

class Network {
    func networking() {
        let getRequest = URL(string: "http://pokeapi.co/api/v1/pokemon/2/")!
        let urlRequest = URLRequest(url: getRequest)
        
        session.dataTask(with: urlRequest) { (data, response, Error) in
            print(response)
            if let data = data {
                guard let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data)
                    else{return}
                print(pokemon.name)
//            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print(json)
            }
            }.resume()
    }
}
