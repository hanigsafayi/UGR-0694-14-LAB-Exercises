fun sortArrayAscending(arr: IntArray): IntArray {
    return arr.sortedArray()
}

fun main() {
    println("Enter the number of elements in the array:")
    val size = readLine()!!.toInt()

    val arr = IntArray(size) {
        println("Enter element ${it + 1}:")
        readLine()!!.toInt()
    }

    val sortedArr = sortArrayAscending(arr)
    println("Sorted Array in Ascending Order: ${sortedArr.joinToString()}")
}
