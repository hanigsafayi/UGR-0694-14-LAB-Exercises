fun main() {
    println("Enter the number of hours worked:")
    val hoursWorked = readLine()!!.toDouble()
    
    println("Enter the hourly rate:")
    val hourlyRate = readLine()!!.toDouble()
    
    val totalSalary = calculateTotalSalary(hoursWorked, hourlyRate)
    
    println("The total salary is: $$totalSalary")
}

fun calculateTotalSalary(hoursWorked: Double, hourlyRate: Double): Double {
    val regularHours = if (hoursWorked > 40) 40.0 else hoursWorked
    val overtimeHours = if (hoursWorked > 40) hoursWorked - 40 else 0.0
    val overtimeRate = hourlyRate * 1.5

    return (regularHours * hourlyRate) + (overtimeHours * overtimeRate)
}
