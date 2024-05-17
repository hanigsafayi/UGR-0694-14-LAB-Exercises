fun main() {
    var sum = 0

    for (i in 1..50) {
        if (i % 2 == 0) {
            sum += i
        }
    }

    println("sum: $sum")
}
