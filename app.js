const {frutas, dinero} = require ("./frutas");


frutas.forEach(item => {
    console.log(item)
})
console.log(dinero);

var cowsay = require("cowsay");

console.log(cowsay.say({
    text : "Linsi 2021",
    e : "oO",
    T : "U "
}));