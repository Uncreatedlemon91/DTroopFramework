// Attaches and updates a marker on the given item 
params ["_item", "_markerType", "_markerText"];

// Create marker
_mkr = createMarker [format ["lmn_marker_%1_%2", _markerType, _item], getPos _item];
_mkr setMarkerType _markerType;
_mkr setMarkerText _markerText;
_mkr setMarkerSize [0.5, 0.5];

// Follow item with marker 
while {alive _item} do {
	_mkr setPos (getPos _item);
	sleep 0.02;
};

// Delete marker when item is destroyed
deleteMarker _mkr;