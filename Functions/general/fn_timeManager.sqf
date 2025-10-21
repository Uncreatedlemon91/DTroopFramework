// Adds a multiplier to time when night time. 
// 1 x During day time 
// 60 x During Night Time 

// Moon and Sun location based math 
_nightTime = 60;
_dayTime = 6;
while {true} do {
	sleep 30;
	if ((sunOrMoon <= 0.4) AND (timeMultiplier != _nightTime)) then {
		setTimeMultiplier _nightTime;
	};

	if ((sunOrMoon > 0.4) AND (timeMultiplier != _dayTime)) then {
		setTimeMultiplier _dayTime;
	};
};