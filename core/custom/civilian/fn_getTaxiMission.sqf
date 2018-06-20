#include "..\..\..\script_macros.hpp"
/*
	File: fn_getTaxiMission.sqf
	Author: Glaedar

	Description:
	Starts a taxi mission provided the necessary conditions are fufilled.

	- Selects random point from array.
	- Selects random road within radius of array point.
	- Places marker on AI location.
	- Spawns AI for taxi mission.
*/
private ["_pickupMarkerValue","_pickupMarkerPos","_startPos","_markerRoads","_pickupRoad","_pickupRoadPos""_life_taxi_task_master","_pos","_aiSpawnPoint","_aiSpawnMarkerPos","_aiSpawnMarker","_posBool","_aiType","_ai","_life_taxi_task_pickup","_vehicle","_notfBool","_failMission","_dropoff","_reward"];
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						  	  		 	Script created by Glaedar @ newarma.life  	        	   						 	  // ";
diag_log " //	 			  			Do not use without the express written permission of the author			  		 	    // ";
diag_log " //	   			  								     admin@newarma.life        	                   									// ";
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function getTaxiMission called.";

_vehicle = (vehicle player);
_aiType = LIFE_SETTINGS(getArray, "aiArray") call BIS_fnc_selectRandom;

// Mission Fail Methods
_missionFailOne = {
  systemChat "You must be in a car to start an Uber mission";
  diag_log "::New Arma:: Failed: Incorrect vehicle type";
};
_missionFailTwo = {
  systemChat "You must complete your current Uber callout before being able to start another one";
  diag_log "::New Arma:: Failed: Mission already in progress";
};
_missionFailThree = {
  systemChat "You must own necessary Uber certification to be able to start Uber missions";
  diag_log "::New Arma:: Failed: Uber license not owned";
};
_missionFailFour = {
  systemchat "Your Uber mission was cancelled because you died";
  diag_log "::New Arma:: Failed: Dead";
};

// Mission Fail Conditions
if (!(_vehicle isKindOf "Car")) exitWith {_missionFailOne};
if (life_taxi_in_progress) exitWith {_missionFailTwo};
//if (!license_civ_uber) exitWith {_missionFailThree};
[] spawn {
  waitUntil { !life_taxi_in_progress || !alive player };
    if (!alive player) then {
      call _missionFailFour;
    };
};

// Awaits player acknowledgment of antecedent conditions.
_notfBool = ["If your vehicle gains altitude, it will blow up and you will fail the mission. Understand?","Alert",true,true] call BIS_fnc_guiMessage;
if (_notfBool isEqualTo false) exitWith {};

life_taxi_in_progress = true;

_pickupPoint = LIFE_SETTINGS(getArray, "taxiArray") call BIS_fnc_selectRandom;
_pickupPointPos = getMarkerPos _pickupMarkerValue;
_startPos = position player;

// Returns all of the nearest roads.
_pickupRoad = _pickupMarkerPos nearRoads 150 call BIS_fnc_selectRandom;
_pickupRoadPos = getPos _pickupRoad;
diag_log format ["::New Arma:: The selected road's position is %1",_pickupRoadPos];
_posBool = true;

// Randomly generates positions until position !onRoad
while {_posBool isEqualTo true} do {
    _pos = [[[_pickupRoadPos,10]], []] call BIS_fnc_randomPos;
    diag_log format ["::New Arma:: Randomly generated position is %1",_pos];
    _posBool = isOnRoad _pos;

    if (_posBool isEqualTo false) then {
      _offRoad = true;
      _aiSpawnPoint = _pos;
      diag_log format ["::New Arma:: Selected pickup position is %1",_aiSpawnPoint]
    };
};

// Creates the master task
_life_taxi_task_master = player createSimpleTask ["ubermission"];
_life_taxi_task_master setSimpleTaskDescription ["STR_NOTF_TaxiStart","Uber Mission",""];
_life_taxi_task_master setTaskState "Assigned";
player setCurrentTask _life_taxi_task_master;

// Creates the child task for picking up the AI.
_life_taxi_task_pickup = player createSimpleTask ["ubermissionpickup",_life_taxi_task_master];
_life_taxi_task_pickup setSimpleTaskDescription ["","Passenger Pickup",""];
_life_taxi_task_pickup setTaskState "Assigned";
_life_taxi_task_pickup setSimpleTaskDestination _pos;
player setCurrentTask _life_taxi_task_pickup;

