package campingstudio.motivaciones_diarias

import org.junit.Assert.*
import org.junit.Test
import java.util.Calendar
import java.util.GregorianCalendar
import java.util.TimeZone

class ReminderScheduleTest {
    private fun date(year: Int, month: Int, day: Int, hour: Int = 8, minute: Int = 0): Calendar =
        GregorianCalendar(TimeZone.getTimeZone("America/New_York")).apply {
            clear()
            set(year, month - 1, day, hour, minute, 0)
        }

    @Test fun schedulesTodayOnlyWhenTheChosenTimeIsStillInTheFuture() {
        val now = date(2026, 12, 31, 8, 30)
        val today = ReminderSchedule.nextOccurrence(9, 0, now)
        assertEquals(31, today.get(Calendar.DAY_OF_MONTH))
        val tomorrow = ReminderSchedule.nextOccurrence(8, 30, now)
        assertEquals(2027, tomorrow.get(Calendar.YEAR))
        assertEquals(Calendar.JANUARY, tomorrow.get(Calendar.MONTH))
        assertEquals(1, tomorrow.get(Calendar.DAY_OF_MONTH))
        assertEquals(31, now.get(Calendar.DAY_OF_MONTH))
    }

    @Test fun keepsWallClockTimeAcrossDaylightSavingChanges() {
        val spring = date(2026, 3, 7, 10)
        val springNext = ReminderSchedule.nextOccurrence(9, 0, spring)
        assertEquals(9, springNext.get(Calendar.HOUR_OF_DAY))
        assertEquals(8, springNext.get(Calendar.DAY_OF_MONTH))
        assertEquals(22 * 60 * 60 * 1000L, springNext.timeInMillis - spring.timeInMillis)
        val fall = date(2026, 10, 31, 10)
        val fallNext = ReminderSchedule.nextOccurrence(9, 0, fall)
        assertEquals(9, fallNext.get(Calendar.HOUR_OF_DAY))
        assertEquals(1, fallNext.get(Calendar.DAY_OF_MONTH))
        assertEquals(24 * 60 * 60 * 1000L, fallNext.timeInMillis - fall.timeInMillis)
    }

    @Test fun selectsTheLeapDayQuote() {
        assertEquals("Febrero 29", ReminderSchedule.quoteKey(date(2028, 2, 29)))
        assertEquals("Marzo 1", ReminderSchedule.quoteKey(date(2028, 3, 1)))
    }
}
