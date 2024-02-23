document.addEventListener('DOMContentLoaded', function() {
    let checkCartButton = document.getElementById('checkCartButton');
    if (checkCartButton) {
        checkCartButton.addEventListener('click', amount_of_products_in_cart);
    }
});

function amount_of_products_in_cart() {
    let total = 0;
    for (let i = 0; i < localStorage.length; i++) {
        let key = localStorage.key(i);
        let value = localStorage.getItem(key);
        total += parseInt(value, 10) || 0;
    }
    alert(total);
}
