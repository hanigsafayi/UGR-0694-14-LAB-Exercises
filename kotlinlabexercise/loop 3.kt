fun main() {
    println("Enter a number:")
    val number = readLine()!!.toInt()
    println("Is $number a palindrome? ${isPalindrome(number)}")
}

fun isPalindrome(num: Int): Boolean {
    var originalNum = num
    var reversedNum = 0

    while (originalNum > 0) {
        val digit = originalNum % 10
        reversedNum = reversedNum * 10 + digit
        originalNum /= 10
    }

    return num == reversedNum
}

