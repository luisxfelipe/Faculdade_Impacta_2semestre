'use strict'


/*
Luís Felipe Simões RA: 1801789
Gustavo Luiz RA: 1801471
*/

let n = 0
let resultado = 0

print("Digite um numero: ");

n = Number(readline())

function n_perfeito(n){
    let soma = 0
    
    for (let index = 1; index <= n; index++) {
       if (n % index == 0) {
        soma = soma + index

        
        
       }
        
    }
    return soma / 2

    
    
}

resultado = n_perfeito(n)

print("\nDividores: ")

if (resultado == n) {
    for (let index = 1; index <= n; index++) {
        if (resultado % index == 0) {
            print(resultado / index)
        }
        
    }
} else {
    print("O Numero não é perfeito")
}





