function calc() {
  // 入力された商品価格を取得する
  const itemPrice = document.getElementById("item-price").value;

  // 返り値の計算（販売手数料）
  let calc_add_tax_price = (function calc(itemPrice) {
    let result = itemPrice * 0.1;
    return Math.floor(result);
  })(itemPrice);

  // 計算結果を表示（販売手数料）
  let add_tax_price = document.getElementById('add-tax-price');
  add_tax_price.innerHTML = calc_add_tax_price;

  // 返り値の計算（販売利益）
  let calc_profit = (function calc(itemPrice, calc_add_tax_price) {
    let result = itemPrice - calc_add_tax_price;
    return Math.floor(result);
  })(itemPrice, calc_add_tax_price);

  // 計算結果を表示（販売利益）
  let profit = document.getElementById('profit');
  profit.innerHTML = calc_profit;
}

window.addEventListener('input', calc)