fun main() {
    println("Enter the month name (e.g., January):")
    val month = readLine()!!.capitalize()

    println("Enter the day (1-31):")
    val day = readLine()!!.toInt()

    println("The season is: ${determineSeason(month, day)}")
}

fun determineSeason(month: String, day: Int): String {
    return when (month) {
        "January", "February" -> "Winter"
        "March" -> if (day < 20) "Winter" else "Spring"
        "April", "May" -> "Spring"
        "June" -> if (day < 21) "Spring" else "Summer"
        "July", "August" -> "Summer"
        "September" -> if (day < 22) "Summer" else "Fall"
        "October", "November" -> "Fall"
        "December" -> if (day < 21) "Fall" else "Winter"
        else -> "Invalid month"
    }
}
