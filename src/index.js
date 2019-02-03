'use strict'

require('./styles.scss')

const resume = require('./resume.json')
const {Elm} = require('./Main')

// const storageKey = 'store'
// const flags = localStorage.getItem(storageKey)
let app = Elm.Main.init({
  flags: resume,
  node: document.getElementById('app')
})
