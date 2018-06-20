#include "..\..\..\script_macros.hpp"
/*
    File: getGangDPMission.sqf
    Author: Glaedar

    Description:
    Complete script for the gang delivery mission framework.
*/
private ["_level","_distanceModifier","_baseDistance","_hideout","_requiredPoliceCount","_missionFailOne","_missionFailTwo","_markerArray","_loadDrugs","_callCops","_drugBox","_notfBool","_notf2Bool","_exitLoop","_exitLoop2","_exitLoop3","_pickupPoint","_pickupPointPos","_pickupTemp","_isOnRoad","_dropoffPoint","_dropoffPointPos","_life_illegal_dp_task_master","_life_illegal_dp_task_pickup","_life_illegal_dp_task_dropoff","_reward","_vehicleType","_isInObjects","_gang_hideout_1","_gang_hideout_2","_vehSpawnPoint","_scriptDone"];
diag_log " ////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						 	  		 	Script created by Glaedar @ newarma.life  	        	   						 	   // ";
diag_log " //	 						Do not use without the express written permission of the author			  		 	     // ";
diag_log " //	   											     admin@newarma.life        	                   									 // ";
diag_log " ////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function getGangDPMission called.";

_requiredPoliceCount = 0;
_markerArray = LIFE_SETTINGS(getArray,"delivery_points_illegal");
_level = (FETCH_CONST(life_gangDPLevel));
_distanceModifier = _level * 0.5;
_baseDistance = 1000; //maybe change to link from CONFIG_MASTER

_exitLoop = false;
_exitLoop2 = false;
_exitLoop3 = false;
isScriptDone = false;
_isInObjects = true;
_loadDrugs = false;

// Gets the positions of the gang hideouts
_gang_hideout_1 = getMarkerPos "gang_hideout_1";
_gang_hideout_2 = getMarkerPos "gang_hideout_2";

// Initial checks before starting.
if ((playersNumber west) < _requiredPoliceCount ) exitWith { call _missionFailOne; };       //REMEMBER TO MAKE THIS <= ONCE FINISHED TESTING
if (life_gangDP_in_progress) exitWith { call _missionFailTwo; };

// Master methods for mission fail, etcetera...
_missionFailOne = {
  diag_log "::New Arma:: Mission Failed: Not enough police online";
  systemchat "Not enough police online to do this";
  hint format ["There must be at least %1 police online to be able to do this",_requiredPoliceCount];
};

_missionFailTwo = {
  diag_log "::New Arma:: Mission Failed: Delivery already in progress";
  systemchat "You already have a delivery in progress, finish the first one before attempting another";
  hint "You must finish your current delivery before doing this";
};



// Determines which vehicle is being used.
switch (_level) do {
  case 1: { _vehicleType = "C_Quadbike_01_F" }; //,2,3,4,5:
  case 6: { _vehicleType = "C_Offroad_01_F" }; //,7,8,9,10,11,12,13,14,15:
  case 16: { _vehicleType = "C_Truck_02_transport_F" }; //,17,18,19,20:
};

// Determines which hideout the player is at.
if ((player distance _gang_hideout_1) < 100) then { _hideout = 1; _vehSpawnPoint = getMarkerPos "gang_mission_spawn_1"; };
if ((player distance _gang_hideout_2) < 100) then { _hideout = 1; _vehSpawnPoint = getMarkerPos "gang_mission_spawn_2"; };

diag_log format ["::New Arma:: Player is at Gang Hideout %1, spawning vehicle on coordinates %2",_hideout,_vehSpawnPoint];

// If player acknowledges this is illegal than continue otherwise exit.
_notfBool = ["Undertaking this mission is considered illegal and local law enforcment agencies may try to stop you along the way. Continue","Alert","Continue Mission","Cancel"];
if (_notfBool isEqualTo false) exitWith { diag_log "::New Arma:: Mission Failed: Player Cancel";};

// If player agrees to terms than continue otherwise exit.
_notf2Bool = ["If your vehicle gains altitude, it will blow up and you will fail the mission. Understand?","Alert",true,true] call BIS_fnc_guiMessage;
if (_notf2Bool isEqualTo false) exitWith { diag_log "::New Arma:: Mission Failed: Player didn't agree to not air lift vehicle";};

// Selects a random pickup location.
while { _exitLoop isEqualTo false } do {
  _pickupPoint = _markerArray call BIS_fnc_selectRandom;
  _pickupPointPos = getMarkerPos _pickupPoint;

  if ((player distance _pickupPointPos) > (_baseDistance * _distanceModifier)) then {
    _pickupPoint = [[[_pickupPoint, 100]],[]] call BIS_fnc_randomPos;
    _exitLoop = true;
    diag_log format ["::New Arma:: Picking up at %1, at coordinates %2",_pickupPoint,_pickupPointPos];
  };
};

// Selects a random, clear spawn location within 100m of the pickup marker.
while {_exitLoop2 isEqualTo false} do {
  _pickupTemp = [[[_pickupPoint, 100]],[]] call BIS_fnc_randomPos;
  _isOnRoad = isOnRoad _pickupTemp;

  if (!(count (nearestObjects [_pickupTemp, [], 8]) isEqualTo 0)) then { _isInObjects = false;};
  systemchat "looping";
  if ((_isOnRoad isEqualTo false) && (_isInObjects isEqualTo false)) then {
    _exitLoop2 = true;
    diag_log format ["::New Arma:: Successfully found a clear area to spawn at %1",_pickupPoint];
  };
};


