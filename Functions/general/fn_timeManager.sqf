// Adds a multiplier to time when night time. 
// 1 x During day time 
// 60 x During Night Time 
while {true} do {
	sleep 600;
	_hour = date select 3;
	if ((_hour >= 17) OR (_hour <= 8)) then {
		if (timeMultiplier != 60) then {
			setTimeMultiplier 60;
		};
	} else {
		if (timeMultiplier != 1) then {
			setTimeMultiplier 1;
		};
	};
};