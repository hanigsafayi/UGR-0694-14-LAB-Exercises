fun main() {
    println("Enter three different numbers:")
    val num1 = readLine()!!.toDouble()
    val num2 = readLine()!!.toDouble()
    val num3 = readLine()!!.toDouble()

    val largest = findLargest(num1, num2, num3)
    println("The largest number is: $largest")
}

fun findLargest(num1: Double, num2: Double, num3: Double): Double {
    return if (num1 > num2) {
        if (num1 > num3) {
            num1
        } else {
            num3
        }
    } else {
        if (num2 > num3) {
            num2
        } else {
            num3
        }
    }
}
