window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const priceTax = inputValue * 0.1;
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = `${priceTax}`;
    const priceProfit = document.getElementById("profit");
    priceProfit.innerHTML = `${inputValue - priceTax}`;
  })
});