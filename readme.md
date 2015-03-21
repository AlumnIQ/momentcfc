# Moment.cfc

Inspired by moment.js, but not a strict port. With added Time Zone switchy goodness!

<a href="http://fusiongrokker.com/demo/momentcfc/tests.cfc?method=runremote"><img src="http://fusiongrokker.com/demo/momentcfc/tests.cfc?method=runremote&reporter=testShield" /></a> <img src="https://img.shields.io/badge/Adobe%20ColdFusion-11%2B-blue.svg" /> <img src="https://img.shields.io/badge/Lucee-4%2B-blue.svg" /> <img src="https://img.shields.io/badge/Railo-4%2B-blue.svg" /> <img src="https://img.shields.io/badge/awesomeness-11-orange.svg" />

CFML is all about making complex things simple, but date-math seems to have missed this boat.

| Adobe CF                                           | moment.cfc                                      |
|----------------------------------------------------|-------------------------------------------------|
| `x = now();`                                       | `x = new moment();`                             |
| `y = createDateTime( 2008, 11, 27, 6, 6, 0 );`     | `y = new moment( '2008-11-27 06:06:00' );`      |
| `x = dateAdd( 'ww', 1, x );`                       | `x.add( 1, 'week' );`                           |
| `y = dateAdd( 'n', -30, y );`                      | `y.subtract( 30, 'minutes' );`                  |
| `diff = dateDiff( 's', x, y );`                    | `diff = x.diff( y, 'seconds' );`                |
| `before = ( dateCompare( now(), x, 'h' ) == -1 );` | `before = x.isBefore( new moment(), 'hours' );` |

But before we look at the syntax awesomeness of moment.cfc, let's take a quick moment to talk about...

## Time Zones

In addition to all of the great date math you can do (with moment's better syntax), moment also has baked-in support for Time Zone functionality, using the robust underlying `java.util.TimeZone` class.

Create a timestamp in the US-Eastern time zone:

	x = new moment( '2008-11-27 6:06:00', 'America/New_York' );

When you don't pass a time zone argument, the current system time zone is used. When you don't pass a time argument, the current system time is used. `new moment()` and `new moment( '2008-11-27 6:06:00' )` and `new moment( '2008-11-27 6:06:00', 'America/New_York' )` are all equally valid.

Convert a moment's current time to UTC:

	x.utc();

And get it back as a readable string:

	x.format( 'yyyy-mm-dd hh:nna' );
	//=> 2008-11-27 10:06AM


Or instead of UTC, let's see what time that would have been in Phoenix using the `.tz()` method:

	new moment( '2008-11-27 6:06:00', 'America/New_York' ).tz( 'America/Phoenix' ).format( 'hh:nn' );
	//=> 03:06

And yes, all of the above methods (constructor as well as `.utc()` and `.tz()`) are chainable.

### Curious if your current moment is during Daylight Saving Time?

	dst = new moment().isDST();
	//=> true/false

### If you want to get a time zone's offset in seconds

This _does_ respect Daylight Saving Time:

	offset = new moment().getZoneOffset( 'Australia/Perth' );

You can get the current offset of a moment, without knowing its time zone, with `.getCurrentOffset()`:

	offset = myMoment.getCurrentOffset();

### Want the current time zone?

	zone = myMoment.getZone();
	//=> "America/New_York"

### Want to know your system time zone?

	systemZone = myMoment.getSystemTZ();
	//=> "America/New_York"

### Need a list of all world time zones and their displayable offsets?

This shows the zone's current offset, respecting their Daylight Saving Time rules:

	tbl = new moment().getZoneTable();
	//=> { "America/New_York": "-4:00", ... }

## Basic Date & Time Methods

### Add/Subtract some time

The syntax and format masks for `dateAdd()` aren't that hard to remember, but they also aren't very readable. We can do better...

	new moment().add(1, 'day').subtract(6, 'weeks');

Here's a list of all masks you can use with add/subtract:

- Years: `years`, `year`, `y`
- Quarters: `quarters`, `quarter`, `q`
- Weeks: `weeks`, `week`, `w` **\***
- Days: `days`, `day`, `d`
- Weekdays: `weekdays`, `weekday`, `wd` **\***
- Hours: `hours`, `hour`, `h`
- Minutes: `minutes`, `minute`, `n`
- Seconds: `seconds`, `second`, `s`
- Milliseconds: `milliseconds`, `millisecond`, `ms` **\*\***

**\*Deviation from the official dateAdd mask:** Adobe, in their infinite wisdom, decided to use `ww` for weeks and `w` for weekdays. Moment uses the sane alternative defined here.

**\*\*Another deviation from the official dateAdd mask:** `ms` just makes more sense than the `l` that Adobe uses.


## Compatibility

To date, development has been done against Adobe ColdFusion 11, in particular giving preference to `dateTimeFormat()` and its masks. Adobe CF10 compatibility might be possible, but probably not as easy as Lucee and Railo. Pull requests welcome in this department!

## Testing

It is assumed that you have [TestBox](http://wiki.coldbox.org/wiki/TestBox.cfm) installed. (A mapping to `/testbox` should be sufficient.) Then just navigate to `tests.cfc?method=runRemote` in your browser.

## MIT Licensed

> Copyright (c) 2015 Adam Tuttle and Contributors
>
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
