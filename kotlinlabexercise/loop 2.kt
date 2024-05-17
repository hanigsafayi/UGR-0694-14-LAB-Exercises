fun main() {
    println("Enter the start of the range:")
    val startRange = readLine()!!.toInt()
    
    println("Enter the end of the range:")
    val endRange = readLine()!!.toInt()

    println("Prime numbers between $startRange and $endRange are:")

    var num = startRange
    while (num <= endRange) {
        if (isPrime(num)) {
            println(num)
        }
        num++
    }
}

fun isPrime(n: Int): Boolean {
    if (n <= 1) {
        return false
    }

    var i = 2
    while (i * i <= n) {
        if (n % i == 0) {
            return false
        }
        i++
    }

    return true
}

