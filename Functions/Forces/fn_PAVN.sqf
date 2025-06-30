// Generates an army and force for PAVN 
_unitHQ = selectRandom (nearestLocations [[0,0,0], ["Strategic", "NameLocal", "HistoricalSite", "CivilDefense"], worldsize * 4]);
_unitName = [
	(round (Random 300)),
	(selectRandom ["Infantry Regiment", "Area Defense Regiment", "Mechanized Regiment", "Border Guards Regiment", "Air Defense Regiment"])
];
_unitNameText = format ["%1 %2", _unitName select 0, _unitName select 1];

// Create a Marker for the unit 
_mkr = createMarkerLocal [text _unitHQ, position _unithq];
_mkr setMarkerTypeLocal "mil_flag";
_mkr setMarkerColorLocal "COLORRED";
_mkr setMarkerTextLocal _unitNameText;

_mkrAO = createMarkerLocal [_unitNameText, position _unithq];
_mkrAO setMarkerShape "ELLIPSE";
_mkrAO setMarkerColor "COLORYELLOW";
_mkrAO setMarkerAlpha 0.5;
_mkrAO setMarkerSize [(random [500, 1000, 1500]), (random [500, 1000, 1500])];
