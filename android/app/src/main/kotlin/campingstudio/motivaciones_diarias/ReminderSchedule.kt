package campingstudio.motivaciones_diarias

import java.util.Calendar

object ReminderSchedule {
    private val months = arrayOf("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
        "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre")

    fun nextOccurrence(hour: Int, minute: Int, now: Calendar = Calendar.getInstance()): Calendar {
        require(hour in 0..23 && minute in 0..59)
        return (now.clone() as Calendar).apply {
            set(Calendar.HOUR_OF_DAY, hour)
            set(Calendar.MINUTE, minute)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
            if (timeInMillis <= now.timeInMillis) add(Calendar.DAY_OF_YEAR, 1)
        }
    }

    fun quoteKey(date: Calendar): String =
        "${months[date.get(Calendar.MONTH)]} ${date.get(Calendar.DAY_OF_MONTH)}"
}
