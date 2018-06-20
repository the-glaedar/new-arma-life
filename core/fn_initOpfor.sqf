#include "..\script_macros.hpp"  
//added 16/08
/*  
    File: fn_initOpfor.sqf  
	Auteur: Apocalyptos  
	Description: Initialise le côté Adac (east).  
*/  

private["_end"];  
player addRating 99999999;  
waitUntil {!(isNull (findDisplay 46))};

// Need to add in for whitelisting opfor

if (!(str(player) in ["opfor_34","opfor_35","opfor_36","opfor_37","opfor_38","opfor_39"])) then {
    if ((FETCH_CONST(life_opforlevel) isEqualTo 0) && (FETCH_CONST(life_adminlevel) isEqualTo 0)) then {
        ["NotWhitelisted",false,true] call BIS_fnc_endMission;
        sleep 35;
    };
};

if ((str(player) in ["opfor_13","opfor_21","opfor_29","opfor_33"])) then {
	if ((FETCH_CONST(life_opforlevel) >= 3) && (FETCH_CONST(life_adminlevel) isEqualTo 0)) then {
		["NotWhitelisted",false,true] call BIS_fnc_endMission;
        sleep 35;
	};
};	


[] call life_fnc_spawnMenu;  
waitUntil{!isNull (findDisplay 38500)};//Wait for the spawn selection to be open.  
waitUntil{isNull (findDisplay 38500)};	//Wait for the spawn selection to be done.