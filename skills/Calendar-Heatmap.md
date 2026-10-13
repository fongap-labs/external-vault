# Generic Calendar Heatmap Implementation Specification

Unify all date heatmaps in the system into two standard modes:

1. `rolling-52-weeks`: the most recent 52 weeks
2. `calendar-year`: a natural (calendar) year

Both modes share the same base logic for dates, weekdays, months and data mapping, but the time-range calculation must be strictly separated.

---

# 1. Common Base Rules

## 1. Date unit

The smallest heatmap unit is the `calendar day`.

Data keys always use `YYYY-MM-DD`, for example:

2026-09-04

Do not use timestamps as the data-matching key for the frontend heatmap.

---

## 2. Weekday layout

Always use Monday-first:

Monday
Tuesday
Wednesday
Thursday
Friday
Saturday
Sunday

Internal index:

Monday    = 0
Tuesday   = 1
Wednesday = 2
Thursday  = 3
Friday    = 4
Saturday  = 5
Sunday    = 6

JavaScript `Date.getDay()` uses:

Sunday = 0
Monday = 1
...
Saturday = 6

Therefore the conversion is required:

const weekdayIndex = (date.getDay() + 6) % 7

---

## 3. Per-day data structure

The recommended shape is:

type HeatmapDay = {
  date: string
  value: number | null
  weekIndex: number
  weekdayIndex: number
  inRange: boolean
  isFuture: boolean
}

Responsibilities are explicit:

- `weekIndex`: X axis
- `weekdayIndex`: Y axis
- `date`: data matching
- `value`: business data

Do not infer dates from DOM order.

---

# 2. Mode A: rolling-52-weeks

## Definition

"The last 52 weeks" is defined as:

> Continuously display the most recent 52 calendar weeks, including the current week.

It is not:

- the last 365 days
- the last 364 days simply split into weeks
- the current date minus one year

---

## 1. Time range

Assume:

today = 2026-09-04 Friday

With Monday-first:

currentWeekStart = 2026-08-31

First column:

firstWeekStart =
  currentWeekStart - 51 weeks

Therefore:

week 0  = firstWeekStart
...
week 51 = currentWeekStart

The grid is always strictly:

52 columns

---

## 2. Current week

For the current date:

2026-09-04

The last column is:

Monday    2026-08-31
Tuesday   2026-09-01
Wednesday 2026-09-02
Thursday  2026-09-03
Friday    2026-09-04
Saturday  2026-09-05
Sunday    2026-09-06

The future dates:

2026-09-05
2026-09-06

keep their grid positions, but:

value = null
isFuture = true

Do not treat future dates as 0 activity.

`0` and `future/null` have different meanings.

---

## 3. Left boundary

The first column is also a complete calendar week.

Therefore the first column may contain some dates earlier than the nominal 52×7-day window.

This is expected.

This mode targets:

52 complete week columns

not:

exactly 364 business dates.

---

## 4. Month labels

Month labels must not be generated from:

weekStart.getMonth()

They must be determined by:

"which week column the 1st day of each month falls in"

For example:

2026-08-31 Monday
2026-09-01 Tuesday
...
2026-09-06 Sunday

Although this week's `weekStart` is August 31,

2026-09-01

falls in this column, so the September label must be anchored to this column.

Logic should look like:

monthStart = YYYY-MM-01
weekIndex = getWeekIndex(monthStart)

Then anchor the month label to this `weekIndex`.

---

## 5. Applicable scenarios

Rolling 52 weeks suits:

- GitHub-style activity charts
- API request activity
- Token usage
- Login activity
- Call counts
- Error events
- Run status over the last year

Characteristics:

- always 52 columns
- stable page width
- scrolls over time
- focuses on "recent activity"

---

# 3. Mode B: calendar-year

## Definition

"A year" is defined as:

> January 1 through December 31 of a specified calendar year.

For example:

2026-01-01
~
2026-12-31

It is not:

today - 365 days

Nor is it:

the most recent 52 weeks.

---

## 1. Time range

Given:

year = 2026

then:

rangeStart = 2026-01-01
rangeEnd   = 2026-12-31

A leap year automatically has:

366 days

A common year has:

365 days

---

## 2. Week columns

To keep a Monday → Sunday two-dimensional layout, the week containing

January 1

is the first column, and the week containing

December 31

is the last column.

Therefore a calendar-year heatmap:

**must not be fixed at 52 columns.**

It typically has:

53 columns

Some week layouts may require:

54 visual columns

depending on:

- the week-start rule
- the position of January 1 within its week
- the position of December 31 within its week

The correct principle is:

> Compute week columns from the actual dates of the calendar year. Do not hard-code 52.

---

# 4. Leading blanks in calendar-year

For example:

2026-01-01 is a Thursday.

Then the first column is:

Monday    2025-12-29
Tuesday   2025-12-30
Wednesday 2025-12-31
Thursday  2026-01-01
Friday    2026-01-02
Saturday  2026-01-03
Sunday    2026-01-04

However, calendar-year mode counts only 2026.

