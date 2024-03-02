function something()
{
    var x = window.localStorage.getItem('aaa');

    x = x * 1 + 1;

    window.localStorage.setItem('aaa', x);

    alert(x);
}


function add_to_cart(id)
{
    var key = 'product_' + id

    var x = window.localStorage.getItem(key);

    x = x * 1 + 1;
    window.localStorage.setItem(key, x);

    update_orders_input();
    update_orders_button();

}

function cart_get_number_of_items()
{
    var count = 0;

    for(var i = 0; i < window.localStorage.length; i++)
    {
        var key = window.localStorage.key(i); // получаем ключ
        var value = window.localStorage.getItem(key); // получаем значение, аналог в ruby: hh[key] = x

        if(key.indexOf('product_') == 0)
        {
            count += value * 1;
        }
    }

    return count;
}
function update_orders_input()
{
    var orders = cart_get_orders();
    $('#orders_input').val(orders);
}

function update_orders_button()
{
    var text = 'Cart (' + cart_get_number_of_items() + ')';
    $('#orders_button').val(text);
}
function cart_get_orders()
{
    var orders = '';

    for(var i = 0; i < window.localStorage.length; i++)
    {
        var key = window.localStorage.key(i); // получаем ключ
        var value = window.localStorage.getItem(key); // получаем значение, аналог в ruby: hh[key] = x

        if(key.indexOf('product_') == 0)
        {
            orders += key + '=' + value + ',';
        }
    }

    return orders;
}

function cart_display_value(index)
{
    var key = window.localStorage.key(index);
    var value = window.localStorage.getItem(key);

    if(key && key.indexOf('product_') == 0)
    {
        $('#cart_value_' + index).text(value);
    }
}

function clear_order()
{
    window.localStorage.clear();

    update_orders_input();
    update_orders_button();

    $('#cart').text('Your cart is now empty');

}


