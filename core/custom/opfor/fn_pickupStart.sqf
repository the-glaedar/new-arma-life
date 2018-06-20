#include "..\..\..\script_macros.hpp"
/*
  Author: Glaedar
  File: fn_pickupStart.sqf

  Description:
  Allows OPFOR to start a pickup mission, and starts the mission on each member of opfor's client within the radius.
*/
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						  	  		 	Script created by Glaedar @ newarma.life  	        	   						 	  // ";
diag_log " //	 			  			Do not use without the express written permission of the author			  		 	    // ";
diag_log " //	   			  								     admin@newarma.life        	                   									// ";
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function pickupStart called.";
private ["_startPoint","_posArray","_currentArrayPosition","_startPoint","_crateCount","_dropPoint","_participant","_endPointMarker","_posArray","_pos","_cargo","_group","_dropQuality"];
_posArray = [];
_currentArrayPosition = 0;
_group = group player;

// Determine where caller is
if ((player distance mission_opfor_larche) < 500) then {_startPoint = "larche";};
if ((player distance mission_opfor_riviere) < 500) then {_startPoint = "riviere";};

// Determine how much loot they're getting
private _crateCount = [2,3,4,5] call BIS_fnc_selectRandom;
private _dropPoint = [1,2] call BIS_fnc_selectRandom
_dropQuality = [1,2,3] call BIS_fnc_selectRandom;

if (_startPoint isEqualTo "larche") then {
  _participant = nearestObjects [(getMarkerPos larche_radius), ["Man"], 150];
  _endPointMarker = [opfor_drop_1,opfor_drop_2] call BIS_fnc_selectRandom;

  // Starts the mission on each person's PC
  {
    if (playerSide isEqualTo east && player getVariable "activeMission" isEqualTo false && group player isEqualTo _group) then {
      ["larche",_endPoint] remoteExec life_fnc_opforPickup;
    } else {
      diag_log "::New Arma:: Failed: Couldn't accept new mission as previous mission is still active";
      hint "You must finish your current mission before starting another one";
      systemChat "You must finish your current mission before starting another one";
    };
  } forEach _participant;

  // Fills up the array with good spawn positions
  while {!(count _posArray isEqualTo _crateCount)} do {
    _pos = [[[(getMarkerPos _endPointMarker),50]], []] call BIS_fnc_randomPos;

    if ((count (nearestObjects [_pos, [], 4]) isEqualTo 0) && !(surfaceIsWater _pos)) then {
      _posArray set[_currentArrayPosition,_pos];
      _currentArrayPosition = _currentArrayPosition + 1;
    };
  };

_dropQuality = [1,2,3] call BIS_fnc_selectRandom;

  _currentArrayPosition = 0;

  while {!(count _posArray isEqualTo _currentArrayPosition)} do {
    _cargo = ["Land_Pod_Heli_Transport_04_box_F","0_CargoNet_01_ammo_F","0_CargoNet_01_ammo_F","0_CargoNet_01_ammo_F","0_CargoNet_01_ammo_F"] call BIS_fnc_selectRandom;
    _cargo createVehicle (_posArray select _currentArrayPosition);
    if (_dropQuality isEqualTo 3) then {
      _cargo addMagazineCargo ["30Rnd_65x39_caseless_green",60];
      _cargo addMagazineCargo ["150Rnd_93x64_Mag",6];
      _cargo addMagazineCargo ["Titan_AA",4];

      _cargo addWeaponCargo ["arifle_ARX_hex_F",15];
      _cargo addWeaponCargo ["MMG_01_hex_F",2];
      _cargo addWeaponCargo ["launch_O_Titan_F",2];
      _cargo addWeaponCargo ["mini_Grenade",10];

      _cargo addItemCargoGlobal ["V_PlateCarrier2_rgr_noflag_F",15];
      _cargo addItemCargoGlobal ["Laserdesignator_02",3];
      _cargo addItemCargoGlobal ["O_Static_Designator_02_weapon_F",2];
    };

    if (_dropQuality isEqualTo 2) then {
      _cargo addMagazineCargo ["30Rnd_65x39_caseless_green",60];
      _cargo addMagazineCargo ["150Rnd_93x64_Mag",0];
      _cargo addMagazineCargo ["Titan_AA",4];

      _cargo addWeaponCargo ["arifle_ARX_hex_F",15];
      _cargo addWeaponCargo ["MMG_01_hex_F",0];
      _cargo addWeaponCargo ["launch_O_Titan_F",2];
      _cargo addWeaponCargo ["mini_Grenade",10];

      _cargo addItemCargoGlobal ["V_PlateCarrier2_rgr_noflag_F",8];
      _cargo addItemCargoGlobal ["Laserdesignator_02",3];
      _cargo addItemCargoGlobal ["O_Static_Designator_02_weapon_F",2];
    };

    if (_dropQuality isEqualTo 1) then {
      _cargo addMagazineCargo ["30Rnd_65x39_caseless_green",60];
      _cargo addMagazineCargo ["150Rnd_93x64_Mag",0];
      _cargo addMagazineCargo ["Titan_AA",2];

      _cargo addWeaponCargo ["arifle_ARX_hex_F",15];
      _cargo addWeaponCargo ["MMG_01_hex_F",0];
      _cargo addWeaponCargo ["launch_O_Titan_F",1];
      _cargo addWeaponCargo ["mini_Grenade",6];

      _cargo addItemCargoGlobal ["V_PlateCarrier2_rgr_noflag_F",4];
      _cargo addItemCargoGlobal ["Laserdesignator_02",3];
      _cargo addItemCargoGlobal ["O_Static_Designator_02_weapon_F",2];
    };

    diag_log format ["::New Arma:: Drop Level %1",_dropQuality];
  };
};

if (_startPoint isEqualTo "riviere") then {
  _participant = nearestObjects [(getMarkerPos larche_radius), ["Man"], 150];
  _endPointMarker = [opfor_drop_1,opfor_drop_2] call BIS_fnc_selectRandom;

  // Starts the mission on each person's PC
  {
    if (playerSide isEqualTo east && player getVariable "activeMission" isEqualTo false && group player isEqualTo _group) then {
      life_opforRep_temp = life_opforRep_temp + 1;
    };
    ["riviere",_endPoint] call life_fnc_opforPickup;
  } forEach _participant;

  // Fills up the array with good spawn positions
  while {(count _posArray isEqualTo _crateCount)} do {
    _pos = [[[(getMarkerPos _endPointMarker),50]], []] call BIS_fnc_randomPos;

    if ((count (nearestObjects [_pos, [], 4]) isEqualTo 0) && !(surfaceIsWater _pos)) then {
      _posArray set[_currentArrayPosition,_pos];
    };
  };
};

call life_fnc_opforPickup;

private _marker = createMarker [opfor_mission_marker, _endPointMarker];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerBrush "SolidBorder";
_marker setMarkerColor "colorOPFOR";

private _marker2 = createMarker [opfor_mission_marker_title, _endPointMarker];
_marker2 setMarkerType "warning";
_marker2 setMarkerColor "colorOPFOR";

opfor_obj setVariable "pickupInProg";

[] spawn {
  waitUntil { opfor_obj getVariable "pickupInProg" isEqualTo false } exitWith {
    deleteMarker _marker1;
    deleteMarker _marker2;
  };
};
