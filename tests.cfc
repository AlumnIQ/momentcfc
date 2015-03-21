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
					var compare2 = dateAdd('y', 1, compare);
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
					expect( test3.add(1, 'y').getDateTime() ).toBe( compare2 );
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
					var compare2 = dateAdd('y', -1, compare);
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
					expect( test3.subtract(1, 'y').getDateTime() ).toBe( compare2 );
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
					var compare = now();
					var test1 = new moment( compare );
					var test2 = new moment( dateAdd('yyyy', 20, compare ) );
					var test3 = new moment( dateAdd('yyyy', -20, compare ) );

					expect( test1.diff( new moment(compare) ) ).toBe( 0 );
					//currently illustrating issues with datepart canonicalization
					expect( test1.diff( test2, 'years' ) ).toBe( dateDiff('yyyy', test1.getDateTime(), test2.getDateTime()) );
					expect( test1.diff( test3, 'years' ) ).toBe( dateDiff('yyyy', test1.getDateTime(), test3.getDateTime()) );
				});

				it("works for quarters, quarter, q", function(){
					var compare = now();
					var test1 = new moment( compare );
					var test2 = new moment( dateAdd('q', 20, compare ) );
					var test3 = new moment( dateAdd('q', -20, compare ) );

					expect( test1.diff( new moment(compare) ) ).toBe( 0 );
					//currently illustrating issues with datepart canonicalization
					expect( test1.diff( test2, 'quarters' ) ).toBe( dateDiff('q', test1.getDateTime(), test2.getDateTime()) );
					expect( test1.diff( test3, 'quarters' ) ).toBe( dateDiff('q', test1.getDateTime(), test3.getDateTime()) );
				});

				it("works for months, month, m", function(){
					var compare = now();
					var test1 = new moment( compare );
					var test2 = new moment( dateAdd('m', 3, compare ) );
					var test3 = new moment( dateAdd('m', -3, compare ) );

					expect( test1.diff( new moment(compare) ) ).toBe( 0 );
					//currently illustrating issues with datepart canonicalization
					expect( test1.diff( test2, 'months' ) ).toBe( dateDiff('m', test1.getDateTime(), test2.getDateTime()) );
					expect( test1.diff( test3, 'months' ) ).toBe( dateDiff('m', test1.getDateTime(), test3.getDateTime()) );
				});

				//todo: the rest of the masks
				//also todo: fix the issues with masking

				it("works for seconds, second, s", function(){
					var compare = now();
					var test1 = new moment( compare );
					var test2 = new moment( dateAdd('s', 20, compare ) );
					var test3 = new moment( dateAdd('s', -20, compare ) );

					expect( test1.diff( new moment(compare) ) ).toBe( 0 );
					//currently illustrating issues with datepart canonicalization
					expect( test1.diff( test2, 'seconds' ) ).toBe( dateDiff('s', test1.getDateTime(), test2.getDateTime()) );
					expect( test1.diff( test3, 'seconds' ) ).toBe( dateDiff('s', test1.getDateTime(), test3.getDateTime()) );
				});

			});

		});

		describe("QUERY", function(){});

		describe("RETURNS & MISC", function(){});

	}

}
