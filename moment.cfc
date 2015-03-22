/*
	MOMENT.CFC
	-------------------
	Inspired by (but not a strict port of) moment.js: http://momentjs.com/
	With help from: @seancorfield, @ryanguill
	And contributions (witting or otherwise) from:
	 - Ryan Heldt: http://www.ryanheldt.com/post.cfm/working-with-fuzzy-dates-and-times
*/
component displayname="moment" {

	variables.zone = "";
	variables.time = "";
	variables.utcTime = "";

	/*
		Call:
			new moment();
				-- for instance initalized to current time in current system TZ
			new moment( someTimeValue );
				-- for instance initialized to someTimeValue in current system TZ
			new moment( someTimeValue, someTZID )
				-- for instance initialized to someTimeValue in someTZID TZ
	*/
	public function init( time = now(), zone = getSystemTZ() ) {
		variables.time = (time contains '{ts') ? time : parseDateTime( arguments.time );
		variables.zone = zone;
		variables.utcTime = TZtoUTC( arguments.time, arguments.zone );
		return this;
	}

	//===========================================
	//MUTATORS
	//===========================================

	public function utc() hint="convert datetime to utc zone" {
		variables.time = variables.utcTime;
		variables.zone = "UTC";
		return this;
	}

	public function tz( zone ) hint="convert datetime to specified zone" {
		variables.time = UTCtoTZ( variables.utcTime, arguments.zone );
		variables.zone = arguments.zone;
		return this;
	}

	public function add( amount, part ){
		part = canonicalizeDatePart( part, 'dateAdd' );
		variables.time = dateAdd( part, amount, variables.time );
		variables.utcTime = TZtoUTC( variables.time, variables.zone );
		return this;
	}

	public function subtract( amount, part ){
		return add( -1 * amount, part );
	}

	//===========================================
	//STATICS
	//===========================================

	public moment function clone() hint="returns a new instance with the same time & zone" {
		return new moment( variables.time, variables.zone );
	}

	public moment function min( a, b ) hint="returns whichever moment came first" {
		if ( a.isBefore( b ) ){
			return a;
		}
		return b;
	}

	public moment function max( a, b ) hint="returns whichever moment came last" {
		if ( a.isAfter( b ) ){
			return a;
		}
		return b;
	}

	public numeric function diff( b, part = 'seconds' ) hint="get the difference between the current date and the specified date" {
		part = canonicalizeDatePart( part, 'dateDiff' );
		if (part == "L"){ //custom support for millisecond diffing... because adobe couldn't be bothered to support it themselves
			return b.epoch() - this.epoch();
		}
		return dateDiff( part, variables.utcTime, b.utc().getDateTime() );
	}

	public function getZoneOffset( required string zone ) hint="returns the offset in seconds (considering DST) of the specified zone" {
		return getTZ( arguments.zone ).getOffset( getTickCount() ) / 1000;
	}

	public string function getSystemTZ(){
		return createObject("java", "java.util.TimeZone").getDefault().getId();
	}

	public struct function getZoneTable(){
		var list = createObject("java", "java.util.TimeZone").getAvailableIDs();
		var data = {};
		for (tz in list){
			var ms = getTZ( tz ).getOffset( getTickCount() );
			data[ tz ] = readableOffset( ms );
		}
		return data;
	}

	//===========================================
	//TERMINATORS
	//===========================================

	public function format( mask ) hint="return datetime formatted with specified mask (dateTimeFormat mask rules)" {
		return dateTimeFormat( variables.time, mask );
	}

	public function from(compare) hint="returns fuzzy-date string e.g. 2 hours ago" {
		var _moment = new moment( variables.utcTime, "UTC" );
		var L = this.min( _moment, compare ).getDateTime();
		var R = this.max( _moment, compare ).getDateTime();
		var diff = 0;
		//Seconds
		if (dateDiff('s', L, R) < 60){
			return 'Just now';
		}
		//Minutes
		diff = dateDiff('n', L, R);
		if (diff < 60){
			return diff & " minute#(diff gt 1 ? 's' : '')# ago";
		}
		//Hours
		diff = dateDiff('h', L, R);
		if (diff < 24){
			return diff & " hour#(diff gt 1 ? 's' : '')# ago";
		}
		//Days
		diff = dateDiff('d', L, R);
		if (diff < 7){
			return 'Last ' & dateTimeFormat(L, 'EEEE');
		}
		//Weeks
		diff = dateDiff('ww', L, R);
		if (diff == 1){
			return "Last week";
		}else if (diff lt 4){
			return diff & " weeks ago";
		}
		//Months/Years
		diff = dateDiff("m", L, R);
		if (diff < 12){
			return diff & " month#(diff gt 1 ? 's' : '')# ago";
		}else if (diff == 12){
			return "Last year";
		}else{
			diff = dateDiff("yyyy", L, R);
			return diff & " year#(diff gt 1 ? 's' : '')# ago";
		}
	}

	public function fromNow() {
		var nnow = new moment().utc().getDateTime();
		return from( nnow );
	}

	public function epoch() hint="returns the number of milliseconds since 1/1/1970 (local). Call .utc() first to get utc epoch" {
		return variables.time.getTime();
	}

	public function getDateTime() hint="return raw datetime object in current zone" {
		return variables.time;
	}

	public string function getZone() hint="return the current zone" {
		return variables.zone;
	}

	public numeric function getCurrentOffset() hint="returns the current offset in seconds (considering DST) of the selected zone" {
		return getZoneOffset( getZone() );
	}

	//===========================================
	//QUERY
	//===========================================

	public boolean function isBefore( compare, part = 'seconds' ) {
		part = canonicalizeDatePart( part, 'dateCompare' );
		return (dateCompare( variables.utcTime, compare.utc().getDateTime(), part ) == -1);
	}

	public boolean function isSame( compare, part = 'seconds' ) {
		part = canonicalizeDatePart( part, 'dateCompare' );
		return (dateCompare( variables.utcTime, compare.utc().getDateTime(), part ) == 0);
	}

	public boolean function isAfter( compare, part = 'seconds' ) {
		part = canonicalizeDatePart( part, 'dateCompare' );
		return (dateCompare( variables.utcTime, compare.utc().getDateTime(), part ) == 1);
	}

	public boolean function isBetween( a, c, part = 'seconds' ) {
		part = canonicalizeDatePart( part, 'dateCompare' );
		return ( isBefore(c, part) && isAfter(a, part) );
	}

	public boolean function isDST() {
		var dt = createObject("java", "java.util.Date").init( this.epoch() );
		return getTZ( variables.zone ).inDayLightTime( dt );
	}

	//===========================================
	//INTERNAL HELPERS
	//===========================================

	private function getTZ( id ){
		return createObject("java", "java.util.TimeZone").getTimezone( id );
	}

	private function TZtoUTC( time, tz = getSystemTZ() ){
		var timezone = getTZ( tz );
		var ms = timezone.getOffset( getTickCount() ); //get this timezone's current offset from UTC
		var seconds = ms / 1000;
		return dateAdd( 's', -1 * seconds, time );
	}

	private function UTCtoTZ( required time, required string tz ){
		var timezone = getTZ( tz );
		var ms = timezone.getOffset( getTickCount() ); //get this timezone's current offset from UTC
		var seconds = ms / 1000;
		return dateAdd( 's', seconds, time );
	}

	private function readableOffset( offset ){
		var h = offset / 1000 / 60 / 60; //raw hours (decimal) offset
		var hh = fix( h ); //int hours
		var mm = ( hh == h ? ":00" : ":" & abs(round((h-hh)*60)) ); //hours modulo used to determine minutes
		var rep = ( h >= 0 ? "+" : "" ) & hh & mm;
		return rep;
	}

	private function canonicalizeDatePart( part, method = 'dateAdd' ){
		var isDateAdd = (lcase(method) == "dateadd");
		var isDateDiff = (lcase(method) == "datediff");
		var isDateCompare = (lcase(method) == "datecompare");

		switch( lcase(arguments.part) ){
			case "years":
			case "year":
			case "y":
				return "yyyy";
			case "quarters":
			case "quarter":
			case "q":
				if (!isDateCompare) return "q";
				throw(message="DateCompare doesn't support Quarter precision");
			case "months":
			case "month":
			case "m":
				return "m";
			case "weeks":
			case "week":
			case "w":
				if (!isDateCompare) return "ww";
				throw(message="DateCompare doesn't support Week precision");
			case "days":
			case "day":
			case "d":
				return "d";
			case "weekdays":
			case "weekday":
			case "wd":
				if (!isDateCompare) return "w";
				throw(message="DateCompare doesn't support Weekday precision");
			case "hours":
			case "hour":
			case "h":
				return "h";
			case "minutes":
			case "minute":
			case "n":
				return "n";
			case "seconds":
			case "second":
			case "s":
				return "s";
			case "milliseconds":
			case "millisecond":
			case "ms":
				if (isDateAdd) return "L";
				if (isDateDiff) return "L"; //custom support for ms diffing is provided interally, because adobe sucks
				throw(message="#method# doesn't support Millisecond precision");
		}
		throw(message="Unrecognized Date Part: `#part#`");
	}

}