["TaxiAssigned",[format [localize "STR_NOTF_TaxiTask"]]] call bis_fnc_showNotification; //fix so it fetches the nearest city etc

// Waits for the player to reach within 250m of the AI spawn point.
diag_log "::New Arma:: Waiting for the player to reach within 250m of AI marker before spawning the AI";
waitUntil { player distance _aiSpawnPoint < 250 };

// Spawn AI.
_ai = group ai_group createUnit [_aiType, _aiSpawnPoint, [], 0, "NONE"];
_ai allowDamage false;
_ai disableAI "MOVE";
_ai enableSimulation false;
[_ai, "STAND", "NONE"] call BIS_fnc_ambientAnim;

diag_log format ["::New Arma:: The AI has been spawned at %1, waiting for the player to reach withini 5m of the AI",_aiSpawnPoint];

// Waits for the player to reach within 10m of the AI spawn point.
waitUntil { player distance _aiSpawnPoint < 10 && speed _vehicle < 1};

_dropoffValue = LIFE_SETTINGS(getArray, "taxiArray") call BIS_fnc_selectRandom;
_dropoffMarkerPos = getMarkerPos _dropoffValue;
_ai moveInCargo _vehicle;
diag_log "::New Arma:: AI in vehicle";

_life_taxi_task_pickup setTaskState "Succeeded";

// Creates the simple task.
_life_taxi_task_dropoff = player createSimpleTask ["taximissiondropoff", _life_taxi_task_master];
_life_taxi_task_dropoff setSimpleTaskDescription ["STR_NOTF_TaxiDropoff","Passenger Drop Off",""];
_life_taxi_task_dropoff setTaskState "Assigned";
_life_taxi_task_dropoff setSimpleTaskDestination _dropOffMarkerPos;
player setCurrentTask _life_taxi_task_dropoff;
["TaxiAssigned2",[format [localize "STR_NOTF_TaxiDropoff"]]] call bis_fnc_showNotification;

waitUntil { ((player distance _dropoffMarkerPos) < 15) && ((speed _vehicle) < 1) };

_ai action ["Eject",_vehicle];
diag_log "::New Arma:: AI exited the vehicle";
_life_illegal_dp_task_master setTaskState "Succeeded";
_life_illegal_dp_task_dropoff setTaskState "Succeeded";

_reward = ((round(_pickupPointPos distance _dropoffMarkerPos)) + (round(_startPos distance _pickupPointPos)) * (life_taxi_temp ^ life_taxi_temp));

// Receive reward and update level/s
BANK = BANK + _reward;
life_taxi_temp = life_taxi_temp + 1;

[1] call SOCK_fnc_updatePartial;
[9] call SOCK_fnc_updatePartial;



/* Pseudo
1. Player calls script
2. Select random array value from markerArray.
3. Creates array of all the roads within the raidus of the marker from marker array
4. Selects random road from _arrayValue radius with a high radius.
5. Sets road as marker spawn position.
6. Record marker spawn position. [_pp]
7. Spawn marker for local player (var1).

9. Player drives to marker.

11. Spawn delivery marker(var2) based off of large array of values. Despawn previous marker.
12. Player drives to marker.
13. AI gets out of vehicle, walks off randomly, despawns.
14. waitUntil despawned then reward money and despawn marker.
	money = (distance between var1 and var2) * variable in CONFIG_MASTER.

0 = [] spawn {
_masterArray = LIFE_SETTINGS(getArray,"markerArray"); //fetches the array
_arrayValue = _array call BIS_fnc_selectRandom; //fetches a rand value from array
diag_log format ["Random Array Location is %1", _arrayValue]; //lets me know which array value has been selected

_pp = _arrayValue; //useless but will deal with later
_ppMarker = createMarkerLocal ["Pickup Point", position _pp];
_ppMarker = setMarkerColorLocal "ColorCivilian";
_ppMarker = setMarkerTypeLocal "Mil_dot";
_ppMarker = setMarkerTextLocal "Pickup Point";

/*
//Will work on randomness later
_masterArray =  LIFE_SETTINGS(getArray,"markerArray"); //fetches the array from master config
_arrayValue = _array call BIS_fnc_selectRandom; //fetches a random value from master array
_nearestRoad =  call BIS_fnc_near
*/
