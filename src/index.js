'use strict'

require('./styles.scss')

const {Elm} = require('./Main')

// const storageKey = 'store'
// const flags = localStorage.getItem(storageKey)
const flags = null
let app = Elm.Main.init({
  flags: flags,
  node: document.getElementById('app')
})
