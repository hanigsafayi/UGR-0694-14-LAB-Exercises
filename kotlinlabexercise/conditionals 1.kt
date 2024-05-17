fun main() {
    println("Enter the lengths of the three sides of the triangle:")
    val a = readLine()!!.toDouble()
    val b = readLine()!!.toDouble()
    val c = readLine()!!.toDouble()

    if (isValidTriangle(a, b, c)) {
        when {
            a == b && b == c -> println("The triangle is equilateral.")
            a == b || b == c || a == c -> println("The triangle is isosceles.")
            else -> println("The triangle is scalene.")
        }
    } else {
        println("The entered lengths do not form a valid triangle.")
    }
}

fun isValidTriangle(a: Double, b: Double, c: Double): Boolean {
    return a + b > c && a + c > b && b + c > a
}
