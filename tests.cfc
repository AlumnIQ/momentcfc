component extends="testbox.system.BaseSpec"{

	function run(){

		describe("INIT", function(){

			it("uses current time and local tz when no-args", function(){
				var test = new moment();
				var compare = now();
				var localTZ = createObject("java", "java.util.TimeZone").getDefault().getId();

				expect( test.getZone() ).toBe( localTZ );
				expect( test.getDateTime() ).toBe( compare );
			});

			it("uses local tz when 1-arg", function(){
				var test = new moment( now() );
				var compare = createObject("java", "java.util.TimeZone").getDefault().getId();

				expect( test.getZone() ).toBe( compare );
			});

			it("uses args when 2-args", function(){
				var compare = now();
				var test = new moment( compare, "UTC" );

				expect( test.getZone() ).toBe( "UTC" );
				expect( test.getDateTime() ).toBe( compare );
			});

			it("accepts a datetime string as the first arg", function(){
				var test = new moment( '2008-11-27 6:06' );
				expect( test ).toBeComponent();
			});

		});

		describe("MUTATORS", function(){

			describe("utc()", function(){
				it("changes the time zone to UTC and updates the time", function(){
					var compare = now();
					var test = new moment();
					test.utc();

					expect( test.getZone() ).toBe( "UTC" );
					expect( test.getDateTime() ).notToBe( compare );
				});
			});

			describe("tz()", function(){
				it("changes the timezone and the datetime", function(){
					var compare = now();
					var test = new moment( compare );
					var utc = new moment().utc();
					test.tz( "Pacific/Apia" );

					expect( test.getZone() ).toBe( "Pacific/Apia" );
					expect( test.getDateTime() ).notToBe( compare );
					expect( test.getDateTime() ).notToBe( utc.getDateTime() );
				});
			});

			describe("add()", function(){

				it("supports masks: years, year, and y", function(){
					var compare = now();
					var compare2 = dateAdd('yyyy', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'years').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'year').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 'y').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: quarters, quarter, and q", function(){
					var compare = now();
					var compare2 = dateAdd('q', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'quarters').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'quarter').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 'q').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: months, month, and m", function(){
					var compare = now();
					var compare2 = dateAdd('m', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'months').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'month').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 'm').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: days, day, and d", function(){
					var compare = now();
					var compare2 = dateAdd('d', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'days').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'day').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 'd').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: weekdays, weekday, and wd", function(){
					var compare = now();
					var compare2 = dateAdd('w', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'weekdays').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'weekday').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 'wd').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: weeks, week, and w", function(){
					var compare = now();
					var compare2 = dateAdd('ww', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'weeks').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'week').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 'w').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: hours, hour, and h", function(){
					var compare = now();
					var compare2 = dateAdd('h', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'hours').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'hour').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 'h').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: minutes, minute, and n", function(){
					var compare = now();
					var compare2 = dateAdd('n', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'minutes').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'minute').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 'n').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: seconds, second, and s", function(){
					var compare = now();
					var compare2 = dateAdd('s', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'seconds').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'second').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 's').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: milliseconds, millisecond, and ms", function(){
					var compare = now();
					var compare2 = dateAdd('l', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'milliseconds').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'millisecond').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 'ms').getDateTime() ).toBe( compare2 );
				});

			});

			describe("subtract()", function(){

				it("supports masks: years, year, and y", function(){
					var compare = now();
					var compare2 = dateAdd('yyyy', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'years').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'year').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 'y').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: quarters, quarter, and q", function(){
					var compare = now();
					var compare2 = dateAdd('q', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'quarters').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'quarter').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 'q').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: months, month, and m", function(){
					var compare = now();
					var compare2 = dateAdd('m', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'months').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'month').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 'm').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: days, day, and d", function(){
					var compare = now();
					var compare2 = dateAdd('d', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'days').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'day').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 'd').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: weekdays, weekday, and wd", function(){
					var compare = now();
					var compare2 = dateAdd('w', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'weekdays').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'weekday').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 'wd').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: weeks, week, and w", function(){
					var compare = now();
					var compare2 = dateAdd('ww', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'weeks').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'week').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 'w').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: hours, hour, and h", function(){
					var compare = now();
					var compare2 = dateAdd('h', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'hours').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'hour').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 'h').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: minutes, minute, and n", function(){
					var compare = now();
					var compare2 = dateAdd('n', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'minutes').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'minute').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 'n').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: seconds, second, and s", function(){
					var compare = now();
					var compare2 = dateAdd('s', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'seconds').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'second').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 's').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: milliseconds, millisecond, and ms", function(){
					var compare = now();
					var compare2 = dateAdd('l', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'milliseconds').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'millisecond').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 'ms').getDateTime() ).toBe( compare2 );
				});

			});

		});

		describe("STATICS", function(){

			describe("clone()", function(){
				it("returns a moment", function(){
					var test = new moment();
					var clone = test.clone();

					expect( clone ).toBeComponent();
					expect( clone.isSame( test ) ).toBeTrue();
				});
			});

			describe("min()", function(){

				it("works with winner on left", function(){
					var a = new moment().subtract(1, 'day');
					var b = new moment();

					expect( b.min( a, b ) ).toBe( a );
				});

				it("works with winner on right", function(){
					var a = new moment().subtract(1, 'day');
					var b = new moment();

					expect( b.min( b, a ) ).toBe( a );
				});

			});

			describe("max()", function(){

				it("works with winner on left", function(){
					var a = new moment().add(1, 'day');
					var b = new moment();

					expect( b.min( a, b ) ).toBe( a );
				});

				it("works with winner on right", function(){
					var a = new moment().add(1, 'day');
					var b = new moment();

					expect( b.min( b, a ) ).toBe( a );
				});

			});

			describe("diff()", function(){

				it("works for years, year, y", function(){
					var base = now();
					var pushA = dateAdd('yyyy', 20, base );
					var pushB = dateAdd('yyyy', -20, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 'y' ) ).toBe( 0 );
					expect( test1.diff( test2, 'years' ) ).toBe( dateDiff( 'yyyy', base, pushA ) );
					expect( test1.diff( test2, 'year'  ) ).toBe( dateDiff( 'yyyy', base, pushA ) );
					expect( test1.diff( test2, 'y'     ) ).toBe( dateDiff( 'yyyy', base, pushA ) );
					expect( test1.diff( test3, 'years' ) ).toBe( dateDiff( 'yyyy', base, pushB ) );
					expect( test1.diff( test3, 'year'  ) ).toBe( dateDiff( 'yyyy', base, pushB ) );
					expect( test1.diff( test3, 'y'     ) ).toBe( dateDiff( 'yyyy', base, pushB ) );
				});

				it("works for quarters, quarter, q", function(){
					var base = now();
					var pushA = dateAdd('q', 5, base );
					var pushB = dateAdd('q', -5, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 'q' ) ).toBe( 0 );
					expect( test1.diff( test2, 'quarters' ) ).toBe( dateDiff( 'q', base, pushA ) );
					expect( test1.diff( test2, 'quarter'  ) ).toBe( dateDiff( 'q', base, pushA ) );
					expect( test1.diff( test2, 'q'        ) ).toBe( dateDiff( 'q', base, pushA ) );
					expect( test1.diff( test3, 'quarters' ) ).toBe( dateDiff( 'q', base, pushB ) );
					expect( test1.diff( test3, 'quarter'  ) ).toBe( dateDiff( 'q', base, pushB ) );
					expect( test1.diff( test3, 'q'        ) ).toBe( dateDiff( 'q', base, pushB ) );
				});

				it("works for months, month, m", function(){
					var base = now();
					var pushA = dateAdd('m', 5, base );
					var pushB = dateAdd('m', -5, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 'm' ) ).toBe( 0 );
					expect( test1.diff( test2, 'months' ) ).toBe( dateDiff( 'm', base, pushA ) );
					expect( test1.diff( test2, 'month'  ) ).toBe( dateDiff( 'm', base, pushA ) );
					expect( test1.diff( test2, 'm'      ) ).toBe( dateDiff( 'm', base, pushA ) );
					expect( test1.diff( test3, 'months' ) ).toBe( dateDiff( 'm', base, pushB ) );
					expect( test1.diff( test3, 'month'  ) ).toBe( dateDiff( 'm', base, pushB ) );
					expect( test1.diff( test3, 'm'      ) ).toBe( dateDiff( 'm', base, pushB ) );
				});

				it("works for weeks, week, w", function(){
					var base = now();
					var pushA = dateAdd('ww', 5, base );
					var pushB = dateAdd('ww', -5, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 'w' ) ).toBe( 0 );
					expect( test1.diff( test2, 'weeks' ) ).toBe( dateDiff( 'ww', base, pushA ) );
					expect( test1.diff( test2, 'week'  ) ).toBe( dateDiff( 'ww', base, pushA ) );
					expect( test1.diff( test2, 'w'     ) ).toBe( dateDiff( 'ww', base, pushA ) );
					expect( test1.diff( test3, 'weeks' ) ).toBe( dateDiff( 'ww', base, pushB ) );
					expect( test1.diff( test3, 'week'  ) ).toBe( dateDiff( 'ww', base, pushB ) );
					expect( test1.diff( test3, 'w'     ) ).toBe( dateDiff( 'ww', base, pushB ) );
				});

				it("works for days, day, d", function(){
					var base = now();
					var pushA = dateAdd('m', 5, base );
					var pushB = dateAdd('m', -5, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 'd' ) ).toBe( 0 );
					expect( test1.diff( test2, 'days' ) ).toBe( dateDiff( 'd', base, pushA ) );
					expect( test1.diff( test2, 'day'  ) ).toBe( dateDiff( 'd', base, pushA ) );
					expect( test1.diff( test2, 'd'    ) ).toBe( dateDiff( 'd', base, pushA ) );
					expect( test1.diff( test3, 'days' ) ).toBe( dateDiff( 'd', base, pushB ) );
					expect( test1.diff( test3, 'day'  ) ).toBe( dateDiff( 'd', base, pushB ) );
					expect( test1.diff( test3, 'd'    ) ).toBe( dateDiff( 'd', base, pushB ) );
				});

				it("works for weekdays, weekday, wd", function(){
					var base = now();
					var pushA = dateAdd('w', 5, base );
					var pushB = dateAdd('w', -5, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 'w' ) ).toBe( 0 );
					expect( test1.diff( test2, 'weekdays' ) ).toBe( dateDiff( 'w', base, pushA ) );
					expect( test1.diff( test2, 'weekday'  ) ).toBe( dateDiff( 'w', base, pushA ) );
					expect( test1.diff( test2, 'wd'       ) ).toBe( dateDiff( 'w', base, pushA ) );
					expect( test1.diff( test3, 'weekdays' ) ).toBe( dateDiff( 'w', base, pushB ) );
					expect( test1.diff( test3, 'weekday'  ) ).toBe( dateDiff( 'w', base, pushB ) );
					expect( test1.diff( test3, 'wd'       ) ).toBe( dateDiff( 'w', base, pushB ) );
				});

				it("works for hours, hour, h", function(){
					var base = now();
					var pushA = dateAdd('h', 5, base );
					var pushB = dateAdd('h', -5, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 'h' ) ).toBe( 0 );
					expect( test1.diff( test2, 'hours' ) ).toBe( dateDiff( 'h', base, pushA ) );
					expect( test1.diff( test2, 'hour'  ) ).toBe( dateDiff( 'h', base, pushA ) );
					expect( test1.diff( test2, 'h'     ) ).toBe( dateDiff( 'h', base, pushA ) );
					expect( test1.diff( test3, 'hours' ) ).toBe( dateDiff( 'h', base, pushB ) );
					expect( test1.diff( test3, 'hour'  ) ).toBe( dateDiff( 'h', base, pushB ) );
					expect( test1.diff( test3, 'h'     ) ).toBe( dateDiff( 'h', base, pushB ) );
				});

				it("works for minutes, minute, n", function(){
					var base = now();
					var pushA = dateAdd('n', 5, base );
					var pushB = dateAdd('n', -5, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 'n' ) ).toBe( 0 );
					expect( test1.diff( test2, 'minutes' ) ).toBe( dateDiff( 'n', base, pushA ) );
					expect( test1.diff( test2, 'minute'  ) ).toBe( dateDiff( 'n', base, pushA ) );
					expect( test1.diff( test2, 'n'       ) ).toBe( dateDiff( 'n', base, pushA ) );
					expect( test1.diff( test3, 'minutes' ) ).toBe( dateDiff( 'n', base, pushB ) );
					expect( test1.diff( test3, 'minute'  ) ).toBe( dateDiff( 'n', base, pushB ) );
					expect( test1.diff( test3, 'n'       ) ).toBe( dateDiff( 'n', base, pushB ) );
				});

				it("works for seconds, second, s", function(){
					var base = now();
					var pushA = dateAdd('s', 5, base );
					var pushB = dateAdd('s', -5, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 's' ) ).toBe( 0 );
					expect( test1.diff( test2, 'seconds' ) ).toBe( dateDiff( 's', base, pushA ) );
					expect( test1.diff( test2, 'second'  ) ).toBe( dateDiff( 's', base, pushA ) );
					expect( test1.diff( test2, 's'       ) ).toBe( dateDiff( 's', base, pushA ) );
					expect( test1.diff( test3, 'seconds' ) ).toBe( dateDiff( 's', base, pushB ) );
					expect( test1.diff( test3, 'second'  ) ).toBe( dateDiff( 's', base, pushB ) );
					expect( test1.diff( test3, 's'       ) ).toBe( dateDiff( 's', base, pushB ) );
				});

				it("works for milliseconds, millisecond, ms", function(){
					var base = now();
					var pushA = dateAdd('l', 5, base );
					var pushB = dateAdd('l', -5, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 'ms' ) ).toBe( 0 );
					expect( test1.diff( test2, 'milliseconds' ) ).toBe( pushA.getTime() - base.getTime() );
					expect( test1.diff( test2, 'millisecond'  ) ).toBe( pushA.getTime() - base.getTime() );
					expect( test1.diff( test2, 'ms'           ) ).toBe( pushA.getTime() - base.getTime() );
					expect( test1.diff( test3, 'milliseconds' ) ).toBe( pushB.getTime() - base.getTime() );
					expect( test1.diff( test3, 'millisecond'  ) ).toBe( pushB.getTime() - base.getTime() );
					expect( test1.diff( test3, 'ms'           ) ).toBe( pushB.getTime() - base.getTime() );
				});

			});

			describe("getZoneOffset()", function(){
				it("returns the offset in seconds (considering DST) of the specified zone", function(){
					var test = new moment( now(), 'America/New_York' );
					var dst = test.isDST();
					expect( test.getZoneOffset( 'America/New_York' ) ).toBe( dst ? -14400 : -18000 );
				});
			});

			describe("getSystemTZ()", function(){
				it("is a simple wrapper of core Java functionality, without need of testing", function(){});
			});

			describe("getZoneTable()", function(){
				it("returns a struct", function(){
					var tbl = new moment().getZoneTable();
					expect( tbl ).toBeStruct();
					expect( tbl ).notToBeEmpty();
				});
			});

		});

		describe("TERMINATORS", function(){

			describe("format()", function(){
				it("works for custom masks", function(){
					var base = now();
					var mask = 'yyyy-mm-dd hh:nn:sstt';
					var compare = dateTimeFormat(base, mask);
					var test = new moment( base );

					expect( test.format( mask ) ).toBe( compare );
				});
				it("works with the mysql mask", function(){
					var base = now();
					var compare = dateTimeFormat( base, 'yyyy-mm-dd HH:nn:ss' );
					var test = new moment( base );

					expect( test.format( 'mysql' )).toBe( compare );
				});
				it("works with the mssql mask", function(){
					var base = now();
					var compare = dateTimeFormat(base, 'yyyy-mm-dd') & 'T' & dateTimeFormat(base, 'HH:nn:ss') & 'Z';
					var test = new moment( base );
					expect( test.format( 'mssql' )).toBe( compare );
				});
			});

			describe("from()", function(){
				var base = new moment();

				it("detects multiple years", function(){
					var test = base.clone().add( 3, 'years' ).add( 3, 'weeks' );
					var test2 = base.clone().add( 3, 'years' ).subtract( 3, 'weeks' );
					expect( test.from( base ) ).toBe( '3 years ago' );
				});

				it("detects single years", function(){
					var test = base.clone().add( 1, 'year' ).add( 3, 'weeks' );
					var test2 = base.clone().add( 1, 'year' ).subtract( 3, 'weeks' );
					expect( test.from( base ) ).toBe( 'Last year' );
				});

				it("detects multiple months", function(){
					var test = base.clone().add( 8, 'months' ).add( 3, 'days' );
					var test2 = base.clone().add( 8, 'months' ).subtract( 3, 'days' );
					expect( test.from( base ) ).toBe( '8 months ago' );
				});

				it("detects single months", function(){
					var test = base.clone().add( 1, 'months' ).add( 3, 'days' );
					var test2 = base.clone().add( 1, 'months' ).subtract( 3, 'days' );
					expect( test.from( base ) ).toBe( '1 month ago' );
				});

				it("detects multiple weeks", function(){
					var test = base.clone().add( 3, 'weeks' ).add( 2, 'hours' );
					var test2 = base.clone().add( 3, 'weeks' ).subtract( 2, 'hours' );
					expect( test.from( base ) ).toBe( '3 weeks ago' );
				});

				it("detects single weeks", function(){
					var test = base.clone().add( 1, 'weeks' ).add( 2, 'hours' );
					var test2 = base.clone().add( 1, 'weeks' ).subtract( 2, 'hours' );
					expect( test.from( base ) ).toBe( 'Last week' );
				});

				it("detects days", function(){
					var test = base.clone().add( 4, 'days' ).add( 2, 'hours' );
					var test2 = base.clone().add( 4, 'days' ).subtract( 2, 'hours' );
					expect( left(test.from( base ), 4) ).toBe( 'Last' );
					expect( right(test.from( base ), 3) ).toBe( 'day' );
				});

				it("detects multiple hours", function(){
					var test = base.clone().add( 4, 'hours' ).add( 15, 'minutes' );
					var test2 = base.clone().add( 4, 'hours' ).subtract( 15, 'minutes' );
					expect( test.from( base ) ).toBe( '4 hours ago' );
				});

				it("detects single hours", function(){
					var test = base.clone().add( 1, 'hours' ).add( 15, 'minutes' );
					var test2 = base.clone().add( 1, 'hours' ).subtract( 15, 'minutes' );
					expect( test.from( base ) ).toBe( '1 hour ago' );
				});

				it("detects multiple minutes", function(){
					var test = base.clone().add( 10, 'minutes' ).add( 15, 'seconds' );
					var test2 = base.clone().add( 10, 'minutes' ).subtract( 15, 'seconds' );
					expect( test.from( base ) ).toBe( '10 minutes ago' );
				});

				it("detects single minutes", function(){
					var test = base.clone().add( 1, 'minute' ).add( 15, 'seconds' );
					expect( test.from( base ) ).toBe( '1 minute ago' );
				});

				it("detects seconds", function(){
					var test = base.clone().add( 20, 'seconds' ).add( 100, 'ms' );
					var test2 = base.clone().add( 20, 'seconds' ).subtract( 100, 'ms' );
					expect( test.from( base ) ).toBe( 'Just now' );
				});
			});

			describe("fromNow()", function(){
				it("is just a wrapper for from, so it gets a pass",function(){});
			});

			describe("epoch()", function(){
				it("gets the correct epoch from a EST time", function(){
					var test = new moment( '2008-11-27', 'America/New_York' );
					expect( test.epoch() ).toBe( 1227762000000 );
				});

				it("gets the correct epoch from a EDT time", function(){
					var test = new moment( '2015-03-20', 'America/New_York' );
					expect( test.epoch() ).toBe( 1426824000000 );
				});

				it("gets the correct epoch from a UTC time", function(){
					var test = new moment( '2015-03-20', 'UTC' );
					expect( test.epoch() ).toBe( 1426824000000 );
				});
			});

			describe("getDateTime()", function(){
				it("returns a native time object", function(){
					var test = new moment();
					expect( left( test.getDateTime(), 3) ).toBe( '{ts' );
				});
			});

			describe("getZone()", function(){
				it("returns a string", function(){
					var test = new moment();
					expect( test.getZone() ).toBeString();
					expect( test.getZone() ).notToBeEmpty();
				});
			});

			describe("getCurrentOffset()", function(){
				it("returns the correct offset", function(){
					//this may be troublesome if tested in another zone... we'll see!
					var test = new moment( now(), 'America/New_York' );
					var dst = test.isDST();
					expect( test.getCurrentOffset() ).toBe( dst ? -14400 : -18000 );
				});
			});

		});

		describe("QUERY", function(){

			describe("isBefore", function(){
				var base = new moment();
				var clone = base.clone();
				var test = base.clone().add(10, 'years');

				it("works on true", function(){
					expect( base.isBefore( test, 'years' )).toBeTrue();
					expect( base.isBefore( test, 'months' )).toBeTrue();
					expect( base.isBefore( test, 'days' )).toBeTrue();
					expect( base.isBefore( test, 'hours' )).toBeTrue();
					expect( base.isBefore( test, 'minutes' )).toBeTrue();
					expect( base.isBefore( test, 'seconds' )).toBeTrue();
				});
				it("works on false", function(){
					expect( test.isBefore( base, 'years' )).toBeFalse();
					expect( test.isBefore( base, 'months' )).toBeFalse();
					expect( test.isBefore( base, 'days' )).toBeFalse();
					expect( test.isBefore( base, 'hours' )).toBeFalse();
					expect( test.isBefore( base, 'minutes' )).toBeFalse();
					expect( test.isBefore( base, 'seconds' )).toBeFalse();
				});
				it("works on same", function(){
					expect( test.isBefore( clone, 'years' )).toBeFalse();
					expect( test.isBefore( clone, 'months' )).toBeFalse();
					expect( test.isBefore( clone, 'days' )).toBeFalse();
					expect( test.isBefore( clone, 'hours' )).toBeFalse();
					expect( test.isBefore( clone, 'minutes' )).toBeFalse();
					expect( test.isBefore( clone, 'seconds' )).toBeFalse();
				});
			});

			describe("isAfter", function(){
				var base = new moment();
				var clone = base.clone();
				var test = base.clone().subtract(10, 'years');

				it("works on true", function(){
					expect( base.isAfter( test, 'years' )).toBeTrue();
					expect( base.isAfter( test, 'months' )).toBeTrue();
					expect( base.isAfter( test, 'days' )).toBeTrue();
					expect( base.isAfter( test, 'hours' )).toBeTrue();
					expect( base.isAfter( test, 'minutes' )).toBeTrue();
					expect( base.isAfter( test, 'seconds' )).toBeTrue();
				});
				it("works on false", function(){
					expect( test.isAfter( base, 'years' )).toBeFalse();
					expect( test.isAfter( base, 'months' )).toBeFalse();
					expect( test.isAfter( base, 'days' )).toBeFalse();
					expect( test.isAfter( base, 'hours' )).toBeFalse();
					expect( test.isAfter( base, 'minutes' )).toBeFalse();
					expect( test.isAfter( base, 'seconds' )).toBeFalse();
				});
				it("works on same", function(){
					expect( test.isAfter( clone, 'years' )).toBeFalse();
					expect( test.isAfter( clone, 'months' )).toBeFalse();
					expect( test.isAfter( clone, 'days' )).toBeFalse();
					expect( test.isAfter( clone, 'hours' )).toBeFalse();
					expect( test.isAfter( clone, 'minutes' )).toBeFalse();
					expect( test.isAfter( clone, 'seconds' )).toBeFalse();
				});
			});

			describe("isSame", function(){
				var base = new moment();

				it("works when cloned", function(){
					var clone = base.clone();
					expect( base.isSame( clone )).toBeTrue();
				});
				it("works when before", function(){
					var test = base.clone().subtract(5, 'months');
					expect( base.isSame( test )).toBeFalse();
				});
				it("works when after", function(){
					var test = base.clone().add(5, 'months');
					expect( base.isSame( test )).toBeFalse();
				});
			});

			describe("isBetween", function(){
				var x = new moment('2001-09-11');
				var y = new moment('2008-11-27');
				var z = new moment('2015-01-01');

				it("works on true", function(){
					expect( y.isBetween( x, z ) ).toBeTrue();
				});
				it("works on false", function(){
					expect( x.isBetween( y, z ) ).toBeFalse();
				});
			});

			describe("isDST", function(){
				it("is a simple wrapper of core Java functionality, without need of testing", function(){});
			});

		});

	}

}
