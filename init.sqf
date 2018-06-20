/*
    File: init.sqf
    Author:

    Description:

*/
StartProgress = false;

if (hasInterface) then {
    [] execVM "briefing.sqf"; //Load Briefing
};
[] execVM "KRON_Strings.sqf";

StartProgress = true;
/*
fnc_updateMiniMap = {
_map = _this select 0;
_map ctrlMapAnimAdd [0, 0.1, player];
ctrlMapAnimCommit _map;
};

waitUntil { time > 0 };

//Show MiniMap
( [ "myMiniMap" ] call BIS_fnc_rscLayer ) cutRsc [ "myMap", "PLAIN", 1, false ];
*/