// Selects a random dropoff location.
while { _exitLoop3 isEqualTo false } do {
  _dropoffPoint = _markerArray call BIS_fnc_selectRandom;
  _dropoffPointPos = getMarkerPos _dropoffPoint;

  if ((_dropoffPointPos distance _pickupPoint) > (_baseDistance * _distanceModifier)) then {
    _exitLoop3 = true;
    diag_log format ["::New Arma:: Dropping off at %1, at coordinates %2",_dropoffPoint,_dropoffPointPos];
  };
};

// Spawns Vehicle
diag_log format ["vehicleType: %1 | vehSpawnPoint: %2",_vehicleType,_vehSpawnPoint];
_vehicle = _vehicleType createVehicle _vehSpawnPoint;

// Creates task for the player to get into the vehicle.
_life_illegal_dp_task_start = player createSimpleTask ["illegaldptaskstart"];
_life_illegal_dp_task_start setSimpleTaskDescription ["STR_NOTF_GetInVehicle","Illegal Delivery Mission",""];
_life_illegal_dp_task_start setTaskState "Assigned";
_life_illegal_dp_task_start setSimpleTaskDestination (position _vehicle);
player setCurrentTask _life_illegal_dp_task_start;
["IllegalDeliveryAssigned",[format [localize "STR_NOTF_GetInVehicle"]]] call bis_fnc_showNotification; //fix so it fetches the nearest city etc

waitUntil { (vehicle player) isEqualTo _vehicle };

// Removes the 'Get In Vehicle' task.
player removeSimpleTask _life_illegal_dp_task_start;

// Creates the master task and the first child task.
_life_illegal_dp_task_master = player createSimpleTask ["illegaldpmission"];
_life_illegal_dp_task_master setSimpleTaskDescription ["STR_NOTF_IllegalDPStart","Illegal Delivery Mission",""];
_life_illegal_dp_task_master setTaskState "Assigned";

_life_illegal_dp_task_pickup = player createSimpleTask ["illegaldpmission_pickup",_life_illegal_dp_task_master];
_life_illegal_dp_task_pickup setSimpleTaskDescription ["STR_NOTF_IllegalDPPickUp","Package Pick Up",""];
_life_illegal_dp_task_pickup setTaskState "Assigned";
_life_illegal_dp_task_pickup setSimpleTaskDestination _pickupPointPos;
player setCurrentTask _life_illegal_dp_task_pickup;
["IllegalDeliveryAssigned",[format [localize "STR_NOTF_IllegalDPPickup"]]] call bis_fnc_showNotification; //fix so it fetches the nearest city etc

// Wait until the player is within 250m before spawning the pickup object.
waitUntil { (player distance _pickupPointPos) < 250 };

drugBox = createVehicle ["Land_PlasticCase_01_large_gray_F", _pickupPointPos, [], 0, "NONE"];
diag_log format ["drugBox is sss %1",drugBox];
_loadDrugs = {
  _callCops = [1,2,3,4] call BIS_fnc_selectRandom;
  if (_callCops isEqualTo 4) then {
    hint "The police have been tipped off that illegal activity is occuring in this area, be careful";
    systemchat "The police have been tipped off about your wrongdoings, proceed with caution";
    //alert cops script.
  };
  diag_log format ["loadDrugs method called.box is %1",drugBox];

  //insert progress bar here once i can be bothered.
  deleteVehicle drugBox;
  isScriptDone = true;
};

drugBox addAction ["Load into vehicle", _loadDrugs]; //maybe make this addaction title a different color as a subtle way to tell the player that this is illegal?

waitUntil { isScriptDone isEqualTo true; };

_life_illegal_dp_task_pickup setTaskState "Succeeded";

_life_illegal_dp_task_dropoff = player createSimpleTask ["illegaldpmission_pickup",_life_illegal_dp_task_master];
_life_illegal_dp_task_dropoff setSimpleTaskDescription ["STR_NOTF_IllegalDPDropoff","Package Drop Off",""];
_life_illegal_dp_task_dropoff setTaskState "Assigned";
_life_illegal_dp_task_dropoff setSimpleTaskDestination _dropoffPointPos;
player setCurrentTask _life_illegal_dp_task_dropoff;

diag_log format ["dropoffpointpos is %1",_dropoffPointPos];

waitUntil { ((player distance _dropoffPointPos) < 15) && ((speed _vehicle) < 5 )};

drugBox2 = createVehicle ["Land_PlasticCase_01_large_gray_F", _dropoffPointPos, [], 0, "NONE"];


_life_illegal_dp_task_dropoff setTaskState "Succeeded";
_life_illegal_dp_task_master setTaskState "Succeeded";

_reward = round((_pickupPointPos distance _dropoffPointPos) ^ _level);
CASH = CASH + _reward;

hint format ["Mission Succeeded: You were paid a total of $%1",_reward];
diag_log format ["::New Arma:: %1 given to player for finishing illegal delivery mission",_reward];
diag_log "::New Arma:: Function getGangDPMission donezo.";
