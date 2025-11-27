// Attaches the marker to the group leader 
params ["_mkr", "_grp"];

_groupCount = count (units _grp);
while {_groupCount > 1} do {
	_mkr setMarkerPos (getPos leader _grp);
	sleep 5;
};