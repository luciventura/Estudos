//
//  ViewController.swift
//  Extensions
//
//  Created by Luciene Ventura on 01/03/22.
//

import UIKit

class ExtensionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random
        let password = "12345KNKJNJkjnbjn@"
        let safePassword = String.init(passwordSafeString: password)
        guard let safePassword = safePassword else {
            print("Password is not safe")
            return
        }
        print(safePassword)
    }


}

extension ExtensionsViewController {
    
}

extension UIColor {
    static var random: UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

/*
 Podemos usar extensions para adicionar novas intancias ou métodos de uma forma simples. Mas não podemos adicionar novas implementações para instâncias já existentes. 
 Por exemplo, você quer transformar cada palavra que é escrita em uma forma plural dessa mesma palavra.
 Apple -> Apples
 Song -> Songs
 
 Nesse caso você vai atualizar a String no mesmo lugar, ou seja, não vai cria ruma nova string, e sim modificar aquela que já foi escrita. Pra fazer isso em um método, precisamos incluir a palavra mutating antes dele.
 
     extension String {
         mutating func pluralize() {
             código
         }
     }
 */

extension String {
    init?(passwordSafeString: String) {
        guard passwordSafeString.rangeOfCharacter(from: .uppercaseLetters) != nil && passwordSafeString.rangeOfCharacter(from: .lowercaseLetters) != nil && passwordSafeString.rangeOfCharacter(from: .punctuationCharacters) != nil && passwordSafeString.rangeOfCharacter(from: .decimalDigits) != nil else {
            return nil
        }
        
        self = passwordSafeString
    }
}

// Note: Subclasses não podem sobreescrever métodos que são definidos em uma extensão.
