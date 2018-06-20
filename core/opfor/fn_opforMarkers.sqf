/*  
	File: fn_adacMarkers.sqf  
	Author: -  

	Description:  
	Marks adac on the map for other adac. Only initializes when the actual map is open.  
*/  
private["_markers","_adac"];  
_markers = [];  
_adac = [];  

sleep 0.5;  
if(visibleMap) then {  
	{if(side _x == east) then {_adac pushBack _x;}} foreach playableUnits; //Fetch list of adac / opfor  

	//Create markers  
	{  
		if(_x != player) then {  
			_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];  
			_marker setMarkerColorLocal "ColorOPFOR";  
			_marker setMarkerTypeLocal "Mil_dot";  
			_marker setMarkerTextLocal format["%1", _x getVariable["realname",name _x]];  

			_markers pushBack [_marker,_x];  
		};  
	} foreach _adac;  

	while {visibleMap} do {  
		{  
			private["_marker","_unit"];  
			_marker = _x select 0;  
			_unit = _x select 1;  
			if(!isNil "_unit" && !isNull _unit) then {  
				_marker setMarkerPosLocal (visiblePosition _unit);  
			};  
		} foreach _markers;  
		if(!visibleMap) exitWith {};  
		sleep 0.02;  
	};  

	{deleteMarkerLocal (_x select 0);} foreach _markers;  
	_markers = [];  
	_adac = [];  
};