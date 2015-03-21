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

				it("supports masks: weekdays, weekday, and w", function(){
					var compare = now();
					var compare2 = dateAdd('w', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'weekdays').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'weekday').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 'w').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: weeks, week, and ww", function(){
					var compare = now();
					var compare2 = dateAdd('ww', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'weeks').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'week').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 'ww').getDateTime() ).toBe( compare2 );
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

				it("supports masks: milliseconds, millisecond, and l", function(){
					var compare = now();
					var compare2 = dateAdd('l', 1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.add(1, 'milliseconds').getDateTime() ).toBe( compare2 );
					expect( test2.add(1, 'millisecond').getDateTime() ).toBe( compare2 );
					expect( test3.add(1, 'l').getDateTime() ).toBe( compare2 );
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

				it("supports masks: weekdays, weekday, and w", function(){
					var compare = now();
					var compare2 = dateAdd('w', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'weekdays').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'weekday').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 'w').getDateTime() ).toBe( compare2 );
				});

				it("supports masks: weeks, week, and ww", function(){
					var compare = now();
					var compare2 = dateAdd('ww', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'weeks').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'week').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 'ww').getDateTime() ).toBe( compare2 );
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

				it("supports masks: milliseconds, millisecond, and l", function(){
					var compare = now();
					var compare2 = dateAdd('l', -1, compare);
					var test1 = new moment( compare );
					var test2 = new moment( compare );
					var test3 = new moment( compare );

					expect( test1.getDateTime() ).toBe( compare );
					expect( test1.subtract(1, 'milliseconds').getDateTime() ).toBe( compare2 );
					expect( test2.subtract(1, 'millisecond').getDateTime() ).toBe( compare2 );
					expect( test3.subtract(1, 'l').getDateTime() ).toBe( compare2 );
				});

			});

		});

		describe("STATICS", function(){

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

				it("works for weeks, week, ww", function(){
					var base = now();
					var pushA = dateAdd('ww', 5, base );
					var pushB = dateAdd('ww', -5, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 'ww' ) ).toBe( 0 );
					expect( test1.diff( test2, 'weeks' ) ).toBe( dateDiff( 'ww', base, pushA ) );
					expect( test1.diff( test2, 'week'  ) ).toBe( dateDiff( 'ww', base, pushA ) );
					expect( test1.diff( test2, 'ww'    ) ).toBe( dateDiff( 'ww', base, pushA ) );
					expect( test1.diff( test3, 'weeks' ) ).toBe( dateDiff( 'ww', base, pushB ) );
					expect( test1.diff( test3, 'week'  ) ).toBe( dateDiff( 'ww', base, pushB ) );
					expect( test1.diff( test3, 'ww'    ) ).toBe( dateDiff( 'ww', base, pushB ) );
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

				it("works for weekdays, weekday, w", function(){
					var base = now();
					var pushA = dateAdd('w', 5, base );
					var pushB = dateAdd('w', -5, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 'w' ) ).toBe( 0 );
					expect( test1.diff( test2, 'weekdays' ) ).toBe( dateDiff( 'w', base, pushA ) );
					expect( test1.diff( test2, 'weekday'  ) ).toBe( dateDiff( 'w', base, pushA ) );
					expect( test1.diff( test2, 'w'        ) ).toBe( dateDiff( 'w', base, pushA ) );
					expect( test1.diff( test3, 'weekdays' ) ).toBe( dateDiff( 'w', base, pushB ) );
					expect( test1.diff( test3, 'weekday'  ) ).toBe( dateDiff( 'w', base, pushB ) );
					expect( test1.diff( test3, 'w'        ) ).toBe( dateDiff( 'w', base, pushB ) );
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

				it("works for milliseconds, millisecond, l", function(){
					var base = now();
					var pushA = dateAdd('l', 5, base );
					var pushB = dateAdd('l', -5, base );
					var test1 = new moment( base );
					var test2 = new moment( pushA );
					var test3 = new moment( pushB );

					expect( test1.diff( new moment(base), 'l' ) ).toBe( 0 );
					expect( test1.diff( test2, 'milliseconds' ) ).toBe( pushA.getTime() - base.getTime() );
					expect( test1.diff( test2, 'millisecond'  ) ).toBe( pushA.getTime() - base.getTime() );
					expect( test1.diff( test2, 'l'            ) ).toBe( pushA.getTime() - base.getTime() );
					expect( test1.diff( test3, 'milliseconds' ) ).toBe( pushB.getTime() - base.getTime() );
					expect( test1.diff( test3, 'millisecond'  ) ).toBe( pushB.getTime() - base.getTime() );
					expect( test1.diff( test3, 'l'            ) ).toBe( pushB.getTime() - base.getTime() );
				});

			});

		});

		describe("QUERY", function(){});

		describe("RETURNS & MISC", function(){});

	}

}
