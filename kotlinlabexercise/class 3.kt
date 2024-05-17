data class Item(val name: String, val price: Double, val quantity: Int)
class ShoppingCart {
    private val items = mutableListOf<Item>()
    fun addItem(item: Item) {
        items.add(item)
    }
    fun removeItem(itemName: String) {
        items.removeIf { it.name == itemName }
    }
    fun calculateTotalPrice(): Double {
        return items.sumOf { it.price * it.quantity }
    }
    fun listItems() {
        if (items.isEmpty()) {
            println("The shopping cart is empty.")
        } else {
            println("Items in the shopping cart:")
            for (item in items) {
                println("${item.name}: ${item.quantity} -> ${item.price} each")
            }
        }
    }
}

fun main() {
    val cart = ShoppingCart()
    cart.addItem(Item("Apple", 0.99, 3))
    cart.addItem(Item("Banana", 0.59, 5))
    cart.addItem(Item("Orange", 0.79, 2))
    cart.listItems()
    val totalPrice = cart.calculateTotalPrice()
    println("Total Price: $$totalPrice")
    cart.removeItem("Banana")
    cart.listItems()
    val newTotalPrice = cart.calculateTotalPrice()
    println("Total Price after removing Banana: $$newTotalPrice")
}