Therefore:

2025-12-29
2025-12-30
2025-12-31

may keep their layout placeholders, but must have:

inRange = false
value = null

Visually they are blank/disabled cells.

Do not read 2025 data into them.

---

# 5. Trailing blanks in calendar-year

Likewise, if December 31 is not a Sunday, the last column may extend into the next year.

For example:

2027-01-01
2027-01-02
...

These dates must have:

inRange = false
value = null

They must not be counted toward the current year.

---

# 6. Current calendar year

If the displayed year is:

2026

and today is:

2026-09-04

then:

2026-09-05
~
2026-12-31

all belong to:

inRange = true
isFuture = true
value = null

Three states must be distinguished:

### Out-of-year dates

inRange = false

### In-year future dates

inRange = true
isFuture = true

### In-year valid dates

inRange = true
isFuture = false

Do not render everything simply as:

value = 0

---

# 7. Historical calendar year

If the displayed year is:

2025

while the current year is:

2026

then:

2025-01-01 ~ 2025-12-31

are all completed dates.

No future cells exist.

---

# 8. Month labels

Calendar-year mode also uses:

monthStart

as the anchor.

Compute which:

weekIndex

each of the following belongs to:

2026-01-01
2026-02-01
2026-03-01
...
2026-12-01

then display the labels Jan through Dec in the corresponding columns.

Do not generate labels from the month that each week's Monday belongs to.

---

# 9. Recommended UI

## A. rolling-52-weeks

Title:

Token activity · last 52 weeks

Horizontal axis:

about 52 fixed week columns

Month labels:

Sep Oct Nov ... Aug Sep

This is a rolling window, so the first and last months repeating is entirely normal.

For example:

Sep → Oct → ... → Aug → Sep

---

## B. calendar-year

Title:

Token activity · 2026

or:

Token activity · this year

Provide a year selector:

‹ 2025   2026 ›

Months are fixed:

Jan → Feb → ... → Dec

Suitable for annual reviews and historical comparison.

---

# 10. Core differences between the two modes

| Item | rolling-52-weeks | calendar-year |
|---|---|---|
| Time semantics | Rolling window | Calendar year |
| Start | Current week minus 51 weeks | January 1 |
| End | Current week | December 31 |
| Week columns | Fixed at 52 | Computed dynamically |
| Number of dates | About 364 days at most | 365 or 366 days |
| Crossing years | Expected | Does not cross the business year |
| Months | First and last may repeat | Fixed Jan–Dec |
| Future dates | Remaining days of the current week | Remaining dates of the current year |
| Best for | Recent activity | Annual statistics |

---

# 11. Do not conflate the two concepts

Forbidden: implementing "last 52 weeks" as

new Date(today.getFullYear() - 1, ...)

Also forbidden: implementing "calendar year" as

currentWeek - 51 weeks

Both approximate "one year", but their statistical semantics are entirely different.

---

# 12. Dates and time zones

A heatmap is date-only data.

Avoid:

new Date("2026-09-01")

followed by a mix of:

getUTCDate()
getDate()
getUTCDay()
getDay()

Provide a single shared date helper, for example:

createLocalDate(year, month, day)

or a complete set of UTC date-only helpers.

A single heatmap must use exactly one time system.

Mixing UTC and local time causes:

off-by-one dates
weekday misalignment
month misalignment

---

# 13. Recommended generic API

The API can be abstracted as:

buildCalendarHeatmap({
  mode: "rolling-52-weeks" | "calendar-year",
  year?: number,
  today: Date,
  weekStartsOn: "monday"
})

It returns:

{
  weeks: HeatmapDay[][],
  monthLabels: [
    {
      year: number,
      month: number,
      weekIndex: number
    }
  ],
  rangeStart: string,
  rangeEnd: string
}

---

# 14. Key tests

## rolling-52-weeks

today = 2026-09-04

The last column must be:

2026-08-31 Monday
2026-09-01 Tuesday
2026-09-02 Wednesday
2026-09-03 Thursday
2026-09-04 Friday
2026-09-05 Saturday (future)
2026-09-06 Sunday (future)

And:

September label → that column

Total columns:

52

---

## calendar-year

year = 2026

Must have:

rangeStart = 2026-01-01
rangeEnd   = 2026-12-31

The first column may contain:

2025-12-29 ~ 2025-12-31

but these must have:

inRange = false

Also check the placeholder dates that cross into 2027 at the end of the year.

---

## Other boundaries

The following must be tested:

- a month starting on Monday
- a month starting on Sunday
- December → January
- a common year
- a leap year
- 2028-02-29
- the current year
- a historical year
- the UTC/local boundary

---

# 15. Final principles

The two heatmaps must follow these rules:

### rolling-52-weeks

Fixed number of weeks, rolling time window.

### calendar-year

Fixed year, dynamic number of weeks.

Months are always located by:

the `weekIndex` that contains `monthStart`

Weekdays are always located by:

the real calendar date

Business data is always matched by:

`YYYY-MM-DD`

Never infer business dates from visual position.
