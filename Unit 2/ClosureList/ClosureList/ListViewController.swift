//
//  ViewController.swift
//  ClosureList
//
//  Created by Luciene Ventura on 01/03/22.
//

import UIKit

struct Track {
    var trackNumber: Int
}

struct TrackWithComparable: Comparable {
    var trackRate: Int
    
    static func < (lhs: TrackWithComparable, rhs: TrackWithComparable) -> Bool {
        return lhs.trackRate < rhs.trackRate
    }
}

class ListViewController: UIViewController {
    
    let tracks = [Track(trackNumber: 3), Track(trackNumber: 2), Track(trackNumber: 1), Track(trackNumber: 4)]
    let tracksWithComparable = [TrackWithComparable(trackRate: 4), TrackWithComparable(trackRate: 2), TrackWithComparable(trackRate: 5), TrackWithComparable(trackRate: 1), TrackWithComparable(trackRate: 3)]
    let names = ["John", "Paul", "Ringo", "George"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print(sortTrackListByName())
        print(sortWithComparable())
        print(showFullNames())
        print(showNumbersLessThan20(numbers: [4, 8, 10, 33, 50, 0, 1, 3]))
        print(showTotalValue(numbers: [8, 6, 7, 5, 3, 0, 9]))
    }
}

//MARK: - Sorted by

extension ListViewController {
    // A função sorted(by: ) vai rodar as instruções na closure que foi passada em cada par de objetos na array e vai retornar um valor Bool. Se a closure retornar True, a primeira faixa vai permanecer na frente da segunda faixa; se retornar false, a primeira faixa vai se mover pra trás da segunda faixa. A função vai se repetir até que toda a array retorne true.
    func sortTrackListByName() -> [Track] {
        let sortedTracks = tracks.sorted { (firstTrack, secondTrack) ->
           Bool in
            return firstTrack.trackNumber < secondTrack.trackNumber
        }
        
        return sortedTracks
    }
    
    /*
     Para reduzir o tamanho dessa closure, podemos usar métodos de sintaxe pra ajudar a criar um código mais conciso e limpo. O desenvolvedores chamam isso de syntatic sugar.
     No caso da função sorted(by: ), o xcode já sabe que ela aceita dois parâmetros e também sabe que ela retorna uma Bool. Então tudo isso pode ser simplificado assim:
    */
    func sortTrackByRate() -> [Track] {
        let sortedTracks = tracks.sorted { $0.trackNumber < $1.trackNumber }
        return sortedTracks
    }
    
    /*
     Podemos reduzir ainda mais o tamanho da closure se ela conformar com Comparable
     A função < vao aceitar dois parâmetros do tipo TrackWithComparable e retornar uma Bool, assim como a sorted(by: ).
     */
    func sortWithComparable() -> [TrackWithComparable] {
        let sortedTracks = tracksWithComparable.sorted(by: <)
        return sortedTracks
    }
}

//MARK: - Map
/*
 Da mesma forma que fizemos com o sorted(by: ), funciona o map().
 Ele pega uma array de qualquer tipo e transforma em uma outra array com as modificações que você colocar dentro da closure para cada objeto. Posso pegar uma array de nomes e criar uma nova array com o primeiro nome + o sobrenome que estiver na closure. É como se eu estivesse fazendo um loop e colocando o que eu quero em uma nova array
 
    Exemplo:
    let fullNames: [String] = []
    for name in names {
        let fullName = name + "Beatle"
        fullNames.append(fullName)
    }
 
    Posso substituir esse loop por uma linha: names.map:
 */
extension ListViewController {
    func showFullNames() -> [String] {
        let fullNames = names.map { $0 + " Beatle" }
        return fullNames
    }
    
    /*
     Para quebrar melhor a sintaxe:
        Como chamar a função? map()
        Qual o parâmetro da função? { $0 + "Beatle" }
        O que $0 representa? Um objeto individual dentro da array que estamos trabalhando.
     */
}

//MARK: - Filter
/*
A função filter() cria uma nova array apenas com os objetos da array inicial que dão match com um uso específico. A filter() aceita uma closure como parametro e retorna true ou false pra determinar se o objeto deve ou não ser incluído na nova array. Também funciona como um loop.
 
    Exemplo:
    let numbers = [4, 8, 15, 16, 23, 42]
    var numbersLessThan20: [Int] = []
 
    for number in numbers {
        if number < 20 {
            numbersLessThan20.append(number)
        }
    }
 
    Agora usando numbers.filter
 */

extension ListViewController {
    func showNumbersLessThan20(numbers: [Int]) -> [Int] {
        let numbersLessThan20 = numbers.filter { $0 < 20 }
        return numbersLessThan20
    }
    
    /*
     Para quebrar melhor a sintaxe:
        Como chamar a função? filter()
        Qual o parâmetro da função? { $0 < 20 }
        O que $0 representa? Um objeto individual dentro da array que estamos trabalhando.
     */
}

//MARK: - Reduce
/*
A função reduce() combina todos os valores da array em apenas um valor. Como parâmetros, ela aceita um valor inicial e uma closure que diz como os itens serão combinados. Também funciona como um loop
    
    Exemplo:
    let numbers = [8, 6, 7, 5, 3, 0, 9]
    let total = 0
    for number in numbers {
        total = total + number
    }
    
    Agora usando reduce()
 */

extension ListViewController {
    func showTotalValue(numbers: [Int]) -> Int {
        let total = numbers.reduce(0) { $0 + $1 }
        return total
    }
    
    /*
     Para quebrar melhor a sintaxe:
     Como chamar a função? reduce()
     Whal o valor inicial na chamada da função? 0
     Qual o parâmetro da closure? { $0 + $1 }
     O que $0 representa? O valor de todos os itens que devem ser reduzidos até então
     O que $1 representa? O valor do novo item que você está reduzindo dentro do total
     */
}

// MARK: - Closure Capture
/*
 Em lições anteriores você aprendeu sobre escopo e que qualquer constante ou variável declarada dentro de chaves e definida localmente e inacessível por qualquer outra parte do escopo.
 
 Closures funcionam de forma diferente. Elas são constantemente escritas usando valores ou funções definidas no mesmo escopo que closures, mas não dentro das chaves.
 
 Exemplo:
 animate {
    self.view.backgroundColor = .red
 }
 
 E se view fosse removida da tela durante a animação?  A animação pararia? O código daria crash?
 Baseado no contexto, a closure pode acessar ou capturar constantes e variáveis. Isso significa que, se view fosse dealocada quando fosse removida da tela, a closure animate continuaria com a view em memória até que a closure fosse completada.
 Essa inteligência permite que as closures usem aquelas constantes e variáveis de forma segura e as modifiquem ao longo do bloco de closure. Similarmente, Swift quer que fique claro que o dono da view também fique na memória até que a animação esteja completa, então isso requer self.
 
 */
