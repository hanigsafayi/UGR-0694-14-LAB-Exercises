class Triangle(val sideA: Double, val sideB: Double, val sideC: Double) {

    fun determineType(): String {
        return when {
            isEquilateral() -> "Equilateral"
            isIsosceles() -> "Isosceles"
            isScalene() -> "Scalene"
            else -> "Invalid"
        }
    }

    private fun isEquilateral(): Boolean {
        return sideA == sideB && sideB == sideC
    }
    
    private fun isIsosceles(): Boolean {
        return sideA == sideB || sideA == sideC || sideB == sideC
    }
    
    private fun isScalene(): Boolean {
        return sideA != sideB && sideA != sideC && sideB != sideC
    }
}

fun main() {
    println("Enter the length of side A:")
    val sideA = readLine()!!.toDouble()
    
    println("Enter the length of side B:")
    val sideB = readLine()!!.toDouble()
    
    println("Enter the length of side C:")
    val sideC = readLine()!!.toDouble()

    val triangle = Triangle(sideA, sideB, sideC)
    val type = triangle.determineType()

    println("The triangle with sides $sideA, $sideB, and $sideC is $type.")
}
