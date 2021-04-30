class CountCheckbox {
  constructor() {
    this.container = document.querySelector('.selected-number')
    this.checkBoxesState = this.container.querySelectorAll('.form-control')
  }

  start() {
    this.addClickEventToChkBxs()
  }

  addClickEventToChkBxs() {
    this.checkBoxesState.forEach(chb => {
      chb.addEventListener('click', () => {
        document.querySelector('.cant-num').innerHTML = "<H3>"+document.querySelectorAll('input[type="checkbox"]:checked').length+"</H3>";
      })
    })
  }
}

document.addEventListener('turbolinks:load', () => {
  const container = document.querySelector('.selected-number')

  if(container == null) { return }

  new CountCheckbox().start()
})