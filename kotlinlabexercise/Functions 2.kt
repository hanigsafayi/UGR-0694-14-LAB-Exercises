fun factorial(n: Int): Long {
    return if (n == 0) {
        1
    } else {
        n * factorial(n - 1)
    }
}

fun main() {
    println("Enter a number to calculate its factorial:")
    val number = readLine()!!.toInt()
    val result = factorial(number)
    println("Factorial of $number = $result")
}
