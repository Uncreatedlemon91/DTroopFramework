// Adds a multiplier to time when night time. 
// 1 x During day time 
// 60 x During Night Time 

// Time based math 
/*
while {true} do {
	sleep 30;
	_hour = date select 3;
	if ((_hour >= 16) OR (_hour <= 7)) then {
		if (timeMultiplier != 60) then {
			setTimeMultiplier 60;
		};
	} else {
		if (timeMultiplier != 1) then {
			setTimeMultiplier 4;
		};
	};
};
*/

// Moon and Sun location based math 
_nightTime = 60;
_dayTime = 6;
while {true} do {
	sleep 30;
	if ((sunOrMoon =< 0.2) AND (timeMultiplier != _nightTime)) then {
		setTimeMultiplier _nightTime;
	};

	if ((sunOrMoon > 0.2) AND (timeMultiplier != _dayTime)) then {
		setTimeMultiplier _dayTime;
	};
};