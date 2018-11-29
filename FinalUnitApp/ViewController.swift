import UIKit

struct Pokemon: Decodable {
    let name: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var pokemonLabel: UILabel!
    
    var name = String()
  var height = String()
    var weight = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onFindButtonTapped(_ sender: UIButton) {
        let randomNumber = Int(arc4random_uniform(802))
        parse(number: randomNumber)
    }
    
    func parse(number: Int) {
       let jsonUrlString = "https://pokeapi.co/api/v2/pokemon-form/\(number)/"
      //  let jsonUrlString = "https://pokeapi.co/api/v2/ability/\(number)/"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                let name = pokemon.name
            
               
                print(name)
            
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
    }
    
    func displayInfo(pokemonName: String, pokemonHeight: String, pokemonWeight: String) {
        DispatchQueue.main.async {
            self.pokemonLabel.text = "Name: \(pokemonName)\nHeight: \(pokemonHeight)\nWeight: \(pokemonWeight)"
        }
    }
    
}


