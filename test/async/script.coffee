console.log 'script has been loaded'

window.$name = 'script'

head = document.getElementsByTagName('head')[0]

head.addAttribute 'data-name', 'script'

console.log 'best in the world!'
