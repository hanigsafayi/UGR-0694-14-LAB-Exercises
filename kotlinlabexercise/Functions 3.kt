fun hasUniqueCharacters(input: String): Boolean {
    val charSet = mutableSetOf<Char>()
    for (char in input) {
        if (!charSet.add(char)) {
            return false
        }
    }
    return true
}

fun main() {
    println("Enter a string to check for unique characters:")
    val input = readLine()!!

    val result = hasUniqueCharacters(input)
    println("Does '$input' contain only unique characters? $result")
}
