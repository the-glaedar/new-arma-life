#include "..\script_macros.hpp"
/*
    File: fn_initCop.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Cop Initialization file.
*/
player addRating 9999999;
waitUntil {!(isNull (findDisplay 46))};
_cop = false;

if (life_blacklisted) exitWith {
    ["Blacklisted",false,true] call BIS_fnc_endMission;
    sleep 30;
};

if (!(str(player) in ["cop_1","cop_2","cop_3","cop_4"])) then {
    if ((FETCH_CONST(life_coplevel) isEqualTo 0) && (FETCH_CONST(life_adminlevel) isEqualTo 0)) then {
        ["NotWhitelisted",false,true] call BIS_fnc_endMission;
        sleep 35;
    };
};

if ((str(player) in ["swat_1","swat_2","swat_3","swat_4","swat_5","swat_6","swat_7","swat_8","swat_9","swat_10","swat_11","swat_12","swat_13","swat_14","swat_15","swat_16","swat_17","swat_18","swat_19"])) then {
	if ((FETCH_CONST(life_swatlevel) isEqualTo 0) && (FETCH_CONST(life_adminlevel) isEqualTo 0)) then {
		["NotWhitelisted",false,true] call BIS_fnc_endMission;
        sleep 35;
	};
};
/*
if (!(str(player) in ["swat_1","swat_2","swat_3","swat_4","swat_5","swat_6","swat_7","swat_8","swat_9","swat_10","swat_11","swat_12","swat_13","swat_14","swat_15","swat_16","swat_17","swat_18","swat_19"])) then {
	if (!(FETCH_CONST(life_swatlevel) isEqualTo 0) && (FETCH_CONST(life_adminlevel) isEqualTo 0)) then {
		["MemberSwat",false,true] call BIS_fnc_endMission;
        sleep 35;
	};
};
*/
player setVariable ["rank",(FETCH_CONST(life_coplevel)),true];
[] call life_fnc_spawnMenu;
waitUntil{!isNull (findDisplay 38500)}; //Wait for the spawn selection to be open.
waitUntil{isNull (findDisplay 38500)}; //Wait for the spawn selection to be done.
