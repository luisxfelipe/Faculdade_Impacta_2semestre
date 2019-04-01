'use strict';
// adicionar um executavel ao PATH: set PATH=%PATH%;C:\your\path\here\
//Tipos Basicos
print('Tipos\n');
print(typeof(1.1)); //number
print(typeof('oi')); //string
print(typeof(true));//boolean
print(typeof(null)) //object
print(typeof(undefined)); //undefined
print();
// definir variaveis
let a = 2;
let b = 'oi';
// Strings interpoladas
print(`o valor de a: ${a}`);
// Condicionais
print('COndicionais\n')
if(true){
 print('Bloco para Verdadeiro');
}
if(false){
 print('Não será executado');
}
else{
 print('Bloco Else');
}
print()
// operador ternario
print('Operador Ternario\n')
let cond = true;
let valor = cond ? 1 : 0;
print(`Valor: ${valor}\n`);
// estruturas de repetição
print('Repeticoes\n')
let stop = true;
while(stop){
 print('faço algo');
 stop = false;
}
for(let i=0; i< 3; i++){
 print(`repeticao: ${i}`);
}
print();
// Comparações
print('Comparacoes:\n')
print(`1 == 1 -> ${1 == '1'}`);
print(`1 === 1 -> ${1 === '1'}`);
print(`1 != 1 -> ${1 != 1}`);
print()
// operações matemáticas
print(`1/0 = ${1/0}\n`);
// Definições de funções
function soma(a, b){
 return a + b;
}
print(`soma(1, 1) = ${soma(1, 1)}`);
let soma2 = function(a, b){
 return a + b;
};
print(`soma2(1, 1) = ${soma(1, 1)}`);
let soma3 = (a, b) => {
 return a + b;
};
print(`soma3(1, 1) = ${soma(1, 1)}`);
print()
// Arrays
print('Arrays\n')
let array = [4, 5, 6];
print(`array[1] = ${array[1]}`);
array.forEach((item) =>{ print(item)})
print()
//Objetos : Dicionarios Python
print('Objetos\n')
let obj = {chave1: 2, chave2: 4}
print(obj.chave1)
print(obj['chave2'])
obj['chave3'] = 10
print('chave4' in obj)
for (let chave in obj){
 print(`chave: ${chave}, valor: ${obj[chave]}`)
}
print()